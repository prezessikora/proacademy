//
//  ArtistsCollectionViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 04/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit


protocol ReloadCallback {
    func reload()
}

class ArtistsCollectionViewController: FavouritesCollection, ReloadCallback {

    fileprivate let reuseIdentifier = "ArtistCell"

    var favouritesService : FavouritesService {
        get {
            return Utils.application().favouritesService!
        }
    }

    func reload() {
        collectionView?.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouritesService.favouriteArtists().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArtistCell
        
        let artist = favouritesService.favouriteArtists()[indexPath.row]
        
        // Configure the cell
        cell.backgroundColor = UIColor.white
        cell.name.text = artist.name
        cell.title.text = artist.title
        
        cell.image.image = artist.image
        cell.image.layer.borderWidth = 0
        cell.image.layer.masksToBounds = false
        cell.image.layer.borderColor = UIColor.black.cgColor
        cell.image.layer.cornerRadius = cell.image.frame.height/2
        cell.image.clipsToBounds = true
        
        return cell
    }

}
