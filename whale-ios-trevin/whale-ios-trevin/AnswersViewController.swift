//
//  AnswerViewController.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 3/20/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class AnswersViewController: UIViewController {
    
    @IBOutlet weak var answersCollectionView: UICollectionView!
    
    // Contains all the answer models
    var listOfAnswers: [Answer] = []
    var indexOfCellTapped = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        APIClient.instance.getAnswers { [unowned self] (answers) in
            // Assigning the answers to the array
            self.listOfAnswers = answers
            // Refresh the collection view
            self.answersCollectionView.reloadData()
        }
    
    }
    
}
