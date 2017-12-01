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

class ProAcademyTests: XCTestCase {
    
    let spaceId = "hul02y9lnm1j"
    let token = "f236c5518033231432fced6a6194e068d8449c2de8ebd9cc7b1b291f3a680325"

    var client : Client?
    
    override func setUp() {
        super.setUp()
        client = Client(spaceId: spaceId, accessToken: token)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown() 
    }
    
    func handle(error: Error) {
        print("Uh oh, something went wrong. You can do what you want with this \(error)")
    }
    
    func testArtistsService() {
        let service = ContentfulArtistsService()
        let artists = service.allArtists()
        
        XCTAssertEqual(2, artists?.count)
        XCTAssertEqual(artists![0].name,"Miss Lula")

    }
    
    func fetchSpace() {
        
        let expectation = XCTestExpectation(description: "Download space from Contentful")
        
        client?.fetchSpace { [weak self] (result: Result<Space>) in
            
            // This callback is where your network response will be handled
            // If you're going to update the UI...make sure to delegate back to the main thread.
            switch result {
            case .success(let space):
                print("==================Printing space==================")
                print("Fetched space with the name \(space.name)")
                print("===============Done Printing space================")
            case .error(let error):
                self?.handle(error: error)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)

    }
    
    func testFetchArtistsEntriesCount() {
        
        let query = Query(where: "content_type", .equals("artist"))

        var resultItems = [Entry]()
        
        let expectation = XCTestExpectation(description: "Download entries from Contentful")
        
        client?.fetchEntries(with: query) { (result: Result<ArrayResponse<Entry>>) in
            switch result {
                case .success(let entry):
                    for item in entry.items {
                        resultItems.append(item)
                    }

                case .error(let error):
                    print("Someting went wrong \(error.localizedDescription)")
            }
            
            XCTAssertEqual(2, resultItems.count)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchArtistsAllFields() {
        let query = Query(where: "content_type", .equals("artist"))
        
        var resultItems = [Entry]()
        
        let expectation = XCTestExpectation(description: "Download entries from Contentful")
        
        client?.fetchEntries(with: query) { (result: Result<ArrayResponse<Entry>>) in
            switch result {
            case .success(let entry):
                for item in entry.items {
                    resultItems.append(item)
                }
                
            case .error(let error):
                print("Someting went wrong \(error.localizedDescription)")
            }
            
            XCTAssertEqual(2, resultItems.count)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        var fetchedArtists = [Artist]()
        
        for item in resultItems {
            let link = item.fields["thumbnail"] as! Link
            
            if let asset = link.asset {
                
                let e = XCTestExpectation(description: "Download image from Contentful")

                self.client?.fetchImage(for: asset).then( { (i: UIImage)  in
                    let artist =
                        Artist(id: "x", name: item.fields["name"] as! String,
                               title: item.fields["title"] as! String,
                               quote: item.fields["quote"] as! String,
                               description: item.fields["description"] as! String,
                               image: i)
                    fetchedArtists.append(artist)
                    
                    e.fulfill()
                })
                
                wait(for: [e], timeout: 3)
            }
        }
        
        XCTAssertEqual(2, fetchedArtists.count)
        for a in fetchedArtists {
            print(a)
        }
        
    }
    
    func testSpaceExists() {
        fetchSpace()
    }
    
}

