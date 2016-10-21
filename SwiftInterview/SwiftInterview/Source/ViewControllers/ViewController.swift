//
//  ViewController.swift
//  SwiftInterview
//
//  Created by Wesley St. John on 10/20/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // TODO: move this somewhere else
    var people: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let people = getAllPeople()
        
        print(people)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: DataProvider {}
