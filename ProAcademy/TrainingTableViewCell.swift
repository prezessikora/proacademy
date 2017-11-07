//
//  TrainingTableViewCell.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 30/09/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class TrainingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var trainer: UILabel!
    
    var training: Training?
    
    var favouritesService : FavouritesService {
        get {
            return Utils.application().favouritesService!
        }
    }
    
    func updateFavouriteState() {
        if let t = training, favouritesService.isFavourite(training: t) {
            self.favouriteButton.setImage(Icons.favouriteSetImage, for: .normal)
        } else {
            self.favouriteButton.setImage(Icons.favouriteNotSetImage, for: .normal)
        }
    }

    @IBAction func onFavourite(_ sender: UIButton) {
        guard let t = training else {
            return
        }
        
        if favouritesService.updateFavourite(training: t) {
            UIView.animate(withDuration: 0.5) {
                self.favouriteButton.setImage(Icons.favouriteSetImage, for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.favouriteButton.setImage(Icons.favouriteNotSetImage, for: .normal)
            }
        }
    }


}






