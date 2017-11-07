//
//  FavouritesService.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 02/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

protocol FavouritesService {
    
    func updateFavourite(artist: Artist) -> Bool
    func isFavourite(artist: Artist) -> Bool
    func addFavourite(artist: Artist)
    func removeFavourite(artist: Artist)
    func favouriteArtists() -> [Artist]

    func updateFavourite(training: Training) -> Bool
    func isFavourite(training: Training) -> Bool
    func addFavourite(training: Training)
    func removeFavourite(training: Training)
    func favouriteTrainings() -> [Training]
}



class InMemoryFavouritesService: FavouritesService {
    
    var trainings: Set = Set<Training>()
    
    func updateFavourite(training: Training) -> Bool {
        if trainings.contains(training) {
            trainings.remove(training)
            return false
        } else {
            trainings.insert(training)
            return true
        }
    }
    
    func isFavourite(training: Training) -> Bool {
        return trainings.contains(training)
    }
    
    func addFavourite(training: Training) {
        trainings.insert(training)
    }
    
    func removeFavourite(training: Training) {
        trainings.remove(training)
    }
    
    func favouriteTrainings() -> [Training] {
        return Array(trainings)
    }
    
    
    var artists: Set = Set<Artist>()
    
    func updateFavourite(artist: Artist) -> Bool {
        
        if artists.contains(artist) {
            artists.remove(artist)
            return false
        } else {
            artists.insert(artist)
            return true
        }
    }
    
    func isFavourite(artist: Artist) -> Bool {
        return artists.contains(artist)
    }
    
    func favouriteArtists() -> [Artist] {
        return Array(artists)
    }
    
    func addFavourite(artist: Artist) {
        artists.insert(artist)
    }
    
    func removeFavourite(artist: Artist) {
        artists.remove(artist)
    }
}
