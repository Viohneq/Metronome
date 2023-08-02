//
//  MetronomeTapButton.swift
//  Metronome
//
//  Created by Yuriy Egorov on 23/07/2023.
//

import SwiftUI

struct MetronomeTapButton: View {
    
    var text: String
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Button(action: action ) {
                Text(text)
                    .frame(width: 260, height: 260)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .background(Color.purple.opacity(0.65))
                    .cornerRadius(180)
                    .overlay(
                        RoundedRectangle(cornerRadius: 180)
                            .stroke(Color.white, lineWidth: 2)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    )
                    .contentShape(RoundedRectangle(cornerRadius: 180))
            }
        }
    }
}
