//
//  WordpressTests.swift
//  ProAcademyTests
//
//  Created by Krzysztof Sikora on 12/12/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import XCTest
import OAuthSwift
@testable import ProAcademy

class WordpressTests: XCTestCase {
    
    var ws : WordpressService = WordpressService.sharedInstance
    
    override class func setUp() {
        let expectation = XCTestExpectation(description: "Download")
        let observerToken = NotificationCenter.default.addObserver(forName: .ProductsDownload, object: nil, queue: nil) { notification in
            print("--------- DATA LOADED")
            expectation.fulfill()
        }
        print("--------- WAITING FOR DATA TO LOAD ")
        XCTWaiter.wait(for: [expectation], timeout: 20.0)
        print("--------- RUNNING TESTS ")
        NotificationCenter.default.removeObserver(observer: observerToken)
    }
    
    func testIntegrationDownloadAllTrainings() {
        let allTrainings = ws.allTrainings()!
        XCTAssertEqual(allTrainings.count, 9)
    }
    
    func testIntegrastionDownloadAvailableTrainings() {
        let availableTrainings = self.ws.availableTrainings()!
        XCTAssertEqual(availableTrainings.count, 5)
    }
    
}

