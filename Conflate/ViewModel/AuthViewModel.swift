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
    
    func createUser(userNickName:String, email:String, password:String, handler:@escaping (_ error:Error?,_ user:User?) -> ()) {
        self.authService.createUser(userNickName:userNickName, email: email, password: password, handler: handler)
    }
    
    func sendVerificationEmail(user:User, handler:@escaping (_ error:Error?)->()) {
        self.authService.sendVerificationEmail(user: user, handler: handler)
    }
    
    func signIn(email: String, password: String, handler:@escaping (_ error:Error?, _ user:User?) -> ()) {
        self.authService.signInUser(email: email, password: password,handler: handler)
    }
    
    func resetPassword(email: String, handler:@escaping (_ error:Error?) -> ()) {
        self.authService.resetPassword(email: email, handler: handler)
    }
    
    func loginWithFacebook(_ credentials:AuthCredential, handler:@escaping (_ error:Error?, _ user:User?) -> ()) {
        self.authService.loginWithFacebook(credentials, handler: handler)
    }
    
    func addUser(user: User, handler:@escaping (_ error:Error?)->()){
        let userData:Dictionary<String, String> = [Constants.UserData.provider: user.providerID, Constants.UserData.email: user.email!, Constants.UserData.username: user.displayName!]
        self.userService.addUser(uid: user.uid, userData: userData as Dictionary<String, AnyObject>, handler: handler)
    }
    
    func addPost(lat:String, long:String,participance:String, title:String, user: User, category:String, date:DateFormatter, description:String, handler:@escaping (_ error:Error?)->()){
        
        let coordinates:Dictionary<String, String> = ["lat":lat, "long":long]
        
        let postData:Dictionary<String, AnyObject> = [
            Constants.PostData.location: coordinates as AnyObject,
            Constants.PostData.title: title as AnyObject,
            Constants.PostData.category: category as AnyObject,
            Constants.PostData.date: date as AnyObject,
            Constants.PostData.participents: participance as AnyObject,
            Constants.PostData.description: description as AnyObject
        ]
        
        self.userService.addPost(uid: user.uid, postData: postData, handler: handler)
    }

}
