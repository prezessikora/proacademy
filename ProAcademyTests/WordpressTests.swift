//
//  WordpressTests.swift
//  ProAcademyTests
//
//  Created by Krzysztof Sikora on 12/12/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import XCTest
import OAuthSwift
import SwiftyJSON

@testable import ProAcademy

class WordpressTests: XCTestCase {
    
    var ws : WordpressService = WordpressService.sharedInstance
    
    static let ORDERS_URL = "http://www.pro-academy.pl/wp-json/wc/v2/orders"
    
    override class func setUp() {
        let expectation = XCTestExpectation(description: "Download")
        let observerToken = NotificationCenter.default.addObserver(forName: .ProductsDownload, object: nil, queue: nil) { notification in
            print("--------- DATA LOADED")
            expectation.fulfill()
        }
        print("--------- WAITING FOR DATA TO LOAD ")
        XCTWaiter.wait(for: [expectation], timeout: 20.0)
        print("--------- RUNNING TESTS ")
        NotificationCenter.default.removeObserver(observerToken)
    }
    
    func testIntegrationDownloadAllTrainings() {
        let allTrainings = ws.allTrainings()!
        XCTAssertEqual(allTrainings.count, 9)
    }
    
    func testIntegrastionDownloadAvailableTrainings() {
        let availableTrainings = self.ws.availableTrainings()!
        XCTAssertEqual(availableTrainings.count, 4)
    }
    
    func post(jsonObject: [String: Any], toURL url : String = ORDERS_URL) {
        send(jsonObject: jsonObject, type: .POST,toURL: url)
    }

    func put(jsonObject: [String: Any], toURL url : String = ORDERS_URL) {
        send(jsonObject: jsonObject, type: .PUT, toURL: url)
    }

    func send(jsonObject: [String: Any], type : OAuthSwiftHTTPRequest.Method, toURL url : String = ORDERS_URL) {
        
        let consumerKey = "ck_b0441b3a99da93a3400458b244befaaa61b0ee1b"
        let consumerSecret = "cs_a75e911de45a3b3253426d2eacd1387e6fdc78b2"

        var oauthswift : OAuth1Swift!
        
        oauthswift = OAuth1Swift(
            consumerKey:    consumerKey,
            consumerSecret: consumerSecret
        )
        oauthswift.client.paramsLocation = .requestURIQuery
        
        print(">>>>>>>>> Seding POST with data to \(url) :")
        var data : Data?
        do {
            let valid = JSONSerialization.isValidJSONObject(jsonObject) // true
            data = try JSONSerialization.data(withJSONObject: jsonObject, options:
                JSONSerialization.WritingOptions())
            print(prettyPrint(with: jsonObject))
        } catch _ {
            print("JSON failure")
        }
        
        print("Waiting for reply ...")
        
        let expectation = XCTestExpectation(description: "Download")
        
        oauthswift.client.request(url, method: .POST, parameters: [:], headers: [:], body: data,
            success: { response in
                print("<<<<<<<<<< RECEIVED reply: \(response.response.statusCode)")
                if let json = try? JSON(response.jsonObject()) {
                    print("Response \(json.description)")
                } else {
                    print("ERROR parsing JSON with response")
                }
                expectation.fulfill()

            },
            failure: { error in
                print("<<<<<<<<< ERROR: \(error.description)")
                expectation.fulfill()
        })

        XCTWaiter.wait(for: [expectation], timeout: 20.0)
    }
    
    func testBookTraining() {
        //post(jsonObject: createOrder())
        put(jsonObject: createOrderUpdate(),toURL: "\(WordpressTests.ORDERS_URL)/1448")
    }
    
    func prettyPrint(with json: [String:Any]) -> String {
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return string as! String
    }
    
    
    func createOrderUpdate() -> [String:Any] {
        let jsonObject: [String: Any] = [
            "customer_user_agent" : "SAFARI"
        ]
        return jsonObject
    }
    
    func createOrder() -> [String:Any] {
        
        let address = ["first_name": "Krzysztof",
                       "last_name": "Sikora",
                       "address_1": "Morelowa 58",
                       "address_2": "",
                       "city": "Karwiany",
                       "state": "",
                       "postcode": "5-200",
                       "country": "PL",
                       "email": "krzysztof.antoni.sikora@gmail.com",
                       "phone": "698 754 300"]

        
        
        let item = ["product_id": 442, "quantity": 1]
        let shippingLine : [String:Any] = ["method_id": "flat_rate", "method_title": "Flat Rate", "total": 10]
        
        //let shippingLines = [shippingLine]
        
        let jsonObject: [String: Any] = [
            "payment_method": "bacs",
            "payment_method_title": "Przelew Bankowy",
            "set_paid": false,
            //"shipping_lines": shippingLines,
            "billing": address,
            "shipping": address,
            "line_items": [item]
        ]
        return jsonObject
    }

    
}

