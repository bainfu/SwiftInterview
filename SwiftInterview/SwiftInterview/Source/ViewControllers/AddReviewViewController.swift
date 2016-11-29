//
//  AddReviewViewController.swift
//  SwiftInterview
//
//  Created by Wesley St. John on 10/28/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

class AddReviewViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    // POSSIBLE IMPROVEMENT: Instead of 5 IBOutlets, a better way???
    @IBOutlet var star1: UIButton!
    @IBOutlet var star2: UIButton!
    @IBOutlet var star3: UIButton!
    @IBOutlet var star4: UIButton!
    @IBOutlet var star5: UIButton!
    
    var completion: ((_ newReview: Review?) -> (Void))?
    var numStars: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let submitButton = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(AddReviewViewController.submitTapped(sender:)))
        navigationItem.rightBarButtonItem = submitButton
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddReviewViewController.cancelTapped(sender:)))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    @IBAction func starTapped(sender: AnyObject?) {
        if let button = sender as? UIButton {
            
            let star = UIImage(named: "star")
            let grayStar = UIImage(named: "grayStar")
            
            // POSSIBLE IMPROVEMENT: Instead of 5 IBOutlets, a better way???
            star1.setImage(grayStar, for: .normal)
            star2.setImage(grayStar, for: .normal)
            star3.setImage(grayStar, for: .normal)
            star4.setImage(grayStar, for: .normal)
            star5.setImage(grayStar, for: .normal)
            
            if button.tag >= 1 {
                star1.setImage(star, for: .normal)
            }
            if button.tag >= 2 {
                star2.setImage(star, for: .normal)
            }
            if button.tag >= 3 {
                star3.setImage(star, for: .normal)
            }
            if button.tag >= 4 {
                star4.setImage(star, for: .normal)
            }
            if button.tag >= 5 {
                star5.setImage(star, for: .normal)
            }
            
            numStars = button.tag
        }
    }
    
    @IBAction func submitTapped(sender: AnyObject?) {
        /* NEW FEATURE: ADD NEW REVIEW
        var review: Review?
        if let text = textView.text {
            review = Review(stars: numStars, comment: text, reviewerId: UIApplication.shared.delegate!.currentUserId(), likes: [])
        }

        close(newReview: review)
        */
    }
    
    @IBAction func cancelTapped(sender: AnyObject?) {
        close(newReview: nil)
    }
    
    func close(newReview: Review?) {
        /* NEW FEATURE: ADD NEW REVIEW
        dismiss(animated: true) {
            if let completion = self.completion {
                completion(newReview)
            }
        }
        */
        dismiss(animated: true, completion: nil)
    }

}
