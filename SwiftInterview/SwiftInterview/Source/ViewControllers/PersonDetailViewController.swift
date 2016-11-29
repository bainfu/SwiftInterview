//
//  PersonDetailViewController.swift
//  SwiftInterview
//
//  Created by Wesley St. John on 10/26/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    var person: Person? {
        didSet {
            nameLabel?.text = person?.name
            title = person?.name
            
            // POSSIBLE IMPROVEMENT: Instead of having a block like this in 4 different places, create a method that everyone calls
            // POSSIBLE IMPROVEMENT: Async load of image?
            if let urlString = person?.imageURL,
                let url = URL(string: urlString),
                let data = try? Data(contentsOf: url) {
                
                profileImageView?.image = UIImage(data: data)
            } else {
                profileImageView?.image = nil
            }
            
            
            // POSSIBLE IMPROVEMENT: Don't let the user leave a review of a person if they have already left one
            /*let myReviews = person?.reviews?.filter({$0.reviewerId == UIApplication.shared.delegate!.currentUserId()})
            if myReviews?.count == 0 {*/
                let button = UIBarButtonItem(title: "Add Review", style: .plain, target: self, action: #selector(PersonDetailViewController.addReviewTapped))
                navigationItem.rightBarButtonItem = button
            /*}*/
        }
    }
    
    func addReviewTapped() {
        performSegue(withIdentifier: "AddReviewSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // EXISTING BUG: The var "person" gets set before viewDidLoad, so the UI doesn't exist yet, so you don't see the label/image view update
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddReviewSegue" {
            if let navVC = segue.destination as? UINavigationController,
                let addReviewVC = navVC.topViewController as? AddReviewViewController {
                addReviewVC.completion = { (newReview: Review?) in
                    
                    /* NEW FEATURE: ADD NEW REVIEW
                    if let review = newReview {
                        self.person?.reviews?.append(review)
                        self.tableView.reloadData()
                    }
                    */
                }
            }
        }
    }

}

extension PersonDetailViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (person?.reviews!.count)!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row < (person?.reviews!.count)! {
            if let reviewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as? ReviewTableViewCell {
                reviewCell.review = person?.reviews![indexPath.row]
                
                reviewCell.like = {(didLike: Bool) -> (Void) in

                    // EXISTING BUG: Capturing self in closure causes a retain cycle!
                    //self.person?.reviews![indexPath.row].likes = (self.person?.reviews![indexPath.row].likes)! + delta
                    
                    if didLike {
                        self.person?.reviews![indexPath.row].likes.append("0")
                    } else {
                        self.person?.reviews![indexPath.row].likes = (self.person?.reviews![indexPath.row].likes.filter {
                            $0 != UIApplication.shared.delegate!.currentUserId()
                            })!
                    }
                    
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
                
                cell = reviewCell
            }
        }
        
        return cell
    }
    
}
