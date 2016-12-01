# SwiftInterview

/********
 * BUGS *
 ********
 
 *****
 1: Crash upon launch
 Review.parse() tries to explicitly unwrap optionals, so if a value is missing, it will crash
 Possible Fix:
    class func parse(dictionary: [String: Any]) -> Review {
        guard let stars = dictionary["stars"] as? Int,
        let comment = dictionary["comment"] as? String,
        let reviewerId = dictionary["reviewerId"] as? String,
        let likes = dictionary["likes"] as? [String] else {
            return Review()
        }
        return Review(stars: stars, comment: comment, reviewerId: reviewerId, likes: likes)
    }

 *****
 2: Missing person in PersonViewController
 PeoleViewController has a table view showing all People in people.json. However, if a field like 'description' is null,
 Person.parse() will return an empty Person object.
 Possible Fix:
    Make Person.description an optional String,
    Remove this line from the guard statement: let desc = dictionary["description"] as? String
    Update references to description to treat it as an optional String
 
 *****
 3: Person detail information does not show up
 PersonDetailViewController gets its person var set before the view loads. In the didSet for the property, it tries to update the UI, but at that point the views do not exist yet.
 Possible Fix:
    Instead of (or in addition to) updating the UI in didSet, do it in viewDidLoad.
 
 *****
 4: In the Review cell, the label indicating number of likes show the text "Optional()"
 ReviewTableViewCell sets the text of the label without unwrapping it.
 Possible Fix:
    Try to unwrap the value before setting the labels text value.
 
 *****
 5: PersonDetailViewController and ReviewTableViewCell do not deallocate
 In PersonDetailViewController, it provides implementation for a closure owned by each ReviewTableViewCell and passes self, causing a retain cycle.
 Possible Fix:
    Use a weak reference to self.
 
 *****
 6: Sometimes the profile images do not show up in the PersonTableViewCells
 When PersonTableViewCell loads the profile images, it does so on a background thread, but it also updates the UI on that thread.
 Possible Fix:
    Set the image property on the main thread.
 
 *****
 7: Review likes do not persist
 If you like a review, go back, then go back to the PersonDetailViewController, the like will be gone. This happens because Person is a struct, not a class.
 Possible Fix:
    Change Person to a class.
 
 */



/****************
 * NEW FEATURES *
 ****************
 
 *****
 1: Allow user to write a Review for a Person.
 The infrastructure is there, but the implementation is missing.
 Possible Implementation:
    In prepareForSegue of PersonDetailViewController going to AddReviewViewController, add this:
        if let review = newReview {
            self.person?.reviews?.append(review)
            self.tableView.reloadData()
        }
    In AddReviewViewController.submitTapped(), add this:
        var review: Review?
        if let text = textView.text {
            review = Review(stars: numStars, comment: text, reviewerId: UIApplication.shared.delegate!.currentUserId(), likes: [])
        }
        close(newReview: review)
    In AddReviewViewController.close(), change implementation to this:
        dismiss(animated: true) {
            if let completion = self.completion {
                completion(newReview)
            }
        }
 
 *****
 2: Don't let user add a review for someone they have already left a review for
 Possible Implementation:
    Before showing the Add Review button in PersonDetailViewController, add this check:
        let myReviews = person?.reviews?.filter({$0.reviewerId == UIApplication.shared.delegate!.currentUserId()})
        if myReviews?.count == 0 {
            // add or show the button
        }
 
 *****
 3: Unit Tests
 
 
 
 */


/*************************
 * IDEAS FOR IMPROVEMENT *
 *************************

 *****
 1: Image downloading is implemented in 3 or 4 places throughout the app.
 Thoughts:
    Make one function to return an image that everthing uses.
    Where does it go/who owns it? Good question...
 
 *****
 2: Use asynchronous image downloading
 Thoughts:
    Use DispatchQueue().async
    Make sure UI updates happen on main thread.
 
 *****
 3: It seems weird for multiple classes to be DataProvider's
 Thoughts:
    Maybe make a singleton or an app delegate property that is the DataProvider
    Maybe change the DataProvider protocol to be static methods and use a static class/struct to get data
 
 *****
 4: Instead of using 5 UIImageView IBOutlet's, use 1 IBOutlet that is an array of views
 Thoughts:
    There is no IBOutletCollection in swift, but we can use an array of views as an IBOutlet to make the code cleaner.
 
 *****
 5:
 
 
 */



