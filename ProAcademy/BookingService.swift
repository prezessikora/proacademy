//
//  BookingService.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 04/12/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit
import Alamofire

struct MailTemplate {
    var subject: String
    var body:String
}

// TODO move the template to CMS
class MailgunMailService : MailService {
    
    let RECORD_BOOKING_MAILBOX = "krzysztof.antoni.sikora@gmail.com"

    let customerConfirmationMail = MailTemplate(subject: "You booked the training", body: "We have recived your booking for training \"%@\". \n\n Congratulations!")

    let recordBookingMail = MailTemplate(subject: "Training booking", body: "We have recived  booking for training \"%@\" from: %@ .")
    
    let domain_name = "sandbox4d10a148199548c693301df628105cd8.mailgun.org"
    // TODO can we distribute the private key?
    let private_api_key = "key-f05a210040c8e3b26436c489da9a7afb"
    
    let url : String!
    
    init() {
        url = "https://api.mailgun.net/v3/"+domain_name+"/messages"
    }
    
    func credentialHeaders() -> [String:String] {
        let user = "api"
        let password = private_api_key
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        return ["Authorization": "Basic \(base64Credentials)"]
    }
    
    func prepareMailBody(to: String, subject: String, text: String) -> Parameters {
        let parameters : Parameters =
            [
                "from" : "Pro Academy <proacademy@proacademy.pl>",
                "to" : to,
                "subject" : subject,
                "text" : text
            ]
        return parameters

    }
    
    func logSentMailMessage(_ parameters: Parameters) -> String {
        return "TO: [\(parameters["to"] ?? "unknown")], SUBJECT: [\(parameters["subject"] ?? "unknown")]"
    }
    
    func sendMail(to: String, subject: String, text: String) {

        let headers = credentialHeaders()
        let parameters = prepareMailBody(to: to, subject: subject, text: text)
        
        Alamofire.request(url, method:.post, parameters: parameters, headers: headers).responseJSON{response in
            
            switch response.result {
            case .success:
                print("Mail sent successfully: \(self.logSentMailMessage(parameters))")
                if let reponse = response.value {
                    print(reponse)
                }

            case .failure(let error):
                print("Error sending mail: \(self.logSentMailMessage(parameters))")
                print("Errow was: \(error)")
                if let reponse = response.value {
                    print(reponse)
                }
            }
            
        }        
    }

    func sendCustomerConfirmationMail(for training: Training) {
        if let mail = SessionManager.shared.profile?.email {
            sendMail(to: mail, subject: customerConfirmationMail.subject, text: String(format: customerConfirmationMail.body,training.title))
        } else {
            print("Could not retrieve logged in user email.")
        }
        
    }
    
    func sendBookingNotificationMail(for training: Training) {
        if let mail = SessionManager.shared.profile?.email {
            sendMail(to: RECORD_BOOKING_MAILBOX, subject: recordBookingMail.subject, text: String(format:recordBookingMail.body,training.title,mail))
        } else {
            print("Could not retrieve logged in user email.")
        }
    }
    
}

protocol MailService {
    func sendCustomerConfirmationMail(for: Training)
    func sendBookingNotificationMail(for: Training)
}

enum BookingResult {
    case success
    case failure(String)
}

class BookingService {
    
    var mailService : MailService!
    
    func bookTraniningInWordPress() {
        
    }
    
    func userHasVerifiedEmail() -> Bool {
        
        if let emailVerified = SessionManager.shared.profile?.emailVerified {
            return emailVerified
        }
        return false

    }
    
    
    func performBooking(of training: Training, completion: (_ :BookingResult) -> Void) {
        print("Entered booking event.")
        
        guard (userHasVerifiedEmail()) else {
            completion(.failure("You need to verify your email before you can book an event."))
            return
        }
        bookTraniningInWordPress()
        
        mailService.sendBookingNotificationMail(for: training)
        mailService.sendCustomerConfirmationMail(for: training)
        
        // save to my trainings
        // display my trainings from service by date
        // block booking of booked event
        
        completion(.success)
        print("Finished booking event.")
    }
    

}
