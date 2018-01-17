//
//  ProAcademyTests.swift
//  ProAcademyTests
//
//  Created by Krzysztof Sikora on 27/09/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import XCTest
import Contentful
import Interstellar

@testable import ProAcademy

class ContentfulTests: XCTestCase {
    
    let ARTISTS_COUNT = 5

    var client : Client?
    
    override func setUp() {
       client = ContentfulArtistsService.sharedInstance.client
    }
    
    override func tearDown() {
        super.tearDown()
        client = nil
    }
    
    func testArtistsDownload() {
        let service = ContentfulArtistsService.sharedInstance
        let artists = service.allArtists()
        
        XCTAssertEqual(ARTISTS_COUNT, artists?.count)
        XCTAssertEqual(artists![0].name,"Natalia Stawiarska")
        print(artists![0])
    }
    
    func testSpaceExists() {
        let expectation = XCTestExpectation(description: "Download space from Contentful")
        
        client?.fetchSpace { [weak self] (result: Result<Space>) in
            
            switch result {
            case .success(let space):
                print("==================Printing space==================")
                print("Fetched space with the name \(space.name)")
                print("===============Done Printing space================")
                XCTAssertEqual("Pro Academy", space.name)
            case .error(let error):
                print("Uh oh, something went wrong. You can do what you want with this \(error)")
                XCTFail("Could not fetch space.")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}

