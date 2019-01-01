//
//  AuthService.swift
//  Conflate
//
//  Created by Mac on 12/27/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Firebase
// Facebook credentials are passed uisng Firebase object so we're dependant on firebase

protocol AuthService {
    
    func createUser(nickname:String,email:String, password:String, handler:@escaping (_ error:Error?,_ user:CUser?) -> ())
    
    func sendVerificationEmail(user:CUser, handler:@escaping (_ error:Error?)->())
    
    func signInUser(email:String,password:String, handler:@escaping (_ error:Error?,_ user:CUser?) -> ())
    
    func resetPassword(email:String, handler:@escaping (_ error:Error?) -> ())
    
    func loginWithFacebook(_ credentials:AuthCredential, handler:@escaping (_ error:Error?,_ user:CUser?) -> ())
    
}

