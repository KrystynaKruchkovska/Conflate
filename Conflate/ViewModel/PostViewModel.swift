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
   // var posts:[Post]
    
    private let postService:PostService
    
    init(postService:PostService) {
        self.postService = postService
    }
    
    func addPost(_ post:Post, handler:@escaping (_ error:Error?)->()){
        self.postService.addPost(post:post, handler: handler)
    }
    
    func readPosts(handler: @escaping (_ post: [Post]) -> ()){
        self.postService.readPosts(handler:handler)
    }
    
    func validatePostData(location:Location?, title:String?, particiapntNumber:String?, date:String?, description:String?, currentUser:User?, category:String?, completionHandler:(_ error:Error?, _ post:Post?)->()) {
        
        guard let location = location else {
            let error = createErrorWithMessage("Location not determined yet. Wait or request location.")
            completionHandler(error, nil)
            return
        }
        
        guard let title = title else {
            let error = createInternalError()
            completionHandler(error, nil)
            return
        }
        
        guard let participantNumber = particiapntNumber else {
            let error = createInternalError()
            completionHandler(error, nil)
            return
        }
        
        guard let date = date else {
            let error = createInternalError()
            completionHandler(error, nil)
            return
        }
        
        guard let description = description else {
            let error = createInternalError()
            completionHandler(error, nil)
            return
        }
        
        guard let currentUser = currentUser else {
            let error = createInternalError()
            completionHandler(error, nil)
            return
        }
        guard let category = category else {
            let error = createInternalError()
            completionHandler(error, nil)
            return
        }
        
        let uuid = UUID().uuidString
        
        let post = Post(uuid:uuid, author: currentUser.uid, title: title, description: description, numberOfParticipants: Int(participantNumber)!, location:location, date: date, category: category)
        
        completionHandler(nil, post)
    }
    
    


}
    
