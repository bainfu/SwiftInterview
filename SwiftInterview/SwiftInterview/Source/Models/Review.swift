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
    var title: String
    var comment: String
    var reviewerId: String
    
    init(stars: Int, title: String, comment: String, reviewerId: String) {
        self.stars = stars
        self.title = title
        self.comment = comment
        self.reviewerId = reviewerId
        
        super.init()
    }
}
