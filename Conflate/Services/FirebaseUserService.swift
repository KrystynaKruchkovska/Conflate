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

class FirebaseUserService:UserServise{
    
    static let DB_BASE = Database.database().reference()
    static let userID = Auth.auth().currentUser?.uid
    
    public private (set) var  _REF_BASE = DB_BASE
    public private (set)  var _REF_USERS = DB_BASE.child("users")
    
    
}
