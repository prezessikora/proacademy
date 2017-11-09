//
//  EventsCollectionViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 04/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit


class FavouritesCollection : UICollectionViewController, ReloadCallback {
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

    fileprivate let itemsPerRow: CGFloat = 2
        
    override func viewWillAppear(_ animated: Bool) {
        reload()
    }
    
    func reload() {
        collectionView?.reloadData()
    }
}

class TrainingsCollectionViewController: FavouritesCollection {


    fileprivate let reuseIdentifier = "EventCell"

    var favouritesService : TrainingFavouritesService {
        get {
            return Utils.application().trainingFavouritesService!
        }
    }
        

   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouritesService.favouriteTrainings().count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavouriteEventCell
        
        let training = favouritesService.favouriteTrainings()[indexPath.row]
        
        cell.backgroundColor = UIColor.white
        cell.title.text = training.title
        cell.trainer.text = training.trainer        

        return cell
    }   
}

extension FavouritesCollection : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}
