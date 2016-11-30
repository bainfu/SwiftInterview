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
    @IBOutlet var star1: UIImageView?
    @IBOutlet var star2: UIImageView?
    @IBOutlet var star3: UIImageView?
    @IBOutlet var star4: UIImageView?
    @IBOutlet var star5: UIImageView?

    @IBOutlet var likeButton: UIButton?
    @IBOutlet var likesLabel: UILabel?
    
    var like: ((_ didLike: Bool) -> (Void))?
    var didLike = false
    
    var review: Review? {
        didSet {
            reviewLabel?.text = review?.comment
            
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
            
            didLike = false
            if let likes = review?.likes {
                let myLikes = likes.filter({$0 == UIApplication.shared.delegate!.currentUserId()})
                if myLikes.count > 0 {
                    didLike = true
                }
                
            }
            if didLike {
                likeButton?.setImage(UIImage(named:"likeOn"), for: .normal)
            } else {
                likeButton?.setImage(UIImage(named:"likeOff"), for: .normal)
            }
            
            likesLabel?.text = "\(review?.likes.count)"
        }
    }
    
    @IBAction func likeButtonTapped(sender: UIButton) {
        didLike = !didLike
        if didLike {
            sender.setImage(UIImage(named:"likeOn"), for: .normal)
        } else {
            sender.setImage(UIImage(named:"likeOff"), for: .normal)
        }
        
        if let likeClosure = like {
            likeClosure(didLike)
        }
    }

}

extension ReviewTableViewCell: DataProvider {}
