//
//  UserModel.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 3/22/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserModel {
    
    var username: String
    var firstName: String
    var lastName: String
    var imageURL: URL
    var email: String
    
    // Uses a failable initializer
    init?(data: JSON) {
        
        // Assures that all the data exists using the guard statement
        guard let email = data["email"].string else {
            return nil
        }
        
        guard let firstname = data["first_name"].string else {
            return nil
        }
        
        guard let lastname = data["last_name"].string else {
            return nil
        }
        
        guard let username = data["username"].string else {
            return nil
        }
        
        // Accessing the profile picture
        guard let imageURLAddress = data["image_url"].string else {
            return nil
        }
        
        guard let imageURL = URL(string: imageURLAddress) else {
            return nil
        }
        
        // Assigning all the values received to the data model
        self.username = username
        self.firstName = firstname
        self.lastName = lastname
        self.imageURL = imageURL
        self.email = email
        
    }
    
}
