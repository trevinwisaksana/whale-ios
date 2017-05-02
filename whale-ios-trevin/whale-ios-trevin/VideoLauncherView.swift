//
//  VideoLauncherView.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 4/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class VideoLauncherView: UIView {
    
    let closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "CloseButton")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(closeButtonHandler),
                         for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setting background color to white
        backgroundColor = .white
        
        // Adding close button
        self.addSubview(closeButton)
        closeButton.leftAnchor.constraint(equalTo: leftAnchor,
                                          constant: 20).isActive = true
        closeButton.topAnchor.constraint(equalTo: topAnchor,
                                         constant: 20).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc fileprivate func closeButtonHandler() {
        
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        
        let xValue = keyWindow.frame.width - 10
        let yValue = keyWindow.frame.height - 10
        
        UIView.animate(withDuration: 0.3,
                       delay: 0, usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut, animations: {
                        
                        // Assigning the view frame to the size of the window
                        self.frame = CGRect(x: xValue,
                                            y: yValue,
                                            width: 10,
                                            height: 10)
                        
        }) { (_) in
            
            // Setting the status bar to be hiddne
            UIApplication.shared.isStatusBarHidden = false
            // Removing the VideoPlayerView
            self.isHidden = true
            // Pause the video
            // self.player?.pause()
            
        }
        
    }
    

}
