//
//  Action.swift
//  Nego
//
//  Created by Kohei Hayakawa on 4/18/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import Foundation

enum ActionType: String {
    case Accept = "Accept"
    case OfferSolution = "OfferSolution"
    case OfferUtility = "OfferUtility"
}

class Action: Printable {
    
    let type: ActionType
    var solutionOffer: SolutionOffer?

    var description: String {
        let dictionary: [String:AnyObject?] = ["type":type.rawValue, "solutionOffer":solutionOffer]
        return reflect(self).summary + " : " + dictionary.description
    }
    
    init(type: ActionType) {
        self.type = type
    }
    
    init(type: ActionType, solutionOffer: SolutionOffer) {
        self.type = type
        self.solutionOffer = solutionOffer
    }
}