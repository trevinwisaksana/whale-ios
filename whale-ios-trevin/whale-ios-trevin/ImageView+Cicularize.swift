//
//  ImageView+Cicularize.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 4/7/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// Creates a circular border on the ImageView
    func circularize() {
        // Editting the layer
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
}
