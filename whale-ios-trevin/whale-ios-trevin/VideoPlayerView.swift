//
//  VideoPlayerView.swift
//  whale-ios-trevin
//
//  Created by Trevin Wisaksana on 4/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import AVFoundation


class VideoPlayerView: UIView {
    
    var player: AVPlayer?
    var isPlaying = false
    var timer = Timer()
    
    // MARK: Activity Indicator View
    let activityIndicatorView: UIActivityIndicatorView = {
        
        // Creating the activity indicator with the assigned style
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        // Autolayout
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        // Begin animating
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    // MARK: Pause Button
    lazy var pauseOrPlayButton: UIButton = {
        
        // Creating button
        let button = UIButton(type: .system)
        
        let pauseIcon = UIImage(named: "pauseOrPlayButton")
        button.setImage(pauseIcon, for: .normal)
        button.frame.size = CGSize(width: 10, height: 10)
        
        // Autolayout
        button.translatesAutoresizingMaskIntoConstraints = false
        // Changing color
        button.tintColor = .white
        // Hides it until the video is rendered
        button.isHidden = true
        // Set the alpha
        button.imageView?.alpha = 1
        
        button.addTarget(self, action: #selector(pauseAndPlayHandler), for: .touchUpInside)
        
        return button
    }()
    
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
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let videoTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        // slider.minimumTrackTintColor = .blue

        let thumbImage = UIImage(named: "ThumbImage")
        slider.setThumbImage(thumbImage, for: .normal)
        // slider.minimumTrackTintColor = .blue
        slider.maximumTrackTintColor = .white
        
        slider.addTarget(self, action: #selector(sliderChangeHandler), for: .valueChanged)
        
        return slider
    }()
    
    
    func sliderChangeHandler() {
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Int64(Float64(videoSlider.value) * totalSeconds)
            
            let seekTime = CMTime(value: value, timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completed) in
                      
            })
        }
        
    }
    
    
    init(frame: CGRect, url: URL) {
        super.init(frame: frame)
        
        setupVideoPlayer(videoURL: url)
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        // Adding activityIndicatorView
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        // Can add button to subview
        controlsContainerView.addSubview(pauseOrPlayButton)
        pauseOrPlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pauseOrPlayButton.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                  constant: -12).isActive = true
        pauseOrPlayButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        pauseOrPlayButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        
        // Video Length Label
        // controlsContainerView.addSubview(videoLengthLabel)
        /*
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                 constant: -75).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        */
        
        // Adding slider
        // controlsContainerView.addSubview(videoSlider)
        /*
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor, constant: -8).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor,
                                            constant: -75).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        */
        
        // Adding close button
        // controlsContainerView.addSubview(closeButton)
        closeButton.leftAnchor.constraint(equalTo: leftAnchor,
                                          constant: 20).isActive = true
        closeButton.topAnchor.constraint(equalTo: topAnchor,
                                         constant: 20).isActive = true
        
        // Sets the default background to black
        backgroundColor = .black
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // Whent the player is ready
        if keyPath == "currentItem.loadedTimeRanges" {
            // Automatically hides itself
            activityIndicatorView.stopAnimating()
            // Removing the opaque color
            controlsContainerView.backgroundColor = .clear
            // Unhide the pause button
            pauseOrPlayButton.isHidden = false
            
            // Set the state to the opposite
            isPlaying = true
            
            // Getting the duration of the player
            if let duration = player?.currentItem?.duration {
                // Get the second
                let secondsCMTime = CMTimeGetSeconds(duration)
                // Get the remainder of the second
                let seconds = Int(secondsCMTime) % 60
                // Get the minutes
                let minutes = String(format: "%02d", Int(secondsCMTime) / 60)
                // Setting the video length label
                videoLengthLabel.text = "\(minutes):\(seconds)"
            }

        }
        
    }
    
    
    /// Method to setup a video player
    fileprivate func setupVideoPlayer(videoURL: URL) {
        
        player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        // Scale to fill
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        player?.play()
        
        // Observer for finding when the video is ready
        player?.addObserver(self,
                            forKeyPath: "currentItem.loadedTimeRanges",
                            options: .new,
                            context: nil)
        
    }
    
    
    // Handles the play logic
    @objc fileprivate func pauseAndPlayHandler() {
        
        if isPlaying {
            // Pauses the video player
            player?.pause()
            // Changing the button
            let playButton = UIImage(named: "PlayButton")
            pauseOrPlayButton.setImage(playButton, for: .normal)
        } else {
            // Plays the video player
            player?.play()
            // Changing the button
            let pauseButton = UIImage(named: "PauseButton")
            pauseOrPlayButton.setImage(pauseButton, for: .normal)
        }
        // Reverses the isPlaying bool
        isPlaying = !isPlaying
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
            self.player?.pause()
            
        }
        
    }
    
}
