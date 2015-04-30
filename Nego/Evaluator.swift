//
//  Evaluator.swift
//  Nego
//
//  Created by Kohei Hayakawa on 4/18/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import Foundation

class Evaluator: Printable {
    let issue: Issue
    let weight: Double
    let utilities: [Double]
    
    var description: String {
        let dictionary = ["issue":issue, "weight":weight, "utilities":utilities]
        return reflect(self).summary + " : " + dictionary.description
    }
    
    // weight = [0, 1], utilities.count == issue.values.count
    init(issue: Issue, weight: Double, utilities: [Double]) {
        
        if weight < 0.0 || 1.0 < weight {
            NSException(
                name: "Evaluator exeption",
                reason: "Weight is not in correct range",
                userInfo: nil).raise()
        }
        if utilities.count != issue.values.count {
            NSException(
                name: "Evaluator exeption",
                reason: "Utilities count does not equal to issue values count",
                userInfo: nil).raise()
        }
        
        self.issue = issue
        self.weight = weight
        self.utilities = utilities
    }
}