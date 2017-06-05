//
//  RecordViewController.swift
//  Pitch Perfect
//
//  Created by Alex da Silva Ribeiro on 06/02/17.
//  Copyright © 2017 AlexSilR. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {
    // MARK: Properties
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK: Enums
    enum RecordingStatus: Int { case startRecording = 0, stopRecording }
    
    // MARK: Constants
    let stopRecordingSegueIdentifier = "stopRecording"
    let recordedFileName = "recordedVoice.wav"
    
    // MARK: View Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setRecordingStatus(.stopRecording)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.stopRecordingSegueIdentifier {
            let playSoundsViewController = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsViewController.recordedAudioURL = recordedAudioURL
        }
    }

    // MARK: IBActions
    @IBAction func recordAudio() {
        self.setRecordingStatus(.startRecording)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let pathArray = [dirPath, self.recordedFileName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! self.audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        self.audioRecorder.delegate = self
        self.audioRecorder.isMeteringEnabled = true
        self.audioRecorder.prepareToRecord()
        self.audioRecorder.record()
    }
    
    @IBAction func stopRecording() {
        self.setRecordingStatus(.stopRecording)
        
        self.audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: Private Help Functions
    private func setRecordingStatus(_ recordingStatus: RecordingStatus) {
        switch recordingStatus {
        case .startRecording:
            self.recordButton.isEnabled = false
            self.stopButton.isEnabled = true
            self.statusLabel.text = "Recording in Progress"
        case .stopRecording:
            self.recordButton.isEnabled = true
            self.stopButton.isEnabled = false
            self.statusLabel.text = "Tap to Record"
        }
    }
}
