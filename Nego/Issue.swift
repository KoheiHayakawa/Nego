//
//  Issue.swift
//  Nego
//
//  Created by Kohei Hayakawa on 4/18/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import Foundation

class Issue: Printable {
    let id: Int
    let name: String
    let values: [String]
    
    var description: String {
        let dictionary = ["id":id, "name":name, "values":values]
        return reflect(self).summary + " : " + dictionary.description
    }
    
    init(id: Int, name: String, values: [String]) {
        self.id = id
        self.name = name
        self.values = values
    }
}