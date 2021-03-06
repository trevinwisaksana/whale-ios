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
import KeychainSwift

class APIClient {
    
    static let instance = APIClient()
    
    fileprivate var pageData = PageData(pageNumber: 0, pageSize: 5)
    
    fileprivate let sessionManager = Alamofire.SessionManager.default
    fileprivate let keychain = KeychainSwift()
    
    init() {
        
        guard let token = keychain.get("token") else {
            return
        }
        
        sessionManager.adapter = AuthHeadersAdapter(accessToken: token)
    }
    
    // MARK: - Create User
    static func createUser(firstName: String, lastName: String, email: String, password: String, username: String, completion: ((User) -> Void)?) {
        
        let urlRequestConvertible = Router.createUser(firstName: firstName,
                                                      lastName: lastName,
                                                      email: email,
                                                      password: password,
                                                      username: username)
        
        Alamofire.request(urlRequestConvertible).responseJSON { (response) in
            switch response.result {
            case .success:
                
                
                let data = JSON(data: response.data!)
                guard let user = User(data: data) else {
                    fatalError("User unsuccesfully created.")
                }
                
                completion?(user)
                
                
            case .failure:
                // TODO: Show user alert
                return
            }
        }
    }
    
    // MARK: - Login User
    static func loginUser(email: String, password: String, completion: ((User) -> Void)?) {
        
        let urlRequestConvertible = Router.loginUser(email: email,
                                                     password: password)
        
        Alamofire.request(urlRequestConvertible).responseJSON { (response) in
            switch response.result {
            case .success:
                
                guard let token = response.response?.allHeaderFields["Authorization"] as? String else {
                    fatalError("Failed to login")
                }
                
                let data = JSON(data: response.data!)
                guard let user = User(data: data) else {
                    fatalError("User data does not exist")
                }
                
                let keychain = KeychainSwift()
                keychain.set(token, forKey: "token")
                
                completion?(user)
                
            case .failure:
                // TODO: Show user alert
                return
            }
        }
    }
    
    // MARK: - Get Answers
    func getAnswers(completion: (([Answer]) -> Void)?) {
        
        let urlRequestConvertible = Router.getAnswers(perPage: pageData.pageSize, page: pageData.pageNumber)
        
        sessionManager.request(urlRequestConvertible).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
        
                // Placing the guard as the json cannot be an optional to be flat mapped
                let json = JSON(value)
                
                guard let data = json["data"].array else {
                    fatalError("Data could not be found")
                }
                
                // Flat mapping the json to initialize the answer
                /*
                 Similar to json.flatMap { data in Answer(json: data) }
                */
                let answers: [Answer] = data.flatMap(Answer.init)
                
                // Changing the page number
                self.pageData.pageNumber += 1
            
                // Returning te array of answers
                completion?(answers)
                
            case .failure(let error):
                // TODO: Show user alert
                print("Error: ", error)
            }
        }
        
    }
    
    
    func getQuestions(completion: (([Question]) -> Void)?) {
        
        let urlRequestConvertible = Router.getMyQuestions(perPage: pageData.pageSize, page: pageData.pageNumber)
        
        sessionManager.request(urlRequestConvertible).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                
                // Placing the guard as the json cannot be an optional to be flat mapped
                let json = JSON(value)
                
                guard let data = json["data"].array else {
                    fatalError("Data could not be found")
                }
                
                // Flat mapping the json to initialize the answer
                /*
                 Similar to json.flatMap { data in Question(json: data) }
                 */
                let questions: [Question] = data.flatMap(Question.init)
                
                // Changing the page number
                self.pageData.pageNumber += 1
                
                // Returning te array of answers
                completion?(questions)
                
            case .failure(let error):
                // TODO: Show user alert
                print("Error: ", error)
                
            }
        }
        
    }

    
    // TODO: Create a generic request
    static func getData<T>(request: Router, completion: @escaping ([T]) -> Void?) {
        
        // var urlRequestConvertible: Router
        
        /*
        switch request {
        case .getAnswers:
            return Router.getAnswers
        case .getMyQuestions:
            break
        default:
            return .getAnswers
        }
        */
        
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
            case .success:
                
                /*
                let data = JSON(data: response.data!)
                let answers: [T] = [Answer.init(data: data)!] as! [T]
                completion(answers)
                */
                
                break
            case .failure:
                // TODO: Show user alert
                return
            }
            
       }
    }
    
}
