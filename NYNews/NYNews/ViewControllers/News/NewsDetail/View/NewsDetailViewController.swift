//
//  NewsDetailViewController.swift
//  NYNews
//
//  Created by Klaws Achkar on 12/7/20.
//  Copyright © 2019 Klaws Achkar. All rights reserved.
//

import UIKit
import Kingfisher

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var viewsImageView: UIImageView! {
        didSet {
            viewsImageView.image = Asset.viewIcon.image
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    var viewModel: NewsDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load page Title
        navigationItem.title = L10n.NewsDetail.pageTitle
        // Load News Detail
        loadNewsDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadNewsDetail() {
        if let newsDetail = viewModel.newsDetail {
            // Check if the image URL exists and valid
            if let imageUrl = newsDetail.imageUrl,
                let url = URL(string: imageUrl),
                let size = newsDetail.imageSize {
                // Get the image size ratio
                let ratio = newsImage.bounds.width / size.width
                // Set up kingfisher image downloader
                let processor = ResizingImageProcessor(referenceSize: size, mode: .aspectFill)
                newsImage.kf.indicatorType = .activity
                newsImage.kf.setImage(with: url,
                                 placeholder: nil,
                                 options: [
                                    .processor(processor),
                                    .scaleFactor(UIScreen.main.scale),
                                    .transition(.fade(0.3)),
                                    .cacheOriginalImage
                ], progressBlock: nil) { (image, error, cache, url) in
                    if error != nil {
                        // Set the image background white
                        self.newsImage.backgroundColor = UIColor.white
                        // Set the error image
                        self.newsImage.image = Asset.errorImage.image
                        // Set the content mode to center
                        self.newsImage.contentMode = .center
                    }
                    else
                    {
                        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                            // Set the image height according to the ratio
                            self.imageHeight.constant = size.height * ratio
                        }, completion: { (done) in
                            // Set the image background clear
                            self.newsImage.backgroundColor = UIColor.clear
                            // Set the content mode to Aspect Fill
                            self.newsImage.contentMode = .scaleAspectFill
                        })
                    }
                }
            }
            // Set the number of Views
            viewsLabel.text = L10n.NewsDetail.nbViews(newsDetail.views ?? 0)
            // Set the News detail properties
            byLineLabel.text = newsDetail.byline
            titleLabel.text = newsDetail.title
            dateLabel.text = newsDetail.publishedDate
            tagsLabel.text = newsDetail.tags?.joined(separator: " | ")
            descriptionLabel.text = newsDetail.description
            sourceLabel.text = newsDetail.source
        }
    }
    
    @IBAction func viewMorePressed(_ sender: Any) {
        if let urlString = viewModel.newsDetail.url,
            let url = URL(string: urlString) {
            // Open the URL in the external browser
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
