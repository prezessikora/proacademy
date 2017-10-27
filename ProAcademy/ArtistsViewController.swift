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

    let fadePresentAnimationController = FadePresentAnimationController()
    
    let fadeDismissAnimationController = FadeDismissAnimationController()
    
//    let artists = [
//        Artist(name: "Miss Lula", title: "Pani Dyrektor p:a", quote: "", description: "", image: UIImage(named: "pro-academy-miss-lula-150x150")!),
//        Artist(name: "Natalia Stawiarska", title: "Make up & CEO", quote: "", description: "", image: UIImage(named: "pro-academy-natalia-stawiarska-150x150")!),
//        Artist(name: "Krzysztof Sikora", title: "Pan Krzysztof", quote: "", description: "", image: UIImage(named: "krzysztof")!),
//        Artist(name: "Sandra Sikora", title: "Design Love CEO", quote: "", description: "", image: UIImage(named: "sandra")!)]

    var artists : [Artist]?
    
    @IBOutlet var carousel: iCarousel!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    var service : ArtistsService!
    
    // MARK: transition variables
    
    var currentCardIndex = -1
    
    var cardFame: CGRect?
    
    // MARK: init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCarousel()
        service = ContentfulArtistsService()
    }
    
    fileprivate func configureCarousel() {
        carousel.type = .timeMachine
        carousel.isVertical = true
        carousel.viewpointOffset = CGSize(width: 0, height: -30)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        errorMessage.isHidden = true
        carousel.isHidden = true
        loadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    
    func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            
            do {
                let fetchResult = try self.service.fetchArtists()
                
                // err if nil or empty load from cache? (do it in service)
                
                if let fetched = fetchResult {
                    self.artists = fetched
                    DispatchQueue.main.async {
                        // save aside as reload sets it to 0
                        let indexValue = self.currentCardIndex
                        self.carousel.reloadData()
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.carousel.isHidden = false
                        // after return and new entry added you might end up different card - check it
                        
                        if (indexValue == -1) { // first load
                            self.carousel.scrollToItem(at: fetched.count, animated: true)
                        } else {
                            self.carousel.scrollToItem(at: self.currentCardIndex, animated: false)
                        }
                    }
                }
                
            } catch ServiceError.CouldNotFetchData(let message) {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.errorMessage.text = "\(self.errorMessage.text!)\n\(message)"
                    self.errorMessage.isHidden = false
                }
            }
            catch is Error {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.errorMessage.isHidden = false
                }
            }
            
        }
    }

    func colorForCard(at index: Int) -> UIColor {
        
        guard let fetchedArtists = artists, fetchedArtists.count > 0 else {
            return UIColor.black
        }
        
        let first = 255
        let last  = 220

        let step = (first-last)/fetchedArtists.count >= 1 ? (first-last)/fetchedArtists.count : 1

        let v = 255 - step * (fetchedArtists.count-index-1)
        return UIColor(red: CGFloat(CGFloat(v)/255.0), green: CGFloat(CGFloat(v)/255.0), blue: CGFloat(CGFloat(v)/255.0), alpha: 1.0)
    }
    
    
    // MARK: - Carousel
    

    func numberOfItems(in carousel: iCarousel) -> Int {
        if let fetchedArtists = artists {
            return fetchedArtists.count
        }
        return 0        
    }
    
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        return createCard(index: index)
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        if (option == .tilt) {
            return 0.5
        }
        return value
    }
    
    
    fileprivate func circledImage(_ imageView: UIImageView) {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func currentCardSnapShot() -> UIView {
        return self.createCard(index: currentCardIndex).snapshotView(afterScreenUpdates: true)!
    }
    
    func createCard(index: Int) -> UIView {

        let artist = artists![index]
        
        let card = CardArtistView(frame: CGRect(x: 0, y: 0, width: 250, height: 400))
        //card.view.backgroundColor = colorForCard(at: index)
        
        card.layer.borderColor = UIColor.lightGray.cgColor
        card.layer.borderWidth = 1.0
        
        card.name.text = artist.name
        card.imageView.image = artist.image
        
        card.title.text = artist.title
        card.quote.text = artist.quote
        
        circledImage(card.imageView)
        
        return card
    }
    // MARK: transition
    
    
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        currentCardIndex = carousel.currentItemIndex
        //currentCard = carousel.currentItemView
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
        let duration = (animated ? 0.2 : 0.0)
        
        UIView.animate(withDuration: duration, animations: {
            let frame = self.tabBarController!.tabBar.frame
            self.tabBarController!.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
        }, completion: completion)
        
        
    }
    
    func tabBarIsVisible() -> Bool {
        return tabBarController!.tabBar.frame.origin.y < view.frame.maxY
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination
        destinationViewController.transitioningDelegate = self
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        
        if (index != currentCardIndex) {
            return
        }
        
        let currentCard = carousel.currentItemView
        
        cardFame = currentCard?.superview?.convert((currentCard?.frame)!,to: self.view)
        
        setTabBarVisible(visible: false, animated: true) {_ in
            self.performSegue(withIdentifier: "showDetails", sender: self)
        }
    }
}

extension ArtistsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        fadePresentAnimationController.originFrame = cardFame!
        fadePresentAnimationController.cardSnapshot = currentCardSnapShot()
        
        
        return fadePresentAnimationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        fadeDismissAnimationController.destinationFrame = cardFame!
        fadeDismissAnimationController.cardSnapshot = currentCardSnapShot()
        
        return fadeDismissAnimationController
    }
}
