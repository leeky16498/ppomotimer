//
//  AddTimerView.swift
//  PPomoTimer1
//
//  Created by Kyungyun Lee on 27/02/2022.
//

import SwiftUI

struct AddTimerView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("isTimer") var isTimer : Bool = false
    @AppStorage("focusStart") private var focusStart : Int = 25
    @AppStorage("breakStart") private var breakStart : Int = 5
    @AppStorage("longBreakStart") private var longBreakStart : Int = 30
    
    @EnvironmentObject var tm : TimerModel
    
    @State var isAuto : Bool = false
    @State var isTimePicker : Bool = false
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
            Form {
                Section {
                    HStack{
                        Image(systemName: "timer")
                            .frame(width : 30, height : 30)
                            .background(.green)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                        Text("Timer icon")
                            .font(.headline)
                        Spacer()
                        Menu("🍅") {
                            Button(action: {
                                
                            }, label: {
                                Text("🍅")
                                    .frame(width : 30, height : 30)
                                    .background(.gray.opacity(0.4))
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                            })
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Section{
                    HStack{
                        Image(systemName: "target")
                            .frame(width : 30, height : 30)
                            .background(.red)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                        Text("Focus time")
                            .font(.headline)
                        Spacer()
                        
                        Picker("", selection: $focusStart) {
                            ForEach(1..<61) {
                                Text("\($0)min").tag($0)
                            }
                        }

                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    HStack{
                        Image(systemName: "sun.max.fill")
                            .frame(width : 30, height : 30)
                            .background(.yellow)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                        Text("Short break")
                            .font(.headline)
                        Spacer()
                        Picker("", selection: $breakStart) {
                            ForEach(1..<61) {
                                Text("\($0)min").tag($0)
                            }
                        }
                    }
                    .disabled(focusStart == 0)
                    .buttonStyle(PlainButtonStyle())
                    
                    HStack{
                        Image(systemName: "moon.fill")
                            .frame(width : 30, height : 30)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                        Text("Long break")
                            .font(.headline)
                        Spacer()
                        Picker("", selection: $longBreakStart) {
                            ForEach(1..<61) {
                                Text("\($0)min").tag($0)
                            }
                        }
                    }
                    .disabled(focusStart == 0)
                    .buttonStyle(PlainButtonStyle())
                }
                
                Section {
                    HStack{
                        Text("Auto continue")
                            .font(.headline)
                        Spacer()
                        Toggle("", isOn: $tm.isAuto)
                    }
                    
                    HStack{
                        Text("Skip long break")
                            .font(.headline)
                        Spacer()
                        Toggle("", isOn: $tm.isSkipMode)
                    }
                    
                    HStack{
                        Text("Turn on sound")
                            .font(.headline)
                        Spacer()
                        Toggle("", isOn: $tm.isOnSound)
                    }
                }
                
                Section {
                    Button("Save timer setting") {
                        tm.timerStyle = .focus
                        tm.elapsedFocusTime = focusStart*60
                        tm.totalFocusTime = focusStart*60
                        tm.elapsedShortTime = breakStart*60
                        tm.totalShortTime = breakStart*60
                        tm.elapsedLongBreakTime = longBreakStart*60
                        tm.totalLongBreakTime = longBreakStart*60
                        
                        tm.timerMode = .normal
                        tm.timerStyle = .focus
                        tm.isStarted = false
                        tm.progress = 0
                        tm.elapsedShortTime = tm.totalShortTime
                        
                        if tm.isOnSound {
                            playSound(sound: "chimeup", type: "mp3")
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                }
            }
            .background(Color("BackgroundColor"))
           
        .navigationTitle("New Timer")
    }
}

struct AddTimerView_Previews: PreviewProvider {
    static var previews: some View {
        AddTimerView()
    }
}
