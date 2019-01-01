//
//  FirebaseUser.swift
//  Conflate
//
//  Created by Paweł on 01/01/2019.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import Firebase

class FirebaseUser : CUser {

    let user:User
    var _nickname:String
    
    init(withUser user:User, nickname:String = "") {
        self.user = user
        self._nickname = nickname
    }
    
    var uid: String {
        get { return self.user.uid }
    }

    var providerID: String  {
        get { return self.user.providerID }
    }
    
    var email: String  {
        get { return self.user.email ?? "" }
    }
    
    var nickname: String  {
        get {
            if self._nickname != "" {
                return self._nickname
            } else {
                return self.user.displayName ?? ""
            }
        }
    }
    
    var isEmailVerified: Bool  {
        get { return self.user.isEmailVerified }
    }
    
    func sendEmailVerification(completion: @escaping (Error?) -> ()) {
        self.user.sendEmailVerification(completion: completion)
    }
}
