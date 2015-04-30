//
//  UtilityOffer.swift
//  Nego
//
//  Created by Kohei Hayakawa on 4/18/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import Foundation

class UtilityOffer: Printable {
    
    let issueID: Int
    let utility: Double
    let utilityIndex: Int
    
    var description: String {
        let dictionary = ["issueID":issueID, "utility":utility, "utilityIndex":utilityIndex]
        return reflect(self).summary + " : " + dictionary.description
    }
    
    init(issueID: Int, utility: Double, utilityIndex: Int) {
        self.issueID = issueID
        self.utility = utility
        self.utilityIndex = utilityIndex
    }
    
}