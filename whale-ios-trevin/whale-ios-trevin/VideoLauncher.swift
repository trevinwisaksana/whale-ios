//
//  VideoLauncher.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 4/7/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoLauncher: NSObject {
    
    // MARK: - Video Player Animation
    func showVideo(with url: URL) {
        
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return
        }

        // MARK: Video Launcher View
        let view = VideoLauncherView(frame: keyWindow.frame)
        
        let xValue = keyWindow.frame.width - 10
        let yValue = keyWindow.frame.height - 10
        view.frame = CGRect(x: xValue,
                            y: yValue,
                            width: 10,
                            height: 10)
        
        // MARK: Video Player
        let videoPlayerFrame = CGRect(x: 0,
                                      y: 0,
                                      width: keyWindow.frame.width,
                                      height: keyWindow.frame.height * 0.85)
        
        let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame,
                                              url: url)
        
        view.addSubview(videoPlayerView)
        keyWindow.addSubview(view)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut, animations: {
            
            // Assigning the view frame to the size of the window
            view.frame = keyWindow.frame
            
        }) { (completed) in
            
            // Setting the status bar to be hiddne
            UIApplication.shared.isStatusBarHidden = true
            
        }
        
    }
    
}
