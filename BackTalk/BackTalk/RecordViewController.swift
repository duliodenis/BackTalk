//
//  RecordViewController.swift
//  BackTalk
//
//  Created by Dulio Denis on 3/6/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder:AVAudioRecorder?
    var recordedAudio:RecordedAudio?

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingLabel.text = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingLabel.text = "recording..."
        stopButton.hidden = false
        recordButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as String

        let recordingName = "Recording.m4a"
        let pathArray = [dirPath, recordingName]
        let filePathURL = NSURL.fileURLWithPathComponents(pathArray)
        println(filePathURL)
        
        // Setup audio session
        var session = AVAudioSession.sharedInstance()
        if (session.inputAvailable) {
            session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
            session.setActive(true, error: nil)
        }
        
        var error: NSError?
        
        // initialize and prepare the recorder
        audioRecorder = AVAudioRecorder(URL: filePathURL, settings: audioRecordingSettings(), error: &error)
        
        if let recorder = audioRecorder {
            recorder.delegate = self
            recorder.meteringEnabled = true
            recorder.prepareToRecord()
            recorder.record()
            println("Successfully started to record.")
        } else {
            println("Failed to create an instance of the audio recorder")
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag) {
            recordedAudio = RecordedAudio()
            recordedAudio?.filePathURL = recorder.url
            recordedAudio?.title = recorder.url.lastPathComponent
            
            self.performSegueWithIdentifier("StopRecording", sender: recordedAudio)
        } else {
            println("Recording was not successful")
            recordingLabel.text = ""
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "StopRecording") {
            let playSoundVC:PlaySoundViewController = segue.destinationViewController as PlaySoundViewController
            playSoundVC.receivedAudio = sender as RecordedAudio
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.text = ""
        stopButton.hidden = true
        recordButton.enabled = true
        audioRecorder?.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    func audioRecordingSettings() -> [NSObject : AnyObject]{
        /* Let's prepare the audio recorder options in the dictionary.
        Later we will use this dictionary to instantiate an audio
        recorder of type AVAudioRecorder */
        return [
            AVFormatIDKey : kAudioFormatMPEG4AAC as NSNumber,
            AVSampleRateKey : 16000.0 as NSNumber,
            AVNumberOfChannelsKey : 1 as NSNumber,
            AVEncoderAudioQualityKey : AVAudioQuality.Low.rawValue as NSNumber
        ]
        
    }
}

