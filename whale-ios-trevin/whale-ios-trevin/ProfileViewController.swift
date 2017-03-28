//
//  ProfileViewController.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 3/20/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    
    // User information
    var userInformation: UserModel? {
        didSet {
            
            guard let userInformation = userInformation else {
                return
            }
            
            guard let firstNameLabel = firstNameLabel else {
                return
            }
            
            guard let lastNameLabel = lastNameLabel else {
                return
            }
            
            firstNameLabel.text = userInformation.firstName
            lastNameLabel.text = userInformation.lastName
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
}
