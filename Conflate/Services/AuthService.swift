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
    
    func getEmailConfiguration() -> ActionCodeSettings {
        
        let actionCodeSettings = ActionCodeSettings()
        //actionCodeSettings.url = URL(string: "https://conflate-343a5.firebaseapp.com")
        
        actionCodeSettings.handleCodeInApp = false
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        return actionCodeSettings
    }
    
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
            self.sendActivationEmail(email:email)
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
    
    func sendActivationEmail(email:String) {
        Auth.auth().sendSignInLink(toEmail:email,
                                   actionCodeSettings: getEmailConfiguration()) { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                        return
                                    }
                                    print("Check your email for link")
                                  
        }
    }
}
