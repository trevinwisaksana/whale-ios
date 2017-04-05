//
//  AnswerCell+Configuration.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 4/1/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

extension AnswerCell {
    
    /* 
     Method to configure the cells without the view 
     controller caring about the UIElements within 
     the cell.
    */
    func configure(with data: Answer) {
        self.questionLabel.text = data.content
        self.inquiererFullNameLabel.text = "\(data.inquirerFirstName) \(data.inquirerLastName)"
        
    }
    
}
