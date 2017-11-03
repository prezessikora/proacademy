//
//  CardArtistView.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 10/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class CardArtistView: UIView {
    
    static let favouriteSetImage: UIImage? = UIImage(named: "icons8-heart-outline-red")
    static let favouriteNotSetImage: UIImage? = UIImage(named: "icons8-Heart Outline-50")
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var quote: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    var artist: Artist?
    
    var favouritesService : FavouritesService {
        get {
            return Utils.application().favouritesService!
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
        if let _ = artist, favouritesService.isFavourite(artist: artist!) {
            self.favouriteButton.setImage(CardArtistView.favouriteSetImage, for: .normal)
        } else {
            self.favouriteButton.setImage(CardArtistView.favouriteNotSetImage, for: .normal)
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
        if favouritesService.updateFavourite(artist: artist!) {
            UIView.animate(withDuration: 0.5) {
                self.favouriteButton.setImage(CardArtistView.favouriteSetImage, for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.favouriteButton.setImage(CardArtistView.favouriteNotSetImage, for: .normal)
            }
        }
    }
}
