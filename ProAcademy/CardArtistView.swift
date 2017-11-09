//
//  CardArtistView.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 10/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit


class CardArtistView: UIView  {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var quote: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    var artist: Artist?

    var favouritesService : ArtistFavouritesService {
        get {
            return Utils.application().artistFavouritesService!
        }
    }
    
    
    override init(frame: CGRect) { // for using in code
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using in IB
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func updateFavouriteState() {
        if let a = artist, favouritesService.isFavourite(artist: a) {
            self.favouriteButton.setImage(Icons.favouriteSetImage, for: .normal)
        } else {
            self.favouriteButton.setImage(Icons.favouriteNotSetImage, for: .normal)
        }
    }

    
    func commonInit() {
        Bundle.main.loadNibNamed("ArtistView", owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false

        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        contentView.frame = self.bounds
    }

    @IBAction func onFavourite(_ sender: UIButton) {
        guard let a = artist else {
            return
        }
        
        if favouritesService.updateFavourite(artist: a) {
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
