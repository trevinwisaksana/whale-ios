//
//  Question.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 3/31/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Question {
    
    let question: String
    
    init?(data: JSON) {
        guard let question: String = data["question"].string else { return nil }
        self.question = question
    }
    
}
