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
    
}

class InMemoryFavouritesService: FavouritesService {
    
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
