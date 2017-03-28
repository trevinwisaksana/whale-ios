//
//  APIClient.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 3/20/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIClient {
    
    
    static func createUser(firstName: String, lastName: String, email: String, password: String, username: String, completion: ((UserModel) -> Void)?) {
        
        let urlRequestConvertible = Router.createUser(firstName: firstName,
                                                      lastName: lastName,
                                                      email: email,
                                                      password: password,
                                                      username: username)
        
        Alamofire.request(urlRequestConvertible).responseJSON { (response) in
            switch response.result {
            case .success:
    
                 let data = JSON(data: response.data!)
                 guard let user = UserModel(data: data) else {
                    fatalError("User unsuccesfully created.")
                 }
                 
                 completion?(user)
                
            case .failure:
                return
            }
        }
    }
    
    
    static func loginUser(email: String, password: String, completion: ((UserModel) -> Void)?) {
        
        let urlRequestConvertible = Router.loginUser(email: email,
                                                     password: password)
        
        Alamofire.request(urlRequestConvertible).responseJSON { (response) in
            switch response.result {
            case .success:
                
                let data = JSON(data: response.data!)
                guard let user = UserModel(data: data) else {
                    fatalError("User data does not exist")
                }
                
                completion?(user)
                
            case .failure:
                return
            }
        }
    }
    
    
    static func getUsers() {
        
    }
    
}
