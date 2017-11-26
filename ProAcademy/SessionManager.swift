//
//  SessionManager.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 17/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//


import Foundation
import SimpleKeychain
import Auth0

class SessionManager {
    
    // Singleton instance
    static let shared = SessionManager()
    
    private let authentication = Auth0.authentication()
    let credentialsManager: CredentialsManager!
    
    // These hold retreived profile and credentials
    var credentials: Credentials?
    var profile: UserInfo?
    
    private init () {
        self.credentialsManager = CredentialsManager(authentication: Auth0.authentication())
        // _ = self.authentication.logging(enabled: true) // API Logging
    }
    
    func saveToMetadata(location: String) {
        
        Auth0
            .users(token: (credentials?.idToken!)!)
            .patch((profile?.sub)!, userMetadata: ["location": location])
            .start { result in
                switch result {
                case .success( _):
                    print("Metadata saved.")
                case .failure(let error):
                    print("Failure on metadata update: "+error.localizedDescription)
                }
        }
    }

    
    func readMetadata(processMetadata: @escaping ([String: Any]) -> Void ) {
        Auth0
            .users(token: (credentials?.idToken!)!)
            .get((profile?.sub)!, fields: ["user_metadata"], include: true)
            .start { result in
                switch result {
                case .success(let user):
                    guard let userMetadata = user["user_metadata"] as? [String: Any] else {
                        return
                    }
                    print("Metadata successfully read.")
                    processMetadata(userMetadata)
                case .failure(let error):
                    print("Error on reading metadata: "+error.localizedDescription)
                }
        }
    }
    func retrieveProfile(_ callback: @escaping (Error?) -> ()) {
        
        guard let accessToken = self.credentials?.accessToken else {
            return callback(CredentialsManagerError.noCredentials)
        }
        
        self.authentication
            .userInfo(withAccessToken: accessToken)
            .start { result in
                switch(result) {
                case .success(let profile):
                    self.profile = profile
                    callback(nil)
                case .failure(let error):
                    callback(error)
                }
            }
        
    }
    
    func renewAuth(_ callback: @escaping (Error?) -> ()) {
        // Check it is possible to return credentials before asking for Touch
        guard self.credentialsManager.hasValid() else {
            return callback(CredentialsManagerError.noCredentials)
        }
        self.credentialsManager.credentials { error, credentials in
            guard error == nil, let credentials = credentials else {
                return callback(error)
            }
            self.credentials = credentials
            callback(nil)
        }
    }
    
    func logout() -> Bool {
        // Remove credentials from KeyChain
        self.credentials = nil
        // Clear session from browser
       
        return self.credentialsManager.clear()
    }
    
    func store(credentials: Credentials) -> Bool {
        self.credentials = credentials
        // Store credentials in KeyChain
        return self.credentialsManager.store(credentials: credentials)
    }
    
}

func plistValues(bundle: Bundle) -> (clientId: String, domain: String)? {
    guard
        let path = bundle.path(forResource: "Auth0", ofType: "plist"),
        let values = NSDictionary(contentsOfFile: path) as? [String: Any]
        else {
            print("Missing Auth0.plist file with 'ClientId' and 'Domain' entries in main bundle!")
            return nil
    }
    
    guard
        let clientId = values["ClientId"] as? String,
        let domain = values["Domain"] as? String
        else {
            print("Auth0.plist file at \(path) is missing 'ClientId' and/or 'Domain' entries!")
            print("File currently has the following entries: \(values)")
            return nil
    }
    return (clientId: clientId, domain: domain)
}
