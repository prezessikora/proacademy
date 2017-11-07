//
//  Training.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 06/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class Training : Hashable {
    
    var hashValue: Int {
        get {
            return id.hashValue
        }
    }
    
    var id: String
    var title: String
    var trainer: String
    
    static func ==(lhs: Training, rhs: Training) -> Bool {
        return lhs.id == rhs.id
    }

    init(id: String, title: String, trainer: String) {
        self.id = id
        self.title = title
        self.trainer = trainer
       
    }

}

