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
    
    func addPost(location:Location, participants:String?, title:String, user: User, category:String, date:Double, description:String, handler:@escaping (_ error:Error?)->()){
   
        let post = Post(author: user.uid, title: title, description: description, numberOfParticipants: Int(participants!)!, location:location, date: date, category: category)
        
        self.postService.addPost(post:post, handler: handler)
    }

}
