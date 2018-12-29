//
//  UserService.swift
//  Conflate
//
//  Created by Mac on 12/29/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation

protocol UserServise {
    
    func addUser (uid:String,userData: Dictionary<String,AnyObject>, handler:@escaping (_ error:Error?)->())
    
}
