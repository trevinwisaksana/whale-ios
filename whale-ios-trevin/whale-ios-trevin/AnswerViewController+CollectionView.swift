//
//  AnswerViewController+CollectionView.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 4/1/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

extension AnswerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfAnswers.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let nibFile = UINib(nibName: "AnswerCell", bundle: nil)
        collectionView.register(nibFile, forCellWithReuseIdentifier: "AnswerCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCell", for: indexPath) as! AnswerCell
        
        let answer = listOfAnswers[indexPath.row]
        
        cell.configure(with: answer)
        
        return cell
        
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // Variables of the scrollView offset and height
        let contentOffsetY = scrollView.contentOffset.y
        let scrollViewHeight = scrollView.frame.size.height
        let contentSizeHeight = scrollView.contentSize.height
    
        // When reaching the bottom, refresh
        if scrollView == answersCollectionView {
            // Check if the user has reached the bottom of the collection view
            if (contentOffsetY + scrollViewHeight) >= contentSizeHeight
            {
                // Prevents the new data from being called when user refreshes multiple times
                if APIClient.isLoadingNewData == false {
                    // Loading new data
                    APIClient.isLoadingNewData = true
                    // Getting the new data
                    APIClient.instance.getAnswers(pageSize: APIClient.pageSize, pageNumber: APIClient.pageNumber) { [weak self] (answers) in
                        // Appending the answers to the array
                        self?.listOfAnswers.append(contentsOf: answers)
                        // Refresh the collection view
                        self?.answersCollectionView.reloadData()
                        // Changing the page number
                        APIClient.pageNumber += 1
                        // Allowing the refresh to happen multiple times
                        APIClient.isLoadingNewData = false
                    }
                }
            }
        }
    }
    
}
