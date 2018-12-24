//
//  AuthService.swift
//  Conflate
//
//  Created by Mac on 12/24/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    func createUser(email:String,password:String){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            // ...
            guard let user = authResult?.user else { return }
        }
    }
    
    func signInUser(email:String,password:String){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            // ...
        }
    }
}
