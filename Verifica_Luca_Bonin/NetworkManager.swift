//
//  NetworkManager.swift
//  Verifica_Luca_Bonin
//
//  Created by Leo Luca Bonin on 20/11/2018.
//  Copyright © 2018 developer.llb. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import CodableFirebase

class NetworkManager: NSObject {
    private static var fireStore : Firestore?
    private static var storageRef : StorageReference?
    
    static func initFirebase(){
        FirebaseApp.configure()
        fireStore = Firestore.firestore()
    }
    
    static func login (email : String , password : String, completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) {
            (user, error) in
            guard let user = user else {
                return
            }
            
            debugPrint(user)
            completion(true)
        }
    }
    
    static func signup(email : String , password : String, completion: @escaping (Bool) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user else {
                completion(false)
                print(error.debugDescription)
                return
                
            }
            debugPrint(user)
            completion(true)
        }
    }
    
    static func logout(completion: @escaping (Bool) -> ()) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            completion(true)
        } catch let error as NSError {
            print ("Error signing out: %@", error)
        }
    }
    
    static func addUser(user : User, completion : @escaping(Bool) -> ()) {
        
        guard let db = fireStore else {
            print("Error DB")
            completion(false)
            return
        }
        
        db.collection("listOfUsers").document(user.email).setData([
            "name" : user.name! ,
            "surname" : user.surname! ,
            "email" : user.email
        ]) {
            error in
            if let _ = error {
                completion(false)
            }
            else {
                completion(true)
            }
        }
        
    }
    
    static func checkLoggedUser(completion: @escaping (Bool) -> ()) {
        
        if let _ = Auth.auth().currentUser {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    static func getUsers(completion : @escaping ([User], Bool) -> ()) {
        var userList : [User] = []
        guard let db = fireStore else {
            print("Error DB")
            completion(userList, false)
            return
        }
        
        db.collection("listOfUsers").getDocuments(completion: { (querySnapshot, error) in
            if let _ = error {
                completion(userList, false)
            }
            else
            {
                for document in querySnapshot!.documents {
                    var map : Dictionary<String, String> = document.data() as! Dictionary<String, String>
                    userList.append(User (email: map["email"] ?? "", name: map["name"] ?? "", surname: map["surname"] ?? ""))
                }
                
                completion(userList, true)
            }
        })
    }
    
    static func uploadImageProfile(withData data: Data, forUserID id: String, completion: @escaping (String?) -> ()) {
        
        guard let storageRef = storageRef else {
            completion(nil)
            return
            
        }
        
        let riversRef = storageRef.child("profileImages/\(id).jpg")
        
        let _ = riversRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                completion(nil)
                return
            }
            
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    completion(nil)
                    return
                }
                
                completion(downloadURL.absoluteString)
            }
        }
    }
    
    static func dowloadImageProfile(withURL url: String, completion: @escaping (UIImage?) -> ()) {
        
        let httpsReference = Storage.storage().reference(forURL: url)
        
        httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                debugPrint(error)
                completion(nil)
            } else {
                guard let data = data, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                completion(image)
            }
        }
        
    }
}
