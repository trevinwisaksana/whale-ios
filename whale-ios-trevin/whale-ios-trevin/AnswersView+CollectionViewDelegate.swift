//
//  AnswersView+CollectionViewDelegate.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 4/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

extension AnswersViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Getting the index value of the answer
        indexOfCellTapped = indexPath.row
        let videoLink = listOfAnswers[indexOfCellTapped].videoURL

        // Initiate Video Launcher
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideo(with: videoLink)
        
    }
    
}
