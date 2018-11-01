//
//  Review.swift
//  SwiftInterview
//
//  Created by Yuxi Lin on 10/20/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

class Review: NSObject {
    
    var stars: Int
    var comment: String
    var reviewerId: String
    var likes: [String]
    
    override init() {
        self.stars = -1
        self.comment = ""
        self.reviewerId = ""
        self.likes = [];
        super.init()
    }
    
    init(stars: Int, comment: String, reviewerId: String, likes: [String]) {
        self.stars = stars
        self.comment = comment
        self.reviewerId = reviewerId
        self.likes = likes
        
        super.init()
    }
    
    class func parse(dictionary: [String: Any]) -> Review {
        return Review(stars: dictionary["stars"] as! Int,
                      comment: dictionary["comment"] as! String,
                      reviewerId: dictionary["reviewerId"] as! String,
                      likes: dictionary["likes"] as! [String])
    }

}
