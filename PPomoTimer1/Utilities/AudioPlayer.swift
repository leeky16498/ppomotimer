//
//  AudioPlayer.swift
//  PPomoTimer1
//
//  Created by Kyungyun Lee on 28/02/2022.
//


import Foundation
import AVFoundation

var audioPlayer : AVAudioPlayer?
var audioPlayer1 : AVAudioPlayer?

func playSound(sound : String, type : String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Could not play the sound file")
        }
    }
}

func playBackgroundSound(sound : String, type : String) {
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer1 = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer1?.numberOfLoops = -1
            audioPlayer1?.play()
        } catch {
            print("There is error")
        }
    }
}
