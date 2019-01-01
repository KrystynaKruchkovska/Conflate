//
//  User.swift
//  Conflate
//
//  Created by Paweł on 01/01/2019.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation

protocol CUser {
    var email: String { get }
    var nickname: String { get }
    var uid: String { get }
    var providerID: String { get }
    var isEmailVerified: Bool { get }
    
    func sendEmailVerification(completion: @escaping (Error?) -> ())
}
