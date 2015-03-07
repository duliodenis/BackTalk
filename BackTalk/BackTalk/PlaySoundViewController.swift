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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if var filePath = NSBundle.mainBundle().pathForResource("HAL9000", ofType: "mp3") {
            let fileUrl = NSURL.fileURLWithPath(filePath)
            audioPlayer = AVAudioPlayer(contentsOfURL: fileUrl, error: nil)
            audioPlayer.enableRate = true
        } else {
            println("filepath not found")
        }
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
