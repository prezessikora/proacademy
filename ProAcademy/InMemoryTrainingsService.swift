//
//  LocalTrainingsService.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 06/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

protocol TrainingsService {
    func allTrainings() -> [Training]?

}

class InMemoryTrainingsService: TrainingsService {
    
    
    let trainings = [Training(id: "1",title: "CAT EYES",trainer: "Jagoda Wrześniewska"),Training(id: "2", title: "PERFEKCYJNE BRWI",trainer: "Krzysztof"),
                     Training(id: "3", title: "ZMYSŁOWE USTA",trainer: "Sandra Sikora")]
    
    func allTrainings() -> [Training]? {
        return trainings
    }

}
