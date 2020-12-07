//
//  Constants.swift
//  NYNews
//
//  Created by Klaws Achkar on 12/7/20.
//  Copyright © 2019 Klaws Achkar. All rights reserved.
//

import Foundation

class Constants {
    
    // The Base URL of the Api calls
    static let baseUrl = "http://api.nytimes.com/"
    
    // Most Popular News Api
    // @Params: 1, 7, 30 represents how far back, in days, the API returns results for
    static let getMostPopularNewsApi = "svc/mostpopular/v2/viewed/%i.json"
    
    // Api Key parameter
    static let paramsApiKey = "api-key"
    
    // Api Key for the NY Times site
    static let apiKey = "yB0GIwEXPrwsRC2ov42Xrzl7mj4xKA41"
    
}
