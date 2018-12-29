//
//  AuthService.swift
//  Conflate
//
//  Created by Mac on 12/24/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAuthService: AuthService {
    
    func loginWithFacebook(_ credentials: AuthCredential, handler: @escaping (Error?) -> ()) {
        
        Auth.auth().signInAndRetrieveData(with: credentials) { (authResult, error) in
            if let error = error {
                print(error)
                handler(error)
                return
            }
            
            print("user is signed in with facebook")
            handler(nil)
        }
        
    }
    
    
    func resetPassword(email: String, handler: @escaping (_ error:Error?) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil{
                print("create user error: \(String(describing: error))")
                handler(error)
                return
            }
            
            handler(nil)
        }
    }
    
 
    func createUser(email:String, password:String, handler:@escaping (_ error:Error?,_ user:User?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            if let error = error {
                print("create user error: \(error)")
                handler(error, nil)
                
                return
            }
            guard let user = authResult?.user else {
                handler(error, nil)
                return
            }
       
            handler(nil, user)
        }
        
    }
    
    func sendVerificationEmail(user:User, handler:@escaping (_ error:Error?)->()){
        user.sendEmailVerification(completion: { error in
            if let error = error {
                print(error.localizedDescription)
                handler(error)
                return
            }
            print("Check your email for link")
            handler(nil)
            
        })
    }
    
    func signInUser(email:String,password:String, handler:@escaping (_ error:Error?, _ user:User?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                print("login user error: \(error)")
                handler(error, nil)
                return
            }
            
            guard let user = user?.user else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Internal error"])
                handler(error, nil)
                return
            }

            handler(nil, user)
        }
    }
    
   
    
}
