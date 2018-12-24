//
//  SignUpViewModel.swift
//  Conflate
//
//  Created by Mac on 12/24/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation

class SignUpViewModel{
    private let authService = AuthService()
    
    func createUser(email:String, password:String, handler:@escaping (_ error:Error?) -> ()) {
        self.authService.createUser(email: email, password: password, handler: handler)
    }
    
}
