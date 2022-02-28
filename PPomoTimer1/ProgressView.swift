//
//  ProgressView.swift
//  PPomoTimer1
//
//  Created by Kyungyun Lee on 27/02/2022.
//


import SwiftUI

struct ProgressView: View {
    
    var progress : Double
    var gradientColors : [Color]
    var time : String
    
    var body: some View {
            ZStack {
                Circle()
                    .stroke(lineWidth: 15)
                    .foregroundColor(.gray)
                    .opacity(0.1)
                
                Circle()
                    .trim(from: 0.0, to:
                            1-progress)
                    .stroke(AngularGradient(gradient: Gradient(colors: gradientColors), center: .center), style: StrokeStyle(lineWidth : 15, lineCap: .round, lineJoin: .round))
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.easeOut(duration: 1.0), value: progress)
                
                VStack {
                    ZStack{
                        Text(time)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("\(Int(progress * 100))%")
                            .frame(width : 50, height : 30)
                            .font(.headline)
                            .foregroundColor(.gray.opacity(0.5))
                            .background(.gray.opacity(0.15))
                            .clipShape(Capsule())
                            .offset(y: 60)
                    }
                    
                }
            }
            .frame(width : 250, height : 250)
            .shadow(color: .gray, radius: 1, x: 0.5, y: 0.5)
            .padding()
    }
}
