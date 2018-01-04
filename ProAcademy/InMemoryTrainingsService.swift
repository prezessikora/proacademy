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
    func availableTrainings() -> [Training]?
    func loadOrRefreshData() 
}

class InMemoryTrainingsService: TrainingsService {
    
    let trainings = [Training(id: "1",title: "CAT EYES",trainer: "Jagoda Wrześniewska",dateString:"2017/10/10 11:30"),Training(id: "2", title: "PERFEKCYJNE BRWI",trainer: "Krzysztof",dateString:"2017/12/10 10:00"),
                              Training(id: "3", title: "ZMYSŁOWE USTA",trainer: "Sandra Sikora",dateString:"2018/01/01 09:00")]
    
    func allTrainings() -> [Training]? {
        return trainings
    }
    
    func availableTrainings() -> [Training]? {
        return trainings
    }
    
    func loadOrRefreshData() {
        
    }
}
