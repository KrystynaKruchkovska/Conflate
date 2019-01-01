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
    private let userService: UserServise
    
    init(authService:AuthService,userService: UserServise) {
        self.authService = authService
        self.userService = userService
    }
    
    func createUser(nickname:String, email:String, password:String, handler:@escaping (_ error:Error?,_ user:CUser?) -> ()) {
        self.authService.createUser(nickname:nickname, email: email, password: password, handler: handler)
    }
    
    func sendVerificationEmail(user:CUser, handler:@escaping (_ error:Error?)->()) {
        self.authService.sendVerificationEmail(user: user, handler: handler)
    }
    
    func signIn(email: String, password: String, handler:@escaping (_ error:Error?, _ user:CUser?) -> ()) {
        self.authService.signInUser(email: email, password: password, handler: handler)
    }
    
    func resetPassword(email: String, handler:@escaping (_ error:Error?) -> ()) {
        self.authService.resetPassword(email: email, handler: handler)
    }
    
    func loginWithFacebook(_ credentials:AuthCredential, handler:@escaping (_ error:Error?, _ user:CUser?) -> ()) {
        self.authService.loginWithFacebook(credentials, handler: handler)
    }
    
    func addUser(user: CUser, handler:@escaping (_ error:Error?)->()){
        let userData:Dictionary<String, String> = [Constants.UserData.provider: user.providerID, Constants.UserData.email: user.email, Constants.UserData.username: user.nickname]
        self.userService.addUser(uid: user.uid, userData: userData as Dictionary<String, AnyObject>, handler: handler)
    }

}
