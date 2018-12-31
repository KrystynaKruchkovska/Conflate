//
//  Constants.swift
//  Conflate
//
//  Created by Paweł on 24/12/2018.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Storyboard {
        static let authSB = "Auth"
        static let signInVC = "SignInVC"
        static let forgotPasswordVC = "ForgotPasswordVC"
    }
    
    struct Alerts {
        static let errorAlertTitle = "Oops"
        static let successAlertTitle = "Whoop"
        static let resend = "Resend"
    }
    
    struct Strings {
        static let password_reset = "You can reset your password now, check your email"
        static let forgot = "Forgot?"
        static let internal_error = "Internal error : ("
        static let verification_sent = "Verification email was sent successfully, check your email"
        static let different_passwords = "Password should be the same"
        static let verification_invalid = "Your account is not verified. Click \"Resend\" if you want us to resend activation email"
    }
    
    struct  UserData {
        static let provider = "provider"
        static let email = "email"
        static let username = "username"
    }
    
}
