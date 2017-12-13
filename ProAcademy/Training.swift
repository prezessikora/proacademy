//
//  Training.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 06/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class Training : Hashable, CustomStringConvertible {
    
    let DATE_TIME_FORMAT = "yyyy/MM/dd HH:mm"
    
    var hashValue: Int {
        get {
            return id.hashValue
        }
    }

    var id: String
    var title: String
    var price: String!
    
    var inStock: Bool!
    var status: String!
    
    
    var remainingItems: Int!
    var offeredItems: Int!
    
    var fullDescription: String!
    var shortDescription: String!
    
    // missing in WP
    
    var date: Date?
    var trainer: String?
    
    public var description : String {
        return "Training [id: \(id), title: \(title), price: \(price), remaining: \(remainingItems), offeredItems: \(offeredItems)]"
    }
    
    static func ==(lhs: Training, rhs: Training) -> Bool {
        return lhs.id == rhs.id
    }

    init(id: String, title: String, trainer: String, dateString: String) {
        self.id = id
        self.title = title
        self.date = parseDate(date: dateString)
        self.trainer = trainer
    }
    
    convenience init(id: String, title: String, dateString: String) {
        self.init(id: id, title: title, trainer: "[No Trainer]", dateString: dateString)
    }
    
    func parseDate(date: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = DATE_TIME_FORMAT
        return formatter.date(from: date)
    }

    
}

