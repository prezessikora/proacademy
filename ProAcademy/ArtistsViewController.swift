//
//  ArtistsViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 09/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit
import iCarousel


extension ArtistsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        flipPresentAnimationController.originFrame = transitionCard!.frame
        return flipPresentAnimationController
    }
}

class ArtistsViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {

    var tilt: CGFloat = 0.5
    
    var transitionCard: UIView?
    
    var currentCard: CardArtistView!

    
    let flipPresentAnimationController = FlipPresentAnimationController()
    
    let artists = [
        Artist(name: "Miss Lula", title: "Pani Dyrektor p:a", quote: "", description: "", image: UIImage(named: "pro-academy-miss-lula-150x150")!),
        Artist(name: "Natalia Stawiarska", title: "Make up & CEO", quote: "", description: "", image: UIImage(named: "pro-academy-natalia-stawiarska-150x150")!),
        Artist(name: "Krzysztof Sikora", title: "Pan Krzysztof", quote: "", description: "", image: UIImage(named: "krzysztof")!),
        Artist(name: "Sandra Sikora", title: "Design Love CEO", quote: "", description: "", image: UIImage(named: "sandra")!)]

    @IBOutlet var carousel: iCarousel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCarousel()
    }

    fileprivate func configureCarousel() {
        carousel.type = .timeMachine
        carousel.isVertical = true
        carousel.scrollToItem(at: artists.count, animated: false)
        carousel.viewpointOffset = CGSize(width: 0, height: -30)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTabBarVisible(visible: true, animated: false, completion: {_ in })
        if let v  = transitionCard {
            v.removeFromSuperview()
            carousel.isHidden = false
        }
        tilt = 0.5
        self.view.backgroundColor = UIColor.white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination
        destinationViewController.transitioningDelegate = self
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        currentCard = carousel.currentItemView! as! CardArtistView
    }

    func setTabBarVisible(visible: Bool, animated: Bool, completion:@escaping (Bool)->Void) {
        
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) {
            return completion(true)
        }
        
        // get a frame calculation ready
        let height = tabBarController!.tabBar.frame.size.height
        let offsetY = (visible ? -height : height)
        
        // zero duration means no animation
        let duration = (animated ? 0.3 : 0.0)
        
        UIView.animate(withDuration: duration, animations: {
            let frame = self.tabBarController!.tabBar.frame
            self.tabBarController!.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
//            self.view.backgroundColor = UIColor.black
            
        }, completion: completion)
        

    }
    
    func tabBarIsVisible() -> Bool {
        return tabBarController!.tabBar.frame.origin.y < view.frame.maxY
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

    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {

        let currentCardFrame = currentCard.convert(currentCard.frame, to: self.view)
        print(currentCardFrame)
        
        transitionCard = createCard(carousel.currentItemIndex)
        
        view.addSubview(transitionCard!)
        
        transitionCard?.translatesAutoresizingMaskIntoConstraints = false

        transitionCard?.widthAnchor.constraint(equalToConstant: 250).isActive = true
        transitionCard?.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        transitionCard?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: currentCardFrame.origin.y-94).isActive = true
        
        transitionCard?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: currentCardFrame.origin.x).isActive = true

        carousel.isHidden = true
        
        setTabBarVisible(visible: false, animated: true, completion: {_ in
            self.performSegue(withIdentifier: "showArtistDetails", sender: self)
        })
    }
    
    fileprivate func createCard(_ index: Int) -> UIView {
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
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {

        return createCard(index)
    }

    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        if (option == .tilt) {
            return tilt
        }
        return value
    }
    
}


