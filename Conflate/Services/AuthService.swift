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
 
    
    func createUser(email:String, password:String, handler:@escaping (_ error:Error?,_ user:User?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            if let error = error {
                print("create user error: \(error)")
                handler(error,nil)
                
                return
            }
            guard let user = authResult?.user else {
                handler(error,nil)
                return
            }
       
            handler(nil,user)
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
    
    func signInUser(email:String,password:String, handler:@escaping (_ error:Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                print("login user error: \(error)")
                handler(error)
                return
            }
            
            guard let user = user?.user else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Internal error"])
                handler(error)
                return
            }
            
            if !user.isEmailVerified {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Email for your account is not verified. Check your email or RESEND EMAIL-TODO"])
                handler(error)
                return
            }
            
            handler(nil)
        }
    }
    
}
