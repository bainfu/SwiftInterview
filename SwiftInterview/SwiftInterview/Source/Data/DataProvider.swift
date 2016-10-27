//
//  DataProvider.swift
//  SwiftInterview
//
//  Created by Yuxi Lin on 10/20/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

protocol DataProvider {
    func allPeople() -> [Person]
    func person(personId: String) -> Person?
}

extension DataProvider {
    
    func allPeople() -> [Person] {
        let bundle = Bundle(for: PeopleViewController.self)

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
    
    func person(personId: String) -> Person? {
        // Question: Why can't I call allPeople() here without self?
        // "Variable used within its own initial value"
        let allPeople = self.allPeople()
        
        // Improvement: use filter or predicate
        for person: Person in allPeople {
            if person.personId == personId {
                return person
            }
        }
        
        return nil
    }
    
}
