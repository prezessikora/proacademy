//
//  ArtistsService.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 23/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import Contentful
import Interstellar

protocol ArtistsService {
    func fetchArtists() -> [Artist]?
}

class ContentfulArtistsService: ArtistsService {
    
    let spaceId = "hul02y9lnm1j"
    let token = "f236c5518033231432fced6a6194e068d8449c2de8ebd9cc7b1b291f3a680325"

    var client : Client?
    
    init() {
        client = Client(spaceId: spaceId, accessToken: token)
    }
    

    // TODO: proper error handling
    func fetchArtists() -> [Artist]?  {
        let query = Query(where: "content_type", .equals("artist"))

        var resultItems : [Entry]?
        var fetchedArtists = [Artist]()
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        client?.fetchEntries(with: query) { (result: Result<ArrayResponse<Entry>>) in
            switch result {
                case .success(let entry):
                    resultItems = [Entry]()
                    for item in entry.items {
                        resultItems?.append(item)
                    }

                case .error(let error):
                    print("Someting went wrong \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }
        let result = dispatchGroup.wait(timeout: DispatchTime.now() + 3)
        
        
        switch (result) {
            case .success:
                break
            case .timedOut: // request timed out
                return nil
        }
        
        guard let results = resultItems else { // error occured
            return nil
        }
        
        for item in results {
            let link = item.fields["thumbnail"] as! Link
            
            if let asset = link.asset {
                dispatchGroup.enter()
                // how to deal with this result
                self.client?.fetchImage(for: asset).then( { (i: UIImage)  in
   
                    var name = "", title = "", quote = "", description = ""
                    
                    if let n = item.fields["name"] {
                        name = n as! String
                    } else {
                        print("iSkipping Invalid entry in CMS: \(item)")
                        return
                    }
                    
                    if let t = item.fields["title"] {
                        title = t as! String
                    }
                    if let q = item.fields["quote"] {
                        quote = q as! String
                    }
                    if let d = item.fields["description"] {
                        description = d as! String
                    }
                    
                    let artist =
                        Artist(id: item.id, name: name, title: title, quote: quote, description: description, image: i)
                    fetchedArtists.append(artist)
                    
                    dispatchGroup.leave()
                })
                
            } else {
                print("iSkipping Invalid entry in CMS: \(item)")
            }
        }
        let fetchImages = dispatchGroup.wait(timeout: DispatchTime.now() + 3)

        switch (fetchImages) {
            case .success:
                break
            case .timedOut:
                // err
                return fetchedArtists
        }
        
        return fetchedArtists
    }

}
