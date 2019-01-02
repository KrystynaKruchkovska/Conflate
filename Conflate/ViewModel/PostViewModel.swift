//
//  PostViewModel.swift
//  Conflate
//
//  Created by Mac on 1/2/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import Firebase

class PostViewModel {
    private let postService:PostService
    
    init(postService:PostService) {
        self.postService = postService
    }
    
    func addPost(lat:String, long:String, participants:String?, title:String, user: User, category:String, date:Double, description:String, handler:@escaping (_ error:Error?)->()){
        
        let coordinates:Dictionary<String, String> = ["lat":lat, "long":long]
        
        let postData:Dictionary<String, AnyObject> = [
            Constants.PostData.location: coordinates as AnyObject,
            Constants.PostData.title: title as AnyObject,
            Constants.PostData.category: category as AnyObject,
            Constants.PostData.date: date as AnyObject,
            Constants.PostData.participants: participants as AnyObject,
            Constants.PostData.description: description as AnyObject
        ]
        
        self.postService.addPost(uid: user.uid, postData: postData, handler: handler)
    }
}
