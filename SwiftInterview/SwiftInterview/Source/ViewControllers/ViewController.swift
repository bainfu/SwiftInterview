//
//  ViewController.swift
//  SwiftInterview
//
//  Created by Wesley St. John on 10/20/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    // TODO: move this somewhere else?
    var people: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "People"

        people = getAllPeople()
        print(people)
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: DataProvider {}

extension ViewController: UITableViewDataSource {
    
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
