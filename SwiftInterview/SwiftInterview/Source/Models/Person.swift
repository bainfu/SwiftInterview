//
//  Person.swift
//  SwiftInterview
//
//  Created by Yuxi Lin on 10/20/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    var personId: String
    var name: String
    var personDescription: String
    var imageURL: String?
    var reviews: [Review]?
    
    init(personId: String, name: String, personDescription: String, imageURL: String?) {
        self.personId = personId
        self.name = name
        self.personDescription = personDescription
        self.imageURL = imageURL
        self.reviews = [Review]()
        
        super.init()
    }
    
}
