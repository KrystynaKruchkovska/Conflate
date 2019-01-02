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
    
}
