//
//  Artist.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 02/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class Artist : Hashable {
    
    var hashValue: Int {
        get {
            return id.hashValue
        }
    }
    
    let id: String
    let name: String
    let title: String
    let quote: String
    let description: String
    let image: UIImage
    
    init(id: String, name: String, title: String, quote: String, description: String, image: UIImage) {
        self.id = id
        self.name = name
        self.title = title
        self.quote = quote
        self.description = description
        self.image = image
    }

    static func ==(lhs: Artist, rhs: Artist) -> Bool {
        return lhs.id == rhs.id
    }
}

