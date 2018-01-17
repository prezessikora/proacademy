//
//  MailgunTests.swift
//  ProAcademyTests
//
//  Created by Krzysztof Sikora on 30/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import XCTest
import Alamofire

class MailgunTests: XCTestCase {
    
    func testSendTestMail() {
            let expectation = XCTestExpectation(description: "Download")
            
            let domain_name = "sandbox4d10a148199548c693301df628105cd8.mailgun.org"
            let url = "https://api.mailgun.net/v3/"+domain_name+"/messages"
            
            let private_api_key = "key-f05a210040c8e3b26436c489da9a7afb"
            
            let user = "api"
            let password = private_api_key
            let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
            let base64Credentials = credentialData.base64EncodedString(options: [])
            let headers = ["Authorization": "Basic \(base64Credentials)"]
            
            let parameters : Parameters =
                [
                    "from" : "Pro Academy <proacademy@proacademy.pl>",
                    "to" : "prezes.sikora@gmail.com",
                    "subject" : "Hello",
                    "text" : "Testing some Mailgun awesomness!"
                ]
            
            Alamofire.request(url, method:.post, parameters: parameters, headers: headers).responseJSON{response in

                switch response.result {
                case .success:
                    print("--- Validation Successful")
                    print(response.value)
                    print("---")
                case .failure(let error):
                    print("--- Error")
                    print(error)
                    print("---")
                }
                expectation.fulfill()

            }
            
            wait(for: [expectation], timeout: 2.0)
    }
    

    
}
