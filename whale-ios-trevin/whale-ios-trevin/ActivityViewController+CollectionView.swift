//
//  ActivityViewController+CollectionView.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 4/14/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

extension ActivityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfQuestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let nibFile = UINib(
            nibName: "QuestionCell",
            bundle: nil
        )
        collectionView.register(
            nibFile,
            forCellWithReuseIdentifier: "QuestionCell"
        )
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "QuestionCell",
            for: indexPath
            ) as! QuestionCell
        
        let question = listOfQuestions[indexPath.row]
        
        cell.configure(with: question)
        
        return cell
        
    }
    
}
