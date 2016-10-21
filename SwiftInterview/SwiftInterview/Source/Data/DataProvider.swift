//
//  DataProvider.swift
//  SwiftInterview
//
//  Created by Yuxi Lin on 10/20/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

protocol DataProvider {
    func getAllPeople() -> [Person]
}

extension DataProvider {
    
    func getAllPeople() -> [Person] {
        let bundle = Bundle(for: ViewController.self)

        guard let path = bundle.path(forResource: "people", ofType: "json"), let data = NSData(contentsOfFile: path) as? Data else {
            print("trouble converting json file to data")
            return [Person]()
        }

        var people = [Person]()

        if let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
            
            for person in jsonArray! {
                let p = Person.parse(dictionary: person)
                people.append(p)
            }
        }
        return people
    }
    
}
