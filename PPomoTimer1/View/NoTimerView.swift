//
//  NoTimerView.swift
//  PPomoTimer1
//
//  Created by Kyungyun Lee on 27/02/2022.
//

import SwiftUI

struct NoTimerView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.badge.clock")
                .foregroundColor(.mint)
                .font(.system(size: 100))
                .padding()
            Text("Add your timer now!")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            Text("Hey! 😀 Welcome to PPO.MO timer.\n Press ' + ' button and start your journey!")
                .font(.body)
                .italic()
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                
        }
        .padding()
    }
}
