//
//  PageData.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 3/31/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation

struct PageData {
    
    // For pagination
    let pageSize: Int
    var pageNumber: Int
    
    init(pageNumber: Int, pageSize: Int) {
        self.pageSize = pageSize
        self.pageNumber = pageNumber
    }
    
}

