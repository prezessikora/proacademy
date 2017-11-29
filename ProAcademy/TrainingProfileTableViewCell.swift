//
//  TrainingProfileTableViewCell.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 29/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class TrainingProfileTableViewCell: UITableViewCell {

    var training: Training?
    
    @IBOutlet weak var trainingTitle: UILabel!
    @IBOutlet weak var trainer: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var showDetails: UIButton!
    
    
    @IBAction func onShowDetails(_ sender: Any) {
    }
    

    
}
