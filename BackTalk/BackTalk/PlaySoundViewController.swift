//
//  PlaySoundViewController.swift
//  BackTalk
//
//  Created by Dulio Denis on 3/7/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
        audioPlayer.enableRate = true
    }

    @IBAction func slowSound(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.25
        audioPlayer.play()
    }
    
    @IBAction func fastSound(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.75
        audioPlayer.play()
    }
    
    @IBAction func stopSound(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
    }
}
