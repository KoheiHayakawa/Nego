//
//  Negotiation.swift
//  Nego
//
//  Created by Kohei Hayakawa on 4/19/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

// compromise = [0, 1], belief = [0, 1], regretable = ?

import Foundation

class Negotiation {
    
    //private let scenarioName = "FiftyFifty"
    //private let scenarioName = "Laptop"
    //private let scenarioName = "Energy"
    //private let scenarioName = "Car"
    
    private let scenarioName = "UtilityDistanceTest"

    
    private let agentA: SampleAgent
    private let agentB: SampleAgent
    
    init() {

        let domainFile = "scenario/\(scenarioName)/domain"
        let profAFile = "scenario/\(scenarioName)/profA"
        let profBFile = "scenario/\(scenarioName)/profB"

        // Setup domain
        var path: String = NSBundle.mainBundle().pathForResource(domainFile, ofType: "json")!
        var fileHandle: NSFileHandle = NSFileHandle(forReadingAtPath: path)!
        var data: NSData = fileHandle.readDataToEndOfFile() as NSData
        var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! [[String:AnyObject]]
        
        var issues: [Issue] = []
        for i in 0..<json.count {
            let id = json[i]["id"] as! Int
            let name = json[i]["name"] as! String
            let values = json[i]["values"] as! [String]
            issues.append(Issue(id: id, name: name, values: values))
        }
        
        
        // Setup agent of side A
        path = NSBundle.mainBundle().pathForResource(profAFile, ofType: "json")!
        fileHandle = NSFileHandle(forReadingAtPath: path)!
        data = fileHandle.readDataToEndOfFile() as NSData
        json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! [[String:AnyObject]]
        
        var evaluators: [Evaluator] = []
        for i in 0..<json.count {
            let weight = json[i]["weight"] as! Double
            let values = json[i]["values"] as! [Double]
            evaluators.append(Evaluator(issue: issues[i], weight: weight, utilities: values))
        }
        let utilitySpaceOfAgentA = UtilitySpace(evaluators: evaluators)
        agentA = SampleAgent(name: "A", utilitySpace: utilitySpaceOfAgentA)

        
        // Setup agent of side B
        path = NSBundle.mainBundle().pathForResource(profBFile, ofType: "json")!
        fileHandle = NSFileHandle(forReadingAtPath: path)!
        data = fileHandle.readDataToEndOfFile() as NSData
        json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! [[String:AnyObject]]
        
        evaluators = []
        for i in 0..<json.count {
            let weight = json[i]["weight"] as! Double
            let values = json[i]["values"] as! [Double]
            evaluators.append(Evaluator(issue: issues[i], weight: weight, utilities: values))
        }
        let utilitySpaceOfAgentB = UtilitySpace(evaluators: evaluators)
        agentB = SampleAgent(name: "B", utilitySpace: utilitySpaceOfAgentB)
        
        
        // Setup first solution
        agentA.myLastSolutionOffer = agentA.solutionOfferOfMaxUtility()
        agentA.opponentLastSolutionOffer = agentB.solutionOfferOfMaxUtility()
        
        agentB.myLastSolutionOffer = agentB.solutionOfferOfMaxUtility()
        agentB.opponentLastSolutionOffer = agentA.solutionOfferOfMaxUtility()
    }
    
    func calcUtilityDistance() {
        let utilityDistance = UtilitySpace.calcUtilityDistance(utilitySpace1: agentA.utilitySpace, utilitySpace2: agentB.utilitySpace)
        println(utilityDistance)
    }
    
    func run() {
        
        println("Agent A")
        println(agentA.myLastSolutionOffer)
        println(agentA.utilityOfSolutionOffer(agentA.myLastSolutionOffer!))
        println("")
        println("Agent B")
        println(agentB.myLastSolutionOffer)
        println(agentB.utilityOfSolutionOffer(agentB.myLastSolutionOffer!))
        println("")
        
        var endNegotiation = false
        var round = 0
        
        while !endNegotiation {
            
            // A
            round++
            println("Round: \(round)")
            
            let actionOfAgentA: Action = agentA.action()
            agentA.myLastSolutionOffer = actionOfAgentA.solutionOffer
            agentB.opponentLastSolutionOffer = actionOfAgentA.solutionOffer
            
            println("Agent A")
            println(actionOfAgentA)
            println(agentA.utilityOfSolutionOffer(actionOfAgentA.solutionOffer!))
            println("")
            
            if agentA.myLastSolutionOffer == agentB.myLastSolutionOffer {
                println("End negotiation")
                println(agentA.utilityOfSolutionOffer(agentA.myLastSolutionOffer!))
                println(agentB.utilityOfSolutionOffer(agentB.myLastSolutionOffer!))
                break
            }
            

            // B
            round++
            println("Round: \(round)")
            
            let actionOfAgentB: Action = agentB.action()
            agentB.myLastSolutionOffer = actionOfAgentB.solutionOffer
            agentA.opponentLastSolutionOffer = actionOfAgentB.solutionOffer
            
            println("Agent B")
            println(actionOfAgentB)
            println(agentB.utilityOfSolutionOffer(actionOfAgentB.solutionOffer!))
            println("")
            
            if agentA.myLastSolutionOffer == agentB.myLastSolutionOffer {
                println("End negotiation")
                println(agentA.utilityOfSolutionOffer(agentA.myLastSolutionOffer!))
                println(agentB.utilityOfSolutionOffer(agentB.myLastSolutionOffer!))
                break
            }
        }
    }
    
}