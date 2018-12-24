//
//  LoginViewModel.swift
//  Conflate
//
//  Created by Mac on 12/24/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation

class LoginViewModel{
    private let authService = AuthService ()
    func signIn(email: String, password: String, handler:@escaping (_ success: Bool) -> ()){
        authService.signInUser(email: email, password: password,handler: handler)
    }
}
