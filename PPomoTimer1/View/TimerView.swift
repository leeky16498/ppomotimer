//
//  ContentView.swift
//  PPomoTimer1
//
//  Created by Kyungyun Lee on 27/02/2022.
//

import SwiftUI


struct TimerView: View {
    
    @EnvironmentObject var tm : TimerModel
    
    @State var timerStyle : TimerStyle?
    @State var focusColors : [Color] = [Color.green, Color.mint, Color.green, Color.mint, Color.green]
    @State var breakColors : [Color] = [Color.blue, Color.mint, Color.blue, Color.mint, Color.blue]
    @State var longBreakColors : [Color] = [Color.gray, Color.white, Color.gray, Color.white, Color.gray]

    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea(.all)
                if tm.timerStyle == nil {
                    NoTimerView()
                } else {
                    VStack(alignment : .center, spacing: 40){
                        Spacer()
                        if let timerStyle = tm.timerStyle {
                            switch timerStyle {
                                case .focus:
                                    Text("Focus Mode 🔥")
                                        .font(.system(size: 30, weight: .bold, design: .rounded))
                                        .fontWeight(.bold)
                       
                                case .short:
                                    Text("Break Mode ☕️")
                                        .font(.system(size: 30, weight: .bold, design: .rounded))
                                        .fontWeight(.bold)
                             
                                case .long:
                                    Text("Long Break Mode 🌕")
                                        .font(.system(size: 30, weight: .bold, design: .rounded))
                                        .fontWeight(.bold)//
                    
                                                }
                                            }
                    if let timerStyle = tm.timerStyle {
                            switch timerStyle {
                            case .focus:
                                ProgressView(progress: tm.progress, gradientColors: focusColors, time: formatTime())
                                    .padding()
                                    .onReceive(tm.timer) { _ in
                                        if tm.timerMode == .start {
                                            if tm.elapsedFocusTime != 0 {
                                                tm.trackFocusProgress()
                                            } else {
                                                if tm.isAuto {
                                                    tm.timerStyle = .short
                                                    tm.progress = 0
                                                    tm.elapsedShortTime = tm.totalShortTime
                                                    
                                                    if tm.isOnSound {
                                                        playSound(sound: "chimeup", type: "mp3")
                                                    }
                                                } else {
                                                    tm.timerMode = .normal
                                                    tm.timerStyle = .short
                                                    tm.isStarted = false
                                                    tm.progress = 0
                                                    tm.elapsedShortTime = tm.totalShortTime
                                                    
                                                    if tm.isOnSound {
                                                        playSound(sound: "chimeup", type: "mp3")
                                                    }
                                                }
                                            }
                                        }
                                    }
                            case .short:
                                ProgressView(progress: tm.progress, gradientColors: breakColors, time: formatTime())
                                    .padding()
                                    .onReceive(tm.timer) { _ in
                                        if tm.timerMode == .start {
                                            if tm.elapsedShortTime != 0 {
                                                tm.trackFocusProgress()
                                            } else {
                                                if tm.isAuto {
                                                    if tm.isSkipMode {
                                                        tm.timerStyle = .focus
                                                        tm.progress = 0
                                                        tm.elapsedFocusTime = tm.totalFocusTime
                                                        
                                                        if tm.isOnSound {
                                                            playSound(sound: "chimeup", type: "mp3")
                                                        }
                                                        
                                                    } else {
                                                        tm.timerStyle = .long
                                                        tm.progress = 0
                                                        tm.elapsedLongBreakTime = tm.totalLongBreakTime
                                                        if tm.isOnSound {
                                                            playSound(sound: "chimeup", type: "mp3")
                                                        }
                                                    }
                                                } else {
                                                    if tm.isSkipMode {
                                                        tm.timerStyle = .focus
                                                        tm.timerMode = .normal
                                                        tm.timerStyle = .focus
                                                        tm.isStarted = false
                                                        tm.progress = 0
                                                        tm.elapsedFocusTime = tm.totalFocusTime
                                                        
                                                        if tm.isOnSound {
                                                            playSound(sound: "chimeup", type: "mp3")
                                                        }
                                                    } else {
                                                        tm.timerMode = .normal
                                                        tm.timerStyle = .long
                                                        tm.isStarted = false
                                                        tm.progress = 0
                                                        tm.elapsedLongBreakTime = tm.totalLongBreakTime
                                                        
                                                        if tm.isOnSound {
                                                            playSound(sound: "chimeup", type: "mp3")
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                            case .long:
                                ProgressView(progress: tm.progress, gradientColors: longBreakColors, time: formatTime())
                                    .padding()
                                    .onReceive(tm.timer) { _ in
                                        if tm.timerMode == .start {
                                            if tm.elapsedLongBreakTime != 0 {
                                                tm.trackFocusProgress()
                                            } else {
                                                if tm.isAuto {
                                                    tm.timerStyle = .focus
                                                    tm.progress = 0
                                                    tm.elapsedFocusTime = tm.totalFocusTime
                                                    
                                                    if tm.isOnSound {
                                                        playSound(sound: "chimeup", type: "mp3")
                                                    }
                                                } else {
                                                    tm.timerMode = .normal
                                                    tm.timerStyle = .focus
                                                    tm.isStarted = false
                                                    tm.progress = 0
                                                    tm.elapsedFocusTime = tm.totalFocusTime
                                                    
                                                    if tm.isOnSound {
                                                        playSound(sound: "chimeup", type: "mp3")
                                                    }
                                                }
                                            }
                                        }
                                    }
                        }
                    }
                    
                    if let timerStyle = tm.timerStyle {
                        switch timerStyle {
                        case .focus:
                            Text("Let's concentrate on your task!")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        case .short:
                            Text("Well done, Have a short break!")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        case .long:
                            Text("It's so long journey, take care yourself.")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    HStack {
                    
                    Button(action: {
                        switch tm.timerMode {
                        case .normal:
                            tm.timerMode = .start
                            tm.isStarted.toggle()
                            tm.backBroundMusic()
                        case .start:
                            
                            tm.timerMode = .normal
                            
                            if let timerStyle = tm.timerStyle {
                                switch timerStyle {
                                case .focus:
                                    tm.progress = 0
                                    tm.elapsedFocusTime = tm.totalFocusTime
                                    
                                case .short:
                                    tm.progress = 0
                                    tm.elapsedShortTime = tm.totalShortTime
                                   
                                case .long:
                                    tm.progress = 0
                                    tm.elapsedLongBreakTime = tm.totalLongBreakTime
                                }
                            }
                            tm.isStarted.toggle()
                        case .pause:
                            tm.timerMode = .normal
                            tm.isStarted.toggle()
                        case .stop:
                            tm.timerMode = .normal
                        }
                    }, label: {
                        Image(systemName: tm.isStarted ? "square.fill":"play.fill")
                            .frame(width : 60, height : 60)
                            .background(tm.isStarted ? .red : .green)
                            .foregroundColor(.white)
                            .font(.title)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.5), radius: 1, x: 1, y: 1)
                    })
                    .disabled(tm.timerStyle == nil)
                    .padding()
                        
                    Button(action:  {
                        switch tm.timerMode {
                        case .normal:
                            return
                        case .start:
                            tm.timerMode = .pause
                            tm.isPaused.toggle()
                        case .pause:
                            tm.timerMode = .start
                            tm.isPaused.toggle()
                        case .stop:
                            return
                        }
                    }, label: {
                        Image(systemName: tm.isPaused ? "play.fill" : "pause.fill")
                            .frame(width : 60, height : 60)
                            .background(tm.timerMode == .normal ? .gray : .yellow)
                            .foregroundColor(.white)
                            .font(.title)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.5), radius: 1, x: 1, y: 1)
                    })
                    .disabled(tm.timerStyle == nil)
                    .padding()
                        
                    Button(action:  {
                        if let timerStyle = tm.timerStyle {
                            switch timerStyle {
                            case .focus:
                                tm.timerMode = .normal
                                tm.timerStyle = .short
                                tm.isStarted = false
                                tm.progress = 0
                                tm.elapsedShortTime = tm.totalShortTime
                            case .short:
                                if tm.isSkipMode {
                                    tm.timerMode = .normal
                                    tm.timerStyle = .focus
                                    tm.isStarted = false
                                    tm.progress = 0
                                    tm.elapsedFocusTime = tm.totalFocusTime
                                } else {
                                    tm.timerMode = .normal
                                    tm.timerStyle = .long
                                    tm.isStarted = false
                                    tm.progress = 0
                                    tm.elapsedLongBreakTime = tm.totalLongBreakTime
                                }
                            case .long:
                                tm.timerMode = .normal
                                tm.timerStyle = .focus
                                tm.isStarted = false
                                tm.progress = 0
                                tm.elapsedFocusTime = tm.totalFocusTime
                            }
                        }
                    }, label: {
                        Image(systemName: "forward.end.fill")
                            .frame(width : 60, height : 60)
                            .background(.blue)
                            .foregroundColor(.white)
                            .font(.title)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.5), radius: 1, x: 1, y: 1)
                    })
                    .disabled(tm.timerStyle == nil)
                    .padding()
                        
                    } // hst
                    
                    Spacer()
                }//vst
            }
        }//Zstack
                    .navigationTitle("PPO.MO ⏱")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing:
                       HStack{
                        
                        if tm.isOnBackgroundSound {
                            Menu {
                                Button(action: {
                                    tm.backgroundNoise = .forest
                                }, label: {
                                    Label(tm.backgroundNoise == .forest ? "✅ Forest" : "Forest", systemImage: "leaf")
                                })
                                
                                Button(action: {
                                    tm.backgroundNoise = .river
                                }, label: {
                                    Label(tm.backgroundNoise == .river ? "✅ River" : "River", systemImage: "drop.circle")
                                })
                                
                                Button(action: {
                                    tm.backgroundNoise = .rain
                                }, label: {
                                    Label(tm.backgroundNoise == .rain ? "✅ Rain" : "Rain", systemImage: "cloud.rain")
                                })
                                
                                Button(action: {
                                    tm.backgroundNoise = .turnOff
                                }, label: {
                                    Label(tm.backgroundNoise == .turnOff ? "✅ Turn ff" : "Turn off", systemImage: "speaker.slash")
                                })
                                
                            } label: {
                                Image(systemName: "speaker.circle")
                            }
                        }
                        
                        NavigationLink(destination: {
                            AddTimerView()
                        }, label: {
                            Image(systemName: "plus")
                        })
                    })
        }//nav
    }
}

extension TimerView {
    
    func formatTime() -> String {
        
        if let timerStyle = tm.timerStyle {
            switch timerStyle {
            case .focus:
                let minute = Int(tm.elapsedFocusTime) / 60 % 60
                let second = Int(tm.elapsedFocusTime) % 60
                
                return String(format: "%02i:%02i", minute, second)
            case .short:
                let minute = Int(tm.elapsedShortTime) / 60 % 60
                let second = Int(tm.elapsedShortTime) % 60
                
                return String(format: "%02i:%02i", minute, second)
            case .long:
                let minute = Int(tm.elapsedLongBreakTime) / 60 % 60
                let second = Int(tm.elapsedLongBreakTime) % 60
                
                return String(format: "%02i:%02i", minute, second)
            }
        }
            return "00:00"
    }
}
