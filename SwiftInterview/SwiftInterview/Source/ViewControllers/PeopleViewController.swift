//
//  PeopleViewController.swift
//  SwiftInterview
//
//  Created by Wesley St. John on 10/20/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var people: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "People"

        let allPersons = allPeople()
        // show everyone except the current user
        people = allPersons.filter({$0.personId != UIApplication.shared.delegate!.currentUserId()})
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowReviews" {
            if let vc = segue.destination as? PersonDetailViewController,
                let cell = sender as? PersonTableViewCell {
                vc.person = cell.person
            }
        }
    }
    

}

// POSSIBLE IMPROVEMENT: Don't make each VC a DataProvider, come up with a more elegant solution
extension PeopleViewController: DataProvider {}

extension PeopleViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (people?.count)!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row < (people?.count)! {
            if let personCell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell") as? PersonTableViewCell {
                personCell.person = people?[indexPath.row]
                
                cell = personCell
            }
        }
        
        return cell
    }
    
}
