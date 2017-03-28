//
//  GistHeadersAdapter.swift
//  GitProject
//
//  Created by Trevin Wisaksana on 3/6/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import Alamofire

class UserHeadersAdapter: RequestAdapter {
    
    let username: String
    let password: String
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        
        // Has to be assigned to a variable because urlRequest cannot be mutated
        var request = urlRequest
        
        // Alamofire returns a tuple of key and value
        if let authorizationHeader = Request.authorizationHeader(user: username, password: password) {
            request.setValue(authorizationHeader.value, forHTTPHeaderField: authorizationHeader.key)
        }
        
        return request
        
    }
    
    init?(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
}
