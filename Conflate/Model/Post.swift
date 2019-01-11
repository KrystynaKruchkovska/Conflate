//
//  File.swift
//  Conflate
//
//  Created by Paweł on 02/01/2019.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation

struct Post : Encodable {
    var uuid:String
    var authorID:String
    var title:String
    var description:String
    var numberOfParticipants:Int
    var location:Location
    var date:String
    var category:String
    
    
    init(uuid:String, author:String, title:String, description:String, numberOfParticipants:Int, location:Location, date:String, category:String) {
        self.uuid = uuid
        self.authorID = author
        self.title = title
        self.description = description
        self.numberOfParticipants = numberOfParticipants
        self.location = location
        self.date = date
        self.category = category
    }
}

struct Location : Encodable {
    var lat:Double
    var long:Double
}
