//
//  NewsListViewModel.swift
//  NYNews
//
//  Created by Klaws Achkar on 12/7/20.
//  Copyright © 2019 Klaws Achkar. All rights reserved.
//

import Foundation

class NewsListViewModel {
    
    enum NewsPeriod: Int {
        case oneDay = 1
        case oneWeek = 7
        case oneMonth = 30
    }
    
    // The list of News that loads in the view
    var newsList: [NewsDetail]!
    // The selected index of the news to show the detail
    var selectedNewsIndex: Int?
    // Last Selected Period
    var selectedPeriod: NewsPeriod = .oneDay
    
    init() {
        // Initialize the list of News
        newsList = [NewsDetail]()
    }
    
    func getNews(completion: @escaping (_ success: Bool, _ errorMessage: String?) -> Void) {
        // Call the api to retreive the news
        ApiManager.shared.getNews(days: selectedPeriod.rawValue) { [weak self] (success, response, error) in
            guard let strongSelf = self else {
                completion(false, nil)
                return
            }
            if success {
                // Sort the News with publishedDate from newest to oldest
                strongSelf.newsList = response?.newsList.sorted(by: { (n1, n2) -> Bool in
                    // String dates can be sorted similar to alphabetical sorting
                    n1.publishedDate ?? "" > n2.publishedDate ?? ""
                })
                strongSelf.saveNewsData()
                completion(true, nil)
            }
            else
            {
                // Return the error message
                completion(false, error?.localizedDescription ?? L10n.Alert.Message.Error.generic)
            }
        }
    }
    
    func displayLastSavedNews() {
        // Get last saved news
        let savedNewsList = CoreDataManager.shared.getLastSavedNews()
        if savedNewsList.count > 0 {
            newsList = savedNewsList
        }
    }
    
    func saveNewsData() {
        CoreDataManager.shared.saveNewsData(newsList: newsList) { (success, error) in
            // No Action
        }
    }
}
