//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Alex da Silva Ribeiro on 29/05/17.
//  Copyright © 2017 AlexSilR. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // MARK: Enums
    enum ButtonType: Int { case slow = 0, fast, chipmunk, vader, echo, reverb }
    
    // MARK: View Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureUI(.notPlaying)
    }
    
    // MARK: IBActions
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch ButtonType(rawValue: sender.tag)! {
        case .slow:
            self.playSound(rate: 0.5)
        case .fast:
            self.playSound(rate: 1.5)
        case .chipmunk:
            self.playSound(pitch: 1000)
        case .vader:
            self.playSound(pitch: -1000)
        case .echo:
            self.playSound(echo: true)
        case .reverb:
            self.playSound(reverb: true)
        }
        
        self.configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        self.stopAudio()
    }
}
