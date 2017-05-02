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
    var inquirerFirstName: String
    var inquirerLastName: String
    var username: String
    var profileImageURL: URL
    
    
    init?(json: JSON) {
        
        guard let question: String = json["content"].string else {
            return nil
        }
        
        guard let sender = json["sender"].dictionary else {
            return nil
        }
        
        guard let lastName: String = sender["last_name"]?.string else { return nil
        }
        
        guard let firstName: String = sender["first_name"]?.string else { return nil
        }
        
        guard let imageURL: URL = sender["image_url"]?.url else {
            return nil
        }
        
        guard let username: String = sender["username"]?.string else {
            return nil
        }
        
        
        self.question = question
        self.inquirerFirstName = firstName
        self.inquirerLastName = lastName
        self.profileImageURL = imageURL
        self.username = username
        
    }
    
}
