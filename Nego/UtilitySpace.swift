//
//  UtilitySpace.swift
//  Nego
//
//  Created by Kohei Hayakawa on 4/18/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import Foundation

class UtilitySpace: Printable {
    let evaluators: [Evaluator]
    
    var description: String {
        return reflect(self).summary + " : " + evaluators.description
    }
    
    init(evaluators: [Evaluator]) {
        self.evaluators = evaluators
    }
    
    class func calcUtilityDistance(#utilitySpace1: UtilitySpace, utilitySpace2: UtilitySpace) -> Double {
        
        var dist = 0.0
        for i in 0..<utilitySpace1.evaluators.count {

            var sum = 0.0
            let weight1 = utilitySpace1.evaluators[i].weight
            let weight2 = utilitySpace2.evaluators[i].weight
            let utilities1 = utilitySpace1.evaluators[i].utilities.map{$0 * weight1}
            let utilities2 = utilitySpace2.evaluators[i].utilities.map{$0 * weight2}
            let maxUtil = maxElement(utilities1+utilities2)
            
            for j in 0..<utilities1.count {
                sum += pow(utilities1[j] - utilities2[j], 2)
            }
            dist += sqrt(sum / Double(utilities1.count)) / maxUtil
        }
        return dist / Double(utilitySpace1.evaluators.count)
    }
}