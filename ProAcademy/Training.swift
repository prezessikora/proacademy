//
//  Training.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 06/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class Training : Hashable {
    
    let DATE_TIME_FORMAT = "yyyy/MM/dd HH:mm"
    
    var hashValue: Int {
        get {
            return id.hashValue
        }
    }
    
    var id: String
    var title: String
    var trainer: String
    var date: Date?
    
    static func ==(lhs: Training, rhs: Training) -> Bool {
        return lhs.id == rhs.id
    }

    init(id: String, title: String, trainer: String, dateString: String) {
        self.id = id
        self.title = title
        self.trainer = trainer
        self.date = parseDate(date: dateString)
    }
    
    func parseDate(date: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = DATE_TIME_FORMAT
        return formatter.date(from: date)
    }

}

