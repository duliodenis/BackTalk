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
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
        audioPlayer?.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
        
        // To boost low on-device sound
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: nil)
    }

    @IBAction func slowSound(sender: UIButton) {
        audioPlayer?.stop()
        audioPlayer?.rate = 0.25
        audioPlayer?.play()
    }
    
    @IBAction func fastSound(sender: UIButton) {
        audioPlayer?.stop()
        audioPlayer?.rate = 1.75
        audioPlayer?.play()
    }
    
    @IBAction func highPitchSound(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer?.stop()
        audioEngine?.stop()
        audioEngine?.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine?.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine?.attachNode(changePitchEffect)
        
        audioEngine?.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine?.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine?.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func vaderSound(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopSound(sender: UIButton) {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0.0
    }
    
}
