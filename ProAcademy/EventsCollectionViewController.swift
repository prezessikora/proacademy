//
//  EventsCollectionViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 04/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit


class FavouritesCollection : UICollectionViewController {
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

    fileprivate let itemsPerRow: CGFloat = 2    
}

class EventsCollectionViewController: FavouritesCollection {

    
    fileprivate let reuseIdentifier = "EventCell"

    
    let trainings = [Training(title: "CAT EYES",trainer: "Jagoda Wrześniewska"),Training(title: "PERFEKCYJNE BRWI",trainer: "Krzysztof Sikora"),
                     Training(title: "ZMYSŁOWE USTA",trainer: "Sandra Sikora")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    }
   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trainings.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavouriteEventCell
    
        // Configure the cell
        cell.backgroundColor = UIColor.white
        cell.title.text = trainings[indexPath.row].title
        cell.trainer.text = trainings[indexPath.row].trainer
    
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
