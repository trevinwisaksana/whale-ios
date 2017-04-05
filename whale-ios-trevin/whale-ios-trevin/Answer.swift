//
//  Answer.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 3/22/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Answer {
    
    var question: [String : JSON]
    var inquirerFirstName: String
    var inquirerLastName: String
    var username: String
    // var thumbnail_url: String
    // var likesCount: Int?
    // var videoURL: String
    var content: String
    
    init?(json: JSON) {
        
        // guard let videoURL = data["video_url"]?.string else { return nil }
        
        // guard let likesCount = data["likes_count"]?.int else { return nil }
        
        guard let question: [String : JSON] = json["question"].dictionary else { fatalError("Question not found") }

        
        guard let sender: [String : Any] = question["sender"]?.dictionaryObject else { fatalError("Sender not found") }
        
        guard let username: String = sender["username"] as? String else { return nil }
        
        guard let lastName: String = sender["last_name"] as? String else { return nil }
        
        guard let firstName: String = sender["first_name"] as? String else { return nil }
        
        guard let content: String = question["content"]?.string else { return nil }
        
        self.question = question
        self.inquirerFirstName = firstName
        self.inquirerLastName = lastName
        // self.thumbnail_url = thumbnail_url
        // self.likesCount = likesCount
        // self.videoURL = videoURL
        self.content = content
        self.username = username
        
    }
    
}


