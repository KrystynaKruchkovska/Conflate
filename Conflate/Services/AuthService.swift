//
//  AuthService.swift
//  Conflate
//
//  Created by Mac on 12/27/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Firebase
// we're still dependant on firebase because handler returns firebase user!!

protocol AuthService {
    
    func createUser(email:String, password:String, handler:@escaping (_ error:Error?,_ user:User?) -> ())
    
    func sendVerificationEmail(user:User, handler:@escaping (_ error:Error?)->())
    
    func signInUser(email:String,password:String, handler:@escaping (_ error:Error?, _ user:User?) -> ())
    
    func resetPassword(email:String, handler:@escaping (_ error:Error?) -> ())
    
}

