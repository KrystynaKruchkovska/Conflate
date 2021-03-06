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
            if let error = error {
                print("Data could not be saved: \(error).")
                handler(error)
            }else{
                print("Data saved successfully!")
                handler(nil)
            }
            
        }
    }

    func readPosts(handler: @escaping (_ post: [Post]) -> ()){
    
        _REF_POSTS.observeSingleEvent(of: .value) { (postSnapshot) in
            var postArray =  [Post]()
            
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
        let authorID = post.childSnapshot(forPath: Constants.PostData.authorID).value as! String
        let title = post.childSnapshot(forPath: Constants.PostData.title).value as! String
        let description = post.childSnapshot(forPath: Constants.PostData.description).value as! String
        let numberOfParticipants = post.childSnapshot(forPath: Constants.PostData.participants).value as! Int
        let date = post.childSnapshot(forPath: Constants.PostData.date).value as! String
        let category = post.childSnapshot(forPath: Constants.PostData.category).value as! String
        let uuid = post.childSnapshot(forPath: Constants.PostData.uuid).value as! String
        
        let lat = post.childSnapshot(forPath: Constants.PostData.locationLat).value as! Double
        let long = post.childSnapshot(forPath: Constants.PostData.locationLong).value as! Double

        let location = Location(lat:lat, long:long)

        let post = Post(uuid:uuid, author: authorID, title: title, description: description, numberOfParticipants: numberOfParticipants, location: location, date: date, category: category)
        
        return post
    }
    
}
