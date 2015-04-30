//
//  SampleAgent.swift
//  Nego
//
//  Created by Kohei Hayakawa on 4/18/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import Foundation

class SampleAgent: Agent, Actionable {
    
    var bidHistory: [SolutionOffer] = []
    
    func action() -> Action {
        
//        if myLastSolutionOffer! == opponentLastSolutionOffer! {
//            return Action(type: .Accept)
//        }
//        
        if utilityOfSolutionOffer(opponentLastSolutionOffer!) > utilityOfSolutionOffer(myLastSolutionOffer!) {
            return Action(type: .OfferSolution, solutionOffer: opponentLastSolutionOffer!)
        }
        
        let issueCount = utilitySpace.evaluators.count
        let issueID = Int(arc4random() % UInt32(issueCount))
        
        var utility = 0.0
        let myLastUtility = utilityOfSolutionOffer(myLastSolutionOffer!)
        var solutionOffer = SolutionOffer(valueIndexs: myLastSolutionOffer!.valueIndexs)

        //let baseSolutionOffer = myLastSolutionOffer!
        
        for i in 0..<utilitySpace.evaluators.count {
            for j in 0..<utilitySpace.evaluators[i].utilities.count {
            //for j in 0..<utilitySpace.evaluators[issueID].utilities.count {
            
                let baseSolutionOffer = SolutionOffer(valueIndexs: myLastSolutionOffer!.valueIndexs)
                baseSolutionOffer.valueIndexs[i] = j
                let tmpSolutionOffer = SolutionOffer(valueIndexs: baseSolutionOffer.valueIndexs)
                let tmpUtility = utilityOfSolutionOffer(tmpSolutionOffer)
            
                //if tmpUtility < myLastUtility && utility < tmpUtility{
                if !contains(bidHistory, tmpSolutionOffer) && utility < tmpUtility {
                    solutionOffer = tmpSolutionOffer
                    utility = tmpUtility
                }
            }
        }
        bidHistory.append(solutionOffer)
        return Action(type: .OfferSolution, solutionOffer: solutionOffer)
    }
    
}