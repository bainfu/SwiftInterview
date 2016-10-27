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
            
            if let urlString = person?.imageURL,
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
