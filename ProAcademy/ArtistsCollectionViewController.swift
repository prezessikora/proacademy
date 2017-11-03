//
//  ArtistsCollectionViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 04/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit


class ArtistsCollectionViewController: FavouritesCollection {

    fileprivate let reuseIdentifier = "ArtistCell"

    let artists = [
        Artist(id: "1", name: "Miss Lula", title: "Pani Dyrektor p:a", quote: "", description: "", image: UIImage(named: "pro-academy-miss-lula-150x150")!),
        Artist(id: "2", name: "Natalia Stawiarska", title: "Make up & CEO", quote: "", description: "", image: UIImage(named: "pro-academy-natalia-stawiarska-150x150")!)]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArtistCell
        
        // Configure the cell
        cell.backgroundColor = UIColor.white
        cell.name.text = artists[indexPath.row].name
        cell.title.text = artists[indexPath.row].title
        
        cell.image.image = artists[indexPath.row].image
        cell.image.layer.borderWidth = 0
        cell.image.layer.masksToBounds = false
        cell.image.layer.borderColor = UIColor.black.cgColor
        cell.image.layer.cornerRadius = cell.image.frame.height/2
        cell.image.clipsToBounds = true
        
        return cell
    }

}
