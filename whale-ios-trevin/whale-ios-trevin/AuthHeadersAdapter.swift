//
//  AuthHeadersAdapter.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 4/3/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation
import Alamofire


class AuthHeadersAdapter: RequestAdapter {
    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
