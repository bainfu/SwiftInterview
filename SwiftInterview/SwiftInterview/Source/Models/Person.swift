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
    
    override init() {
        personId = ""
        name = ""
        personDescription = ""
        imageURL = ""
        reviews = [Review]()
    }
    
    init(personId: String, name: String, personDescription: String, imageURL: String? = nil, reviews: [Review]? = [Review]()) {
        self.personId = personId
        self.name = name
        self.personDescription = personDescription
        self.imageURL = imageURL
        self.reviews = reviews
        
        super.init()
    }
    
    // TODO: task for interviewer: make description optional from incoming json?
    class func parse(dictionary: [String: Any]) -> Person {
        guard let personId = dictionary["personId"] as? String,
        let name = dictionary["name"] as? String,
        let desc = dictionary["description"] as? String
            else {
                return Person()
        }
        
        let imageURL = dictionary["imageUrl"] as? String
        
        var reviewArray = [Review]()
        if let reviews = dictionary["reviews"] as? [[String: Any]] {
            
            for review in reviews {
                let rev = Review.parse(dictionary: review)
                reviewArray.append(rev)
            }
        }
        
        return Person(personId: personId, name: name, personDescription: desc, imageURL: imageURL, reviews: reviewArray)
    }
}
