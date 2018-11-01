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
            
            if let urlString = person?.imageURL,
                let url = URL(string: urlString),
                let data = try? Data(contentsOf: url) {
                
                profileImageView?.image = UIImage(data: data)
            } else {
                profileImageView?.image = nil
            }
            
        }
    }
    
    @objc func addReviewTapped() {
        performSegue(withIdentifier: "AddReviewSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddReviewSegue" {
            if let navVC = segue.destination as? UINavigationController,
                let addReviewVC = navVC.topViewController as? AddReviewViewController {
                addReviewVC.completion = { (newReview: Review?) in
                    
                }
            }
        }
    }
    
    private func addReviewButton() {
        let button = UIBarButtonItem(title: "Add Review", style: .plain, target: self, action: #selector(PersonDetailViewController.addReviewTapped))
        navigationItem.rightBarButtonItem = button
    }

}

extension PersonDetailViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let person = person,
            let reviews = person.reviews else {
            return 0
        }
        return reviews.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if let reviewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as? ReviewTableViewCell {
            reviewCell.review = person?.reviews?[indexPath.row]
            
            reviewCell.like = {(didLike: Bool) -> (Void) in
                
                if didLike {
                    self.person!.reviews![indexPath.row].likes.append("0")
                } else {
                    self.person!.reviews![indexPath.row].likes = (self.person!.reviews![indexPath.row].likes.filter {
                        $0 != UIApplication.shared.delegate!.currentUserId()
                        })
                }
                
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            cell = reviewCell
        }
        
        return cell
    }
    
}
