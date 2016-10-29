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
    
    override init() {
        self.stars = -1
        self.comment = ""
        self.reviewerId = ""
        super.init()
    }
    
    init(stars: Int, comment: String, reviewerId: String) {
        self.stars = stars
        self.comment = comment
        self.reviewerId = reviewerId
        
        super.init()
    }
    
    class func parse(dictionary: [String: Any]) -> Review {
        guard let stars = dictionary["stars"] as? Int,
        let comment = dictionary["comment"] as? String,
        let reviewerId = dictionary["reviewerId"] as? String
            else {
                return Review()
        }
        
        return Review(stars: stars, comment: comment, reviewerId: reviewerId)
    }
}
