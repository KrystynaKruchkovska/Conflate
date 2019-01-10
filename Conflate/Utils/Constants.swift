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
        static let location_Is_not_authorized = "Location is not authorized"
        static let facebook_login_fail = "Facebook login did not succeed"
        static let fatalError = "The dequeued cell is not an instance of  mentioned TableViewCell."
    }
    
    struct UserData {
        static let provider = "provider"
        static let email = "email"
        static let username = "username"
    }
    
    struct PostData {
        static let locationLat = "location/lat"
        static let locationLong = "location/long"
        static let category = "category"
        static let date = "date"
        static let title = "title"
        static let participants = "numberOfParticipants"
        static let description = "description"
    }
    
    struct ReusableIdentifier {
        static let postTableViewCell = "postTableViewCell"
        static let categoryPopVCViewCell = "CategoryCell"
        static let mapPin = "droppablePin"
    }
    
    struct CategoryImage {
        static let lostAndFound = "lostAndFound"
        static let healthAndFitness = "healthAndFitness"
        static let party = "party"
    }
    
    struct CategoryTitle {
        static let lostAndFound = "Lost/Found Item"
        static let healthAndFitness = "Health&Fitness"
        static let party = "Party"
    }
    
}
