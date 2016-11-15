//
//  ReviewTableViewCell.swift
//  SwiftInterview
//
//  Created by Wesley St. John on 10/26/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView?
    @IBOutlet var reviewLabel: UILabel?
    
    // Improvement: a better way to do this
    @IBOutlet var star1: UIImageView?
    @IBOutlet var star2: UIImageView?
    @IBOutlet var star3: UIImageView?
    @IBOutlet var star4: UIImageView?
    @IBOutlet var star5: UIImageView?

    var review: Review? {
        didSet {
            reviewLabel?.text = review?.comment
            
            // POSSIBLE IMPROVEMENT: Instead of having a block like this in 4 different places, create a method that everyone calls
            // POSSIBLE IMPROVEMENT: Async load of image?
            if let reviewer = person(personId:(review?.reviewerId)!),
                let urlString = reviewer.imageURL,
                let url = URL(string: urlString),
                let data = try? Data(contentsOf: url) {
                
                profileImageView?.image = UIImage(data: data)
            } else {
                profileImageView?.image = nil
            }
            
            if let numStars = review?.stars {
                star1?.isHidden = numStars < 1
                star2?.isHidden = numStars < 2
                star3?.isHidden = numStars < 3
                star4?.isHidden = numStars < 4
                star5?.isHidden = numStars < 5
            }
        }
    }

}

// POSSIBLE IMPROVEMENT: Don't make everyone a DataProvider, come up with a more elegant solution
extension ReviewTableViewCell: DataProvider {}
