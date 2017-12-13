//
//  WordpressTests.swift
//  ProAcademyTests
//
//  Created by Krzysztof Sikora on 12/12/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import XCTest
import OAuthSwift


class WordpressTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReadProducts() {
        
        let expectation = XCTestExpectation(description: "Download")
        
        let consumerKey = "ck_b0441b3a99da93a3400458b244befaaa61b0ee1b"
        let consumerSecret = "cs_a75e911de45a3b3253426d2eacd1387e6fdc78b2"
        
        let oauthswift = OAuth1Swift(
            consumerKey:    consumerKey,
            consumerSecret: consumerSecret
        )
        oauthswift.client.paramsLocation = .requestURIQuery
        // do your HTTP request without authorize
        
     
        oauthswift.client.get("http://www.pro-academy.pl/wp-json/wc/v2/products",
            success: { response in
                
                do {
                    let json = try response.jsonObject() as! [Any]
                    print("Downloaded \(json.count) products")
                    XCTAssertGreaterThanOrEqual(json.count, 1)
                    for p in json {
                        let product = p as! [String:Any]
                        
                        let status = product["status"] as! String
                        let id = product["id"]
                        if let productName = product["name"] as? String {
                            if status == "publish" {
                                print(productName)
                            }
                        }
                        
                        let soldAmount = product["total_sales"]
                        let stockQuantity = product["stock_quantity"]
                        
                        let price = product["price"]
                        

                        let description = product["description"]
                        let shortDescription = product["short_description"]
                        
                        
                        
                    }
                    
                } catch {
                    XCTFail("ERROR paring JSON")
                }
                
                
                expectation.fulfill()
            },
            failure: { error in
                XCTFail("ERROR making request \(error.localizedDescription)")
                expectation.fulfill()
                
            }
        )
        self.wait(for: [expectation], timeout: 20.0)
        
        
    }
    
    
}
