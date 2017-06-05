//
//  RecordViewController+.swift
//  Pitch Perfect
//
//  Created by Alex da Silva Ribeiro on 05/06/17.
//  Copyright © 2017 AlexSilR. All rights reserved.
//

import AVFoundation

// MARK: - AVAudioRecorderDelegate
extension RecordViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: self.stopRecordingSegueIdentifier, sender: self.audioRecorder.url)
        }
    }
}
