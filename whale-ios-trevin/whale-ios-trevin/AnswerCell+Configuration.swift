//
//  AnswerCell+Configuration.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 4/1/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SDWebImage

extension AnswerCell {
    
    /* 
     Method to configure the cells without the view 
     controller caring about the UIElements within 
     the cell.
    */
    func configure(with data: Answer) {
        
        self.questionLabel.text = data.question
        self.inquiererFullNameLabel.text = "\(data.inquirerFirstName) \(data.inquirerLastName)"
        
        self.inquiererProfilePicture.sd_setImage(with: data.profileImageURL)
        self.videoImageView.sd_setImage(with: data.thumbnailURL)
        
        // Circularizing inquirer profile picture
        self.inquiererProfilePicture.circularize()
        
    }
    
}
