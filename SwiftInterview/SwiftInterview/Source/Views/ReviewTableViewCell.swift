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

    var review: Review? {
        didSet {
            reviewLabel?.text = review?.comment
            
            // Improvement: ? ! ? !
            if let reviewer = person(personId:(review?.reviewerId)!),
                let urlString = reviewer.imageURL,
                let url = URL(string: urlString),
                let data = try? Data(contentsOf: url) {
                
                profileImageView?.image = UIImage(data: data)
            } else {
                profileImageView?.image = nil
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


// This is getting ridiculous
extension ReviewTableViewCell: DataProvider {}
