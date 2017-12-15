//
//  WordpressService.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 12/12/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit
import OAuthSwift

class WordpressService: TrainingsService {
    
    let consumerKey = "ck_b0441b3a99da93a3400458b244befaaa61b0ee1b"
    let consumerSecret = "cs_a75e911de45a3b3253426d2eacd1387e6fdc78b2"
    
    let PRODUCTS_URL = "http://www.pro-academy.pl/wp-json/wc/v2/products"
    
    var oauthswift : OAuth1Swift!
    
    var cachedTrainings = [Training]()
    
    // sync read/write through this queue
    fileprivate let concurrentDownloadQueue =
        DispatchQueue(
            label: "com.desinglove.proacademy.downloadQueue",
            attributes: .concurrent)
    
    
    init() {
        
        oauthswift = OAuth1Swift(
            consumerKey:    consumerKey,
            consumerSecret: consumerSecret
        )
        oauthswift.client.paramsLocation = .requestURIQuery
        
    }

    
    func loadOrRefreshData()  {
        print("WordpressService - Refreshig cached data.")
        downloadTrainings()
    }

    
    func allTrainings() -> [Training]? {
        return concurrentDownloadQueue.sync {
            return cachedTrainings
        }
    }
    
    func availableTrainings() -> [Training]? {
        return concurrentDownloadQueue.sync {
            let onlyAvailableTrainings = self.cachedTrainings.filter({t in t.remainingItems > 0})
            print("WordpressService - returning \(onlyAvailableTrainings.count) available trainings.")
            return onlyAvailableTrainings
        }

    }
    
    fileprivate func processProducts(_ json: [Any]) {
        var downloadedTrainings = [Training]()
        for p in json {
            let product = p as! [String:Any]
            
            guard let status = product["status"] as? String else {
                print("ERROR - rejecting product caused by missing 'status'")
                continue
            }
            guard let productId = product["id"] as? Int else {
                print("ERROR - rejecting product caused by missing 'id'")
                continue
            }
            guard let productName = product["name"] as? String else {
                print("ERROR - rejecting product caused by missing 'name'")
                continue
            }
            guard let soldAmount = product["total_sales"] as? Int else {
                print("ERROR - rejecting product caused by missing 'total_sales'")
                continue
            }
            guard let stockQuantity = product["stock_quantity"] as? Int else {
                print("ERROR - rejecting product caused by missing 'stock_quantity'")
                continue
            }
            guard let inStock = product["in_stock"] as? Bool else {
                print("ERROR - rejecting product caused by missing 'in_stock'")
                continue
            }
            guard let price = product["price"] as? String else {
                print("ERROR - rejecting product caused by missing 'price'")
                continue
            }
            guard let description = product["description"] as? String else {
                print("ERROR - rejecting product caused by missing 'description'")
                continue
            }
            guard let shortDescription = product["short_description"] as? String else {
                print("ERROR - rejecting product caused by missing 'short_description'")
                continue
            }
            
            
            let training = Training(id: String(productId), title: productName, dateString: "[no date]")
            training.inStock = inStock
            training.status = status
            training.offeredItems = soldAmount + stockQuantity
            training.remainingItems = stockQuantity
            training.price = price
            training.fullDescription = description
            training.shortDescription = shortDescription
            print("Downloaded product: \(training)")
            downloadedTrainings.append(training)
            
        }
        cachedTrainings = downloadedTrainings
    }

    func downloadTrainings() {
        print("WordpressService - Downloading products from WordPress...")
        let startTime = CFAbsoluteTimeGetCurrent()
        
        
        
        self.oauthswift.client.get(self.PRODUCTS_URL,
            success: { response in
                let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
                // make sure there is the only thread
                self.concurrentDownloadQueue.async (flags: .barrier) {
                    print("WordpressService - Processing response from WordPress...")
                    do {
                        let json = try response.jsonObject() as! [Any]
                        print("Downloaded \(json.count) products from WordPress.")
                        
                        self.processProducts(json)
                        
                    } catch let (error) {
                        print("ERROR paring JSON with training products: \(error.localizedDescription)")
                    }
                    self.cachedTrainings = self.cachedTrainings.filter({t in t.status == "publish"})
                    print("Saved \(self.cachedTrainings.count) [published] trainings and sending notification.")
                    
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .ProductsDownload, object: self)
                    }
                    let timeStr = String(format: "[%3.2f] seconds", timeElapsed)
                    print("WordpressService - Finished downloading products from WordPress \(timeStr) .")
                }

            },
            failure: { error in
                print("ERROR parsing JSON with training products: \(error.localizedDescription)")
                print("WordpressService - Finished downloading products from WordPress...")
            })
        
    }

}
