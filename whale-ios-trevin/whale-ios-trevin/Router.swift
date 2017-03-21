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
    static let baseURL: String = "https://whale2-elixir.herokuapp.com"
    
    // Different cases for each router
    case user
    case session
    case question
    case answerQuestion
    case answerComment
    case answerLike
    
    var method: HTTPMethod {
        switch self {
        case .user, .question, .answerQuestion, .answerComment, .answerLike:
            return .post
        case .session:
            return .get
        }
    }
    
    // Returns a URLRequest
    func asURLRequest() throws -> URLRequest {
        // Sets as a URL
        let url = try Router.baseURL.asURL()
        // Sends the request
        var request = URLRequest(url: url)
        // Assigns the HTTP method depending on the case
        request.httpMethod = method.rawValue
        
        return request
    }
    
}
