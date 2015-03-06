//
//  ViewController.swift
//  BackTalk
//
//  Created by Dulio Denis on 3/6/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.text = ""
        stopButton.hidden = true
        recordButton.enabled = true
    }
}

