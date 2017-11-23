//
//  FavouritesService.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 02/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit
import CoreData

protocol ArtistFavouritesService {
    
    func updateFavourite(artist: Artist) -> Bool
    func isFavourite(artist: Artist) -> Bool
    func favouriteArtists() -> [Artist]

}

protocol TrainingFavouritesService {
    
    func updateFavourite(training: Training) -> Bool
    func isFavourite(training: Training) -> Bool
    func favouriteTrainings() -> [Training]
}

class BaseFavouritesService {
    var entityName : String
    
    var favourites: [NSManagedObject] = []
    
    var managedContext : NSManagedObjectContext {
        get {
            return Utils.application().persistentContainer.viewContext
        }
    }
    
    init(entityName: String) {
        self.entityName = entityName
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            favourites = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func updateFavourite(entityId: String) -> Bool {
        let favouriteIds = favourites.map({e in e.value(forKey: "id") as! String})
        
        if favouriteIds.contains(entityId) {
            removeFavourite(entityId: entityId)
            return false
        } else {
            addFavourite(entityId: entityId)
            return true
        }
    }
    
    func addFavourite(entityId: String) {
        let newEntity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        
        let newFavourite = NSManagedObject(entity: newEntity, insertInto: managedContext)
        newFavourite.setValue(entityId, forKey: "id")
        
        do {
            try managedContext.save()
            favourites.append(newFavourite)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func removeFavourite(entityId: String) {
        let foundAtIndex = favourites.index(where: {a in a.value(forKey: "id") as! String == entityId})
        guard let indexToRemove  = foundAtIndex else {
            return
        }
        
        do {
            managedContext.delete(favourites[indexToRemove])
            favourites.remove(at: indexToRemove)
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func isFavourite(entityId: String) -> Bool {
        let favouriteIds = favourites.map({e in e.value(forKey: "id") as! String})
        
        return favouriteIds.contains(entityId)
    }
}

class OnDeviceArtistFavouritesService: BaseFavouritesService, ArtistFavouritesService {

    init() {
        super.init(entityName: "FavouriteArtist")
    }

    func updateFavourite(artist: Artist) -> Bool {
        return updateFavourite(entityId: artist.id)

    }

    func isFavourite(artist: Artist) -> Bool {
        return isFavourite(entityId: artist.id)
    }

    fileprivate func removeFavourite(artist: Artist) {
        removeFavourite(entityId: artist.id)
    }

    fileprivate func addFavourite(artist: Artist) {
        addFavourite(entityId: artist.id)
    }

    func favouriteArtists() -> [Artist] {

        let favouriteIds = favourites.map({e in e.value(forKey: "id") as! String})

        if let allArtists = Utils.application().artistsService.allArtists() {
            return allArtists.filter({a in favouriteIds.contains(a.id)})

        }
        return [Artist]()
    }
}

class OnDeviceTrainingFavouritesService: BaseFavouritesService, TrainingFavouritesService {
    
    init() {
        super.init(entityName: "FavouriteTraining")
    }
    
    func updateFavourite(training: Training) -> Bool {
        return updateFavourite(entityId: training.id)
        
    }
    
    func isFavourite(training: Training) -> Bool {
        return isFavourite(entityId: training.id)
    }
    
    fileprivate func removeFavourite(training: Training) {
        removeFavourite(entityId: training.id)
    }
    
    fileprivate func addFavourite(training: Training) {
        addFavourite(entityId: training.id)
    }
    
    func favouriteTrainings() -> [Training] {

        let favouriteIds = favourites.map({e in e.value(forKey: "id") as! String})
        
        if let allArtists = Utils.application().trainingsService.allTrainings() {
            return allArtists.filter({a in favouriteIds.contains(a.id)})
            
        }
        return [Training]()
    }
}

class InMemoryArtistFavouritesService: ArtistFavouritesService {
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
}

class InMemoryTrainingFavouritesService: TrainingFavouritesService {
    
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

    func favouriteTrainings() -> [Training] {
        return Array(trainings)
    }
 
}

