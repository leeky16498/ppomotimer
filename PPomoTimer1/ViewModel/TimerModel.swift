//
//  TimerModel.swift
//  PPomoTimer1
//
//  Created by Kyungyun Lee on 27/02/2022.
//

import Foundation

class TimerModel : ObservableObject {
    
    @Published var timerStyle : TimerStyle? = nil
    @Published var timerMode : TimerMode = .normal
    @Published var progress : Double = 0.0
    @Published var isStarted : Bool = false
    @Published var isPaused : Bool = false
    @Published var isAuto : Bool = false
    @Published var isSkipMode : Bool = false
    @Published var elapsedFocusTime : Int = 0
    @Published var totalFocusTime : Int = 0
    @Published var elapsedShortTime : Int = 0
    @Published var totalShortTime : Int = 0
    @Published var elapsedLongBreakTime : Int = 0
    @Published var totalLongBreakTime : Int = 0
    @Published var isOnSound : Bool = false
    @Published var isOnBackgroundSound : Bool = false
    @Published var backgroundNoise : BackgroundNoise? = nil
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func trackFocusProgress() {
        
        if let timerStyle = timerStyle {
            switch timerStyle {
            case .focus:
                elapsedFocusTime -= 1
                progress = Double(totalFocusTime - elapsedFocusTime) / Double(totalFocusTime)
                
            case .short:
                elapsedShortTime -= 1
                progress = Double(totalShortTime - elapsedShortTime) / Double(totalShortTime)
                
            case .long:
                elapsedLongBreakTime -= 1
                progress = Double(totalLongBreakTime - elapsedLongBreakTime) / Double(totalLongBreakTime)
            }
        }
    }
    
    func backBroundMusic() {
        
        guard let backgroundNoise = backgroundNoise else {
            return
        }
        
        switch backgroundNoise {
        case .forest:
            playBackgroundSound(sound: "Forest", type: "wav")
        case .river:
            playBackgroundSound(sound: "RiverStream", type: "mp3")
        case .rain:
            playBackgroundSound(sound: "Rain", type: "wav")
        case .wave:
            playBackgroundSound(sound: "HarborWave", type: "wav")
        case .turnOff:
            audioPlayer1?.stop()
        }
    }
    
    
}

enum TimerMode {
    case normal, start, pause, stop
}

enum TimerStyle {
    case focus, short, long
}

enum BackgroundNoise {
    case forest, river, rain, wave, turnOff
}
