//
//  DataProvider.swift
//  SwiftInterview
//
//  Created by Yuxi Lin on 10/20/16.
//  Copyright © 2016 mobileforming. All rights reserved.
//

import UIKit

protocol DataProvider {
    func getAllPeople()
}

extension DataProvider {
    func getAllPeople() {
        let bundle = Bundle(for: ViewController.self)
    }
}
