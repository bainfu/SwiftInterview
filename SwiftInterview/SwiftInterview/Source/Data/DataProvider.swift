//
//  DataProvider.swift
//  SwiftInterview
//
//  Created by Yuxi Lin on 10/20/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

protocol DataProvider {
    func allPeople() -> [PersonStruct]
    func person(personId: String) -> PersonStruct?
}

extension DataProvider {
    
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
    
    func person(personId: String) -> PersonStruct? {
        let peeps = allPeople()
        
        // POSSIBLE IMPROVEMENT: use filter or predicate
        for person: PersonStruct in peeps {
            if person.personId == personId {
                return person
            }
        }
        
        return nil
    }
    
}
