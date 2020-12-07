//
//  NYNewsTests.swift
//  NYNewsTests
//
//  Created by Klaws Achkar on 12/7/20.
//  Copyright © 2019 Klaws Achkar. All rights reserved.
//

import XCTest
@testable import NYNews

class NYNewsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetNewsForOneDay() {
        ApiManager.shared.getNews(days: 1) { (success, response, error) in
            if success {
                XCTAssert(success, "GetNewsForOneDay Completed successfully")
                if let newsList = response?.newsList {
                    CoreDataManager.shared.saveNewsData(newsList: newsList, completion: { (success, error) in
                        if success {
                            XCTAssert(success, "Saving Data Completed successfully")
                        }
                        else
                        {
                            XCTFail("Saving Data failed")
                        }
                    })
                }
            }
            else
            {
                XCTFail("GetNewsForOneDay failed")
            }
        }
    }

    func testGetNewsForSevenDays() {
        ApiManager.shared.getNews(days: 7) { (success, response, error) in
            if success {
                XCTAssert(success, "testGetNewsForSevenDays Completed successfully")
                if let newsList = response?.newsList {
                    CoreDataManager.shared.saveNewsData(newsList: newsList, completion: { (success, error) in
                        if success {
                            XCTAssert(success, "Saving Data Completed successfully")
                        }
                        else
                        {
                            XCTFail("Saving Data failed")
                        }
                    })
                }
            }
            else
            {
                XCTFail("testGetNewsForSevenDays failed")
            }
        }
    }
    
    func testGetNewsForThirtyDays() {
        ApiManager.shared.getNews(days: 30) { (success, response, error) in
            if success {
                XCTAssert(success, "testGetNewsForThirtyDays Completed successfully")
                if let newsList = response?.newsList {
                    CoreDataManager.shared.saveNewsData(newsList: newsList, completion: { (success, error) in
                        if success {
                            XCTAssert(success, "Saving Data Completed successfully")
                        }
                        else
                        {
                            XCTFail("Saving Data failed")
                        }
                    })
                }
            }
            else
            {
                XCTFail("testGetNewsForThirtyDays failed")
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
