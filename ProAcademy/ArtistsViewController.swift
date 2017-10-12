//
//  ArtistsViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 09/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit
import iCarousel



class ArtistsViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {

    let artists = [Artist(name: "Miss Lula", title: "Pani Dyrektor p:a", image: UIImage(named: "pro-academy-miss-lula-150x150")!),Artist(name: "Natalia Stawiarska", title: "Make up & CEO", image: UIImage(named: "pro-academy-natalia-stawiarska-150x150")!), Artist(name: "Krzysztof Sikora", title: "Pan Krzysztof", image: UIImage(named: "krzysztof")!),Artist(name: "Sandra Sikora", title: "Design Love CEO", image: UIImage(named: "sandra")!)]

    @IBOutlet var carousel: iCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carousel.type = .timeMachine
        carousel.isVertical = true
        carousel.scrollToItem(at: artists.count, animated: false)
        carousel.viewpointOffset = CGSize(width: 0, height: -30)
    }

 
    func colorForCard(at index: Int) -> UIColor {
        let first = 255
        let last  = 240

        let step = (first-last)/artists.count >= 1 ? (first-last)/artists.count : 1

        let v = 255 - step * (artists.count-index-1)
        return UIColor(red: CGFloat(CGFloat(v)/255.0), green: CGFloat(CGFloat(v)/255.0), blue: CGFloat(CGFloat(v)/255.0), alpha: 1.0)
    }

    func numberOfItems(in carousel: iCarousel) -> Int {
        return artists.count
    }

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {

        let artist = artists[index % 4]

        let card = CardArtistView(frame: CGRect(x: 0, y: 0, width: 250, height: 400))
        
        card.contentView.backgroundColor = colorForCard(at: index)
        
        card.layer.borderColor = UIColor.lightGray.cgColor
        card.layer.borderWidth = 1.0
        

        card.imageView.image = artist.image
        card.name.text = artist.name
        card.mainLine.text = "Main line \(index)"
        card.title.text = artist.title

        card.imageView.clipsToBounds = true
        card.imageView.layer.cornerRadius = card.imageView.frame.height/2
        card.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return card
    }

    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        if (option == .tilt) {
            return 0.5
        }
        return value
    }
    
}


