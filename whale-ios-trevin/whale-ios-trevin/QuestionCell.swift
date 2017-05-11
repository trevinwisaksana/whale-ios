//
//  ActivityCell.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 3/20/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SDWebImage


class QuestionCell: UICollectionViewCell {
    
    @IBOutlet weak var inquiererProfilePicture: UIImageView!
    
    @IBOutlet weak var inquiererFullNameLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    public func configure(with question: Question) {
        
        inquiererFullNameLabel.text = "\(question.inquirerFirstName) \(question.inquirerLastName)"
        questionLabel.text = question.question
        inquiererProfilePicture.sd_setImage(
            with: question.profileImageURL
        )
        
        // Circularizing inquirer profile picture
        inquiererProfilePicture.circularize()
        
    }
    
}
