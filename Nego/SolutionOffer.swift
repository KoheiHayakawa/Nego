//
//  Solution.swift
//  Nego
//
//  Created by Kohei Hayakawa on 4/18/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import Foundation

class SolutionOffer: Printable, Equatable {
    
    var valueIndexs: [Int]
    
    var description: String {
        let dictionary = ["valueIndexs":valueIndexs]
        return reflect(self).summary + " : " + dictionary.description
    }
    
    init(valueIndexs: [Int]) {
        self.valueIndexs = valueIndexs
    }
    
}

func ==(lhs: SolutionOffer, rhs: SolutionOffer) -> Bool {
    //return lhs.description == rhs.description
    return lhs.valueIndexs == rhs.valueIndexs
}