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
    
    func createUser(email:String, password:String, handler:@escaping (_ error:Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            if let error = error {
                print("create user error: \(error)")
                handler(error)
                
                return
            }
            
            guard let _ = authResult?.user else {
                handler(error)
                return
            }
            
            handler(nil)
        }
        
    }
    
    func signInUser(email:String,password:String, handler:@escaping (_ error:Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                print("login user error: \(error)")
                handler(error)
                return
            }
            guard let user = user?.user else{
                handler(error)
                return
            }
            handler(nil)
        }
    }
}
