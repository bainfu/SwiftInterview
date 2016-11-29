//
//  DataCoordinator.swift
//  SwiftInterview
//
//  Created by Yuxi Lin on 11/28/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

class DataCoordinator: DataProvider {

    let jsonFile: String
    
    init(jsonFileName: String) {
        self.jsonFile = jsonFileName
    }
    
    func allPeople() -> [PersonStruct] {
        let bundle = Bundle(for: PeopleViewController.self)
        
        guard let path = bundle.path(forResource: "people", ofType: "json"), let data = NSData(contentsOfFile: path) as? Data else {
            print("trouble converting json file to data")
            return [PersonStruct]()
        }
        
        var people = [PersonStruct]()
        
        if let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
            
            for person in jsonArray! {
                let p = PersonStruct.parse(dictionary: person)
                people.append(p)
            }
        }
        return people

    }
}
