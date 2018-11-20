//
//  User.swift
//  Verifica_Luca_Bonin
//
//  Created by Leo Luca Bonin on 20/11/2018.
//  Copyright © 2018 developer.llb. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class User: Object, Codable {
    
    dynamic var name : String?
    dynamic var surname : String?
    dynamic var email : String!
    dynamic var image : Data?
    
    convenience init(email : String, name : String? = nil, surname : String? = nil, image : Data? = nil) {
        self.init()
        self.name = name ?? ""
        self.surname = surname ?? ""
        self.email = email
        self.image = image 
    }
    
    override class func primaryKey() -> String? {
        return "email"
    }
    
    func save(in realm : Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write{
                realm.add(self, update: true)
            }
        } catch {}
    }
    
    static func allSavedUser (in realm: Realm = try! Realm()) -> [User] {
        return Array(realm.objects(User.self))
    }
    
}
