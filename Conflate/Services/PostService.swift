//
//  PostService.swift
//  Conflate
//
//  Created by Mac on 1/2/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation

protocol PostService {
    func addPost(uid: String, postData: Dictionary<String, AnyObject>,handler:@escaping (_ error:Error?)->())

}
