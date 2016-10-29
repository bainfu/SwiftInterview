//
//  PersonDetailViewController.swift
//  SwiftInterview
//
//  Created by Wesley St. John on 10/26/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

// We are "logged in" as the Guest User
// TODO: move somewhere else
let currentUserId = "0"


class PersonDetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    var person: Person? {
        didSet {
            nameLabel?.text = person?.name
            title = person?.name
            
            if let urlString = person?.imageURL,
                let url = URL(string: urlString),
                let data = try? Data(contentsOf: url) {
                
                profileImageView?.image = UIImage(data: data)
            } else {
                profileImageView?.image = nil
            }
            
            let myReviews = person?.reviews?.filter({$0.reviewerId == currentUserId})
            if myReviews?.count == 0 {
                let button = UIBarButtonItem(title: "Add Review", style: .plain, target: self, action: #selector(PersonDetailViewController.addReviewTapped))
                navigationItem.rightBarButtonItem = button
            }
        }
    }
    
    func addReviewTapped() {
        performSegue(withIdentifier: "AddReviewSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Totally stupid, but im lazy right now
        // value is set before view exists...
        let aPerson = person
        person = aPerson
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddReviewSegue" {
            if let navVC = segue.destination as? UINavigationController,
                let addReviewVC = navVC.topViewController as? AddReviewViewController {
                addReviewVC.completion = { (newReview: Review?) in
                    
                    if let review = newReview {
                        self.person?.reviews?.append(review)
                        self.tableView.reloadData()
                        self.navigationItem.rightBarButtonItem = nil
                    }
                }
            }
        }
    }

}

extension PersonDetailViewController: DataProvider {}

extension PersonDetailViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (person?.reviews!.count)!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row < (person?.reviews!.count)! {
            if let reviewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as? ReviewTableViewCell {
                reviewCell.review = person?.reviews![indexPath.row]
                
                cell = reviewCell
            }
        }
        
        
        return cell
    }
    
}
