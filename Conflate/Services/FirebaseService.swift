//
//  FirebaseUserService.swift
//  Conflate
//
//  Created by Mac on 12/29/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseService:UserService, PostService {
    private static let DB_BASE = Database.database().reference()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users") // TODO: move to constants
    private var _REF_POSTS = DB_BASE.child("posts") // TODO: move to constants
    
    func addUser(uid: String, userData: Dictionary<String, AnyObject>,handler:@escaping (_ error:Error?)->()) {
        _REF_USERS.child(uid).setValue(userData) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
                handler(error)
            } else {
                print("Data saved successfully!")
                handler(nil)
            }
        }
    }
    
    func addPost(post:Post, handler:@escaping (_ error:Error?)->()){
        _REF_POSTS.childByAutoId().updateChildValues(post.dictionary) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error{
                print("Data could not be saved: \(error).")
                handler(error)
            }else{
                print("Data saved successfully!")
                handler(nil)
            }
            
        }
    }

    func readPosts(handler: @escaping (_ post: [Post]) -> ()){
        var postArray =  [Post]()
        
        _REF_POSTS.observeSingleEvent(of: .value) { (postSnapshot) in
            guard let postSnapshot = postSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            for post in postSnapshot {
                let post = self.createPost(post: post)
                postArray.append(post)
            }
            
            handler(postArray)
        }

    }
    
    func createPost(post:DataSnapshot) -> Post{
        // TODO: All strings to CONSTANTS!
        let authorID = post.childSnapshot(forPath: "authorID").value as! String
        let title = post.childSnapshot(forPath: "title").value as! String
        let description = post.childSnapshot(forPath: "description").value as! String
        let numberOfParticipants = post.childSnapshot(forPath: "numberOfParticipants").value as! Int
        
        let lat = post.childSnapshot(forPath: "location/lat").value as! Double
        
        let long = post.childSnapshot(forPath: "location/long").value as! Double
        
        let location = Location(lat:lat, long:long)
        
        let date = post.childSnapshot(forPath: "date").value as! Double
        let category = post.childSnapshot(forPath: "category").value as! String
        
        let post = Post(author: authorID, title: title, description: description, numberOfParticipants: numberOfParticipants, location: location, date: date, category: category)
        
        return post
    }
    
}
