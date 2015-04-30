//
//  Math.swift
//  Nego
//
//  Created by Kohei Hayakawa on 4/28/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import Foundation

class Math {

    class func sum(array: [Double]) -> Double {
        return array.reduce(0){$0+$1}
    }
    
    class func average(array: [Double]) -> Double {
        return sum(array) / Double(array.count)
    }
    
    class func variance(array: [Double]) -> Double {
        let ave = average(array)
        return array.reduce(0){$0+pow(($1-ave),2)} / Double(array.count)
    }
}