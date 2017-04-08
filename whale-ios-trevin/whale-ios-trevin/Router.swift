//
//  Router.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 3/20/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import Alamofire

enum Router: URLRequestConvertible {
    
    // Base URL of API
    static let baseURL: String = "https://whale2-elixir.herokuapp.com/api/v1"
    
    // Different cases for each router
    case getUsers
    
    case getAnswers(perPage: Int,
                    intpage: Int)
    
    case getAnswerComments(String)
    case getAnswerLikes(String)
    case getMyQuestions

    case createUser(firstName: String,
                    lastName: String,
                    email: String,
                    password: String,
                    username: String)
    
    case postAnswer(String)
    case postQuestion
    
    case loginUser(email: String,
                   password: String)
    
    var method: HTTPMethod {
        switch self {
        case .getUsers,
             .getAnswers,
             .getAnswerLikes,
             .getAnswerComments,
             .getMyQuestions:
            return .get
            
        case .createUser,
             .loginUser,
             .postAnswer,
             .postQuestion:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .createUser:
            return "/users"
        case .getAnswers:
            return "/answers"
        case .loginUser:
            return "/sessions"
        case .getAnswerComments(let answer_id):
            return "/answers/\(answer_id)/comments"
        case .getAnswerLikes(let question_id):
            return "/answers/\(question_id)/likes"
        case .postAnswer(let question_id):
            return "questions/\(question_id)/answers"
        case .getMyQuestions:
            return "/questions"
        case .postQuestion:
            return "/questions"
        }
    }
    
    // Returns a URLRequest
    func asURLRequest() throws -> URLRequest {
        
        // Set the URL-parameters
        let parameters: [String: Any] = {
            switch self {
            case .getUsers,
                 .getAnswerComments,
                 .getAnswerLikes,
                 .getMyQuestions:
                return [:]
                
            case .getAnswers(let per_page, let intpage):
                return ["per_page" : per_page,
                        "page" : intpage]
                
            case .createUser(let first_name, let last_name, let email, let password, let username):
                return ["first_name": first_name,
                        "last_name" : last_name,
                        "email" : email,
                        "password" : password,
                        "username" : username]
                
            case .postAnswer:
                return [:]
                
            case .postQuestion:
                return [:]
                
            case .loginUser(let email, let password):
                return ["email" : email,
                        "password" : password]
                
            }
        }()
        
        // Sets the header for the request
        // TODO: Exhaust all the cases
        let headers: [String : String] = {
            switch self {
            case .getAnswers:
                return [:]
            default:
                return [:]
            }
        }()
        
        // Sets as a URL
        let url = try Router.baseURL.asURL()
        
        // Creating a request
        var request = URLRequest(url: url.appendingPathComponent(path))
        // Mutates the request to change the HTTPRequest method
        request.httpMethod = method.rawValue
        
        // Adds the headers to the request
        headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Sends the request
        switch self {
        case .createUser:
            return try JSONEncoding.default.encode(request, with: parameters)
        default:
            return try URLEncoding.default.encode(request, with: parameters)
        }

    }
    
}
