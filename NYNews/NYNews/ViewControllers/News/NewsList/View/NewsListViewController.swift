//
//  NewsListViewController.swift
//  NYNews
//
//  Created by Klaws Achkar on 12/7/20.
//  Copyright © 2019 Klaws Achkar. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {
    
    // The View Model that contains the business of the Controller
    var viewModel: NewsListViewModel!
    // The pull to refresh control to refresh data
    let refreshControl = UIRefreshControl()
    // The Progress View that shows while retreiving data
    var progressView: ProgressView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize the View Model
        viewModel = NewsListViewModel()
        // Set the Page Title
        navigationItem.title = L10n.NyNews.pageTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.threeDots.image,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openPeriodSelector))
        // Setup the Table View delegate and datasource
        tableView.delegate = self
        tableView.dataSource = self
        // Setup the Refresh Control
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        }
        else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        // Initialise the Progress View
        progressView = ProgressView(view)
        // Refresh Data for the first time
        displayLastSavedNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func openPeriodSelector() {
        let alert = UIAlertController(title: L10n.NyNews.ActionSheet.Title.newsPeriod, message: nil, preferredStyle: .actionSheet)
        alert.addAction(.init(title: L10n.NyNews.ActionSheet.Action.oneDay,
                              style: .default,
                              handler: { (action) in
                                self.viewModel.selectedPeriod = .oneDay
                                self.refreshData()
        }))
        alert.addAction(.init(title: L10n.NyNews.ActionSheet.Action.oneWeek,
                              style: .default,
                              handler: { (action) in
                                self.viewModel.selectedPeriod = .oneWeek
                                self.refreshData()
        }))
        alert.addAction(.init(title: L10n.NyNews.ActionSheet.Action.oneMonth,
                              style: .default,
                              handler: { (action) in
                                self.viewModel.selectedPeriod = .oneMonth
                                self.refreshData()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func displayLastSavedNews(_ refresh: Bool = true) {
        // Fill in the News List with the saved data on first load
        viewModel.displayLastSavedNews()
        if viewModel.newsList.count > 0 {
            // If the list is not empty, load the data
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
        else
        {
            if refresh {
                // If the list is Empty, refresh the data from the server
                refreshData()
            }
        }
    }
    
    @objc func refreshData() {
        // Show Progress View
        progressView.show(L10n.NyNews.refreshMessage)
        // Get latest news
        viewModel.getNews { [weak self] (success, error) in
            guard let strongSelf = self else {
                return
            }
            // Hide Progress View
            strongSelf.progressView.hide()
            if success {
                // End refreshing and reload data
                strongSelf.refreshControl.endRefreshing()
                strongSelf.tableView.reloadData()
            }
            else
            {
                // Show Error message popup alert
                let alert = UIAlertController(title: L10n.Alert.Title.error, message: error, preferredStyle: .alert)
                let okAction = UIAlertAction(title: L10n.Alert.Action.ok, style: .default, handler: { (action) in
                    strongSelf.refreshControl.endRefreshing()
                })
                alert.addAction(okAction)
                strongSelf.present(alert, animated: true)
                strongSelf.displayLastSavedNews(false)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsDetailSegue",
            let viewController = segue.destination as? NewsDetailViewController,
            let index = viewModel.selectedNewsIndex {
            // Send the selected News Detail
            viewController.viewModel = NewsDetailViewModel(viewModel.newsList[index])
        }
    }
    
}

extension NewsListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.reuseIdentifier) as! NewsListTableViewCell
        // load the News Detail
        cell.loadNewsDetail(viewModel.newsList[indexPath.row])
        return cell
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // Set the selected index in order to show the details
        viewModel.selectedNewsIndex = indexPath.row
        return indexPath
    }
}
