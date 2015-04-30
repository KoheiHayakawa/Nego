//
//  Agent.swift
//  Nego
//
//  Created by Kohei Hayakawa on 4/18/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import Foundation

protocol Actionable {
    func action() -> Action
}

class Agent: Printable {
    
    let name: String
    let utilitySpace: UtilitySpace
    
    var myLastSolutionOffer: SolutionOffer?
    var opponentLastSolutionOffer: SolutionOffer?
    
    var description: String {
        let dictionary: [String:AnyObject?] = [
            "name":name,
            "utilitySpace":utilitySpace,
            "myLastSolution":myLastSolutionOffer,
            "opponentLastSolution":opponentLastSolutionOffer]
        return reflect(self).summary + " : " + dictionary.description
    }
    
    init(name: String, utilitySpace: UtilitySpace) {
        self.name = name
        self.utilitySpace = utilitySpace
    }
    
    final func utilityOfSolutionOffer(solution: SolutionOffer) -> Double {
        var utils: [Double] = []
        for i in 0..<solution.valueIndexs.count {
            let realUtil = utilitySpace.evaluators[i].utilities[solution.valueIndexs[i]]
            let maxUtil = maxElement(utilitySpace.evaluators[i].utilities)
            let weight = utilitySpace.evaluators[i].weight
            let util: Double = (realUtil / maxUtil) * weight
            utils.append(util)
        }        
        //let util = utils.reduce(0){(a, b) in a + b} / Double(utils.count)
        let util = utils.reduce(0){(a, b) in a + b}
        return util
    }
    
    final func solutionOfferOfMaxUtility() -> SolutionOffer {
        
        var valueIndexs: [Int] = []
        for i in 0..<utilitySpace.evaluators.count {
            let utilities = utilitySpace.evaluators[i].utilities
            let maxUtil = maxElement(utilities)
            let maxUtilIdx = find(utilities, maxUtil)
            valueIndexs.append(maxUtilIdx!)
        }
        return SolutionOffer(valueIndexs: valueIndexs)
    }
    
}