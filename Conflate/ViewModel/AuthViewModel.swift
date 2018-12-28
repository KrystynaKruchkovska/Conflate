//
//  SignUpViewModel.swift
//  Conflate
//
//  Created by Mac on 12/24/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import Firebase

class AuthViewModel {
    
    private let authService:AuthService
    
    init(authService:AuthService) {
        self.authService = authService
    }
    
    func createUser(email:String, password:String, handler:@escaping (_ error:Error?,_ user:User?) -> ()) {
        self.authService.createUser(email: email, password: password, handler: handler)
    }
    
    func sendVerificationEmail(user:User,handler:@escaping (_ error:Error?)->()){
        self.authService.sendVerificationEmail(user: user, handler: handler)
    }
    
    func signIn(email: String, password: String, handler:@escaping (_ error:Error?, _ user:User?) -> ()){
        self.authService.signInUser(email: email, password: password,handler: handler)
    }
    
    func resetPassword(email: String,handler:@escaping (_ error:Error?) -> ()){
        self.authService.resetPassword(email: email, handler: handler)
    }

}
