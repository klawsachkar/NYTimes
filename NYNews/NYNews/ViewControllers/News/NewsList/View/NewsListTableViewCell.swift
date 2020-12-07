//
//  NewsListTableViewCell.swift
//  NYNews
//
//  Created by Klaws Achkar on 12/7/20.
//  Copyright © 2019 Klaws Achkar. All rights reserved.
//

import UIKit
import Kingfisher

class NewsListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "newsListCell"
    
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        // Set the thumbnail image corner radius and border
        thumbnailImage.layer.cornerRadius = 5
        thumbnailImage.layer.borderColor = UIColor.lightGray.cgColor
        thumbnailImage.layer.borderWidth = 1
    }
    
    func loadNewsDetail(_ newsDetail: NewsDetail) {
        // Set the News detail properties
        byLineLabel.text = newsDetail.byline
        titleLabel.text = newsDetail.title
        dateLabel.text = newsDetail.publishedDate
        // Check if the thumbnail URL exists and valid
        if let imageUrl = newsDetail.thumbnailUrl,
            let url = URL(string: imageUrl) {
            let size = thumbnailImage.bounds.size
            // Set up kingfisher image downloader
            let processor = ResizingImageProcessor(referenceSize: size, mode: .aspectFill)
            thumbnailImage.kf.indicatorType = .activity
            thumbnailImage.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [
                                    .processor(processor),
                                    .scaleFactor(UIScreen.main.scale),
                                    .transition(.fade(0.3)),
                                    .cacheOriginalImage
            ], progressBlock: nil) { (image, error, cache, url) in
                if error != nil {
                    // Set the image background white
                    self.thumbnailImage.backgroundColor = UIColor.white
                    // Set the error image
                    self.thumbnailImage.image = Asset.errorImage.image
                    // Set the content mode to center
                    self.thumbnailImage.contentMode = .center
                }
                else
                {
                    // Set the image background clear
                    self.thumbnailImage.backgroundColor = UIColor.clear
                    // Set the content mode to Aspect Fill
                    self.thumbnailImage.contentMode = .scaleAspectFill
                }
            }
        }
    }
}
