//
//  OnDeviceMyTrainingsService.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 07/12/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

protocol MyTrainingsService {
    func saveBooking(of: Training)
    func upcomingTrainings() -> [Training]
    func attendedTrainings() -> [Training]
    func haveBeenAlreadyBooked(training: Training) -> Bool
}

class OnDeviceMyTrainingsService: MyTrainingsService {
    
    var myTrainings = Set<Training>()
    
    func saveBooking(of training : Training) {
        myTrainings.insert(training)
    }
    
    func haveBeenAlreadyBooked(training: Training) -> Bool {
        return myTrainings.contains(training)
    }
    
    func upcomingTrainings() -> [Training] {
        
        let current = Date()
        
        return myTrainings.filter({t in
            if let tDate = t.date {
                return tDate > current
            }
            print("ERROR - Training had empty date.")
            return true
            
            
        })
    }
    
    func attendedTrainings() -> [Training] {
        
        let current = Date()

        return myTrainings.filter({t in
            if let tDate = t.date {
                return tDate <= current
            }
            print("ERROR - Training had empty date.")
            return true

        })
    }
}
