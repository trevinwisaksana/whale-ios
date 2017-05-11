//
//  ActivityViewController.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 3/20/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var questionsCollectionView: UICollectionView!
    
    // Contains all the question models
    var listOfQuestions: [Question] = []
    var indexOfCellTapped = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient.instance.getQuestions { [unowned self] (questions) in
            // Assigning the answers to the array
            self.listOfQuestions = questions
            // Refresh the collection view
            self.questionsCollectionView.reloadData()
        }
        
    }
    
}
