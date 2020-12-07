//
//  ApiManager.swift
//  NYNews
//
//  Created by Klaws Achkar on 12/7/20.
//  Copyright © 2019 Klaws Achkar. All rights reserved.
//

import Foundation
import Alamofire

// This class is used for all API calls that might be needed for this app
class ApiManager: NSObject {
    
    // This is the "shared" instance of this class that is created only once
    static let shared = ApiManager()
    
    // The Alamofire Manager instance to perform all the API calls
    private var Manager : Alamofire.SessionManager!
    
    private override init() {
        super.init()
        // Instanciate the Manager
        Manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default
        )
    }
    
    func getNews(days: Int, completion: @escaping (_ success: Bool, _ response: NewsResponse?, _ Error: Error?) -> Void) {
        // Set the URL of the api call
        let url = Constants.baseUrl + String(format: Constants.getMostPopularNewsApi, days)
        // Set the parameters to be sent to the api call
        var params = Dictionary<String, Any>()
        params[Constants.paramsApiKey] = Constants.apiKey
        // Make the api call
        Manager.request(url, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: nil).responseObject { (response: DataResponse<NewsResponse>) in
            switch response.result {
            case .failure(let error):
                // Return failure and the error
                completion(false, nil, error)
                break
            case .success( _):
                if let statusCode =  response.response?.statusCode {
                    if statusCode == 200 {
                        // Only if status code is 200, return success
                        completion(true, response.value, nil)
                    }
                }
                else
                {
                    // Return failure but no error otherwise
                    completion(false, nil, nil)
                }
                break
            }
        }
    }
}
