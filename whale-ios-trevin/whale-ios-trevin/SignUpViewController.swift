//
//  SignUpViewController.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 3/20/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
 
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        
        // All these fields must be required to sign up
        guard let email = emailTextField.text,
              let firstName = firstNameTextField.text,
              let lastName = lastNameTextField.text,
              let password = passwordTextField.text,
              let username = usernameTextField.text else {
            // TODO: Show an alert
            return
        }
       
        // Sends request to create user
        APIClient.createUser(firstName: firstName,
                             lastName: lastName,
                             email: email,
                             password: password,
                             username: username) { (json) in
                                
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarViewController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController = tabBarViewController
                                
        }
        
    }
    
}
