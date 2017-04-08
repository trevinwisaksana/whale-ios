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
    
    var inquirerFirstName: String
    var inquirerLastName: String
    var username: String
    var profileImageURL: URL
    var thumbnailURL: URL
    var likesCount: Int?
    var videoURL: URL
    var question: String
    
    init?(json: JSON) {
        
        guard let thumbnailURL: URL = json["thumbnail_url"].url else { return nil }
        
        guard let videoURL: URL = json["video_url"].url else { return nil }
        
        guard let questionData: [String : JSON] = json["question"].dictionary else { return nil }
        
        guard let content: String = questionData["content"]?.string else { return nil }

        guard let sender: [String : JSON] = questionData["sender"]?.dictionary else { return nil }
        
        guard let username: String = sender["username"]?.string else { return nil }
        
        guard let lastName: String = sender["last_name"]?.string else { return nil }
        
        guard let firstName: String = sender["first_name"]?.string else { return nil }
        
        guard let imageURL: URL = sender["image_url"]?.url else { return nil }
        
        let likesCount = json["likes_count"].int
        
        self.question = content
        self.inquirerFirstName = firstName
        self.inquirerLastName = lastName
        self.likesCount = likesCount
        self.videoURL = videoURL
        self.profileImageURL = imageURL
        self.thumbnailURL = thumbnailURL
        self.username = username
        
    }
    
}


