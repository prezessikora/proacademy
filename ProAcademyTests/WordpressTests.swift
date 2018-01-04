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
    
    var ws : WordpressService = WordpressService.instance
    
    let center = NotificationCenter.default
    
    var observerToken: Any!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        center.removeObserver(observer: observerToken)
        ws.loadOrRefreshData()
    }
    
    func testIntegrationDownloadAllTrainings() {
        let expectation = XCTestExpectation(description: "Download")
        var allTrainings : [Training] = [Training]()
        
        observerToken = center.addObserver(forName: .ProductsDownload, object: nil, queue: nil) { notification in
            print("--------- RECEIVED")
            allTrainings = self.ws.allTrainings()!
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(allTrainings.count, 9)
    }
    
    func testIntegrastionDownloadAvailableTrainings() {
        let expectation = XCTestExpectation(description: "Download")
        var allTrainings : [Training] = [Training]()

        observerToken = NotificationCenter.default.addObserver(forName: .ProductsDownload, object: nil, queue: nil) { notification in
            print("--------- RECEIVED")
            allTrainings = self.ws.availableTrainings()!
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(allTrainings.count, 5)
    }
    
}

