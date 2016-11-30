//
//  PersonTableViewCell.swift
//  SwiftInterview
//
//  Created by Wesley St. John on 10/20/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var descriptionLabel: UILabel?
    
    var person: Person? {
        didSet {
            nameLabel?.text = person?.name
            descriptionLabel?.text = person?.personDescription
            
            // POSSIBLE IMPROVEMENT: Instead of having a block like this in 4 different places, create a method that everyone calls
            let queue = DispatchQueue(label: "com.mobileforming.swiftinterview")
            queue.async {
                
                if let urlString = self.person?.imageURL,
                    let url = URL(string: urlString),
                    let data = try? Data(contentsOf: url) {
                    // EXISTING BUG: Updating UI on background thread
                    self.profileImageView?.image = UIImage(data: data)
                } else {
                    self.profileImageView?.image = nil
                }
            }
        }
    }

}
