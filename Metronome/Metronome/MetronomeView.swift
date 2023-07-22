//
//  MetronomeView.swift
//  Metronome
//
//  Created by Yuriy Egorov on 09/04/2023.
//

import SwiftUI

struct MetronomeView: View {
    @StateObject var metronomeData = MetronomeViewModel()
        
    var body: some View {
        
        VStack {
            
            ZStack {
                Button(action: toggleMetronome ) {
                    Text(String(Int(metronomeData.bpm)))
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
                
                ZStack {
                    Circle()
                        .trim(from: 0, to: 0.8)
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .fill(Color.gray.opacity(0.15))
                        .frame(width: 300, height: 300)
                    Circle()
                        .trim(from: 0, to: CGFloat(metronomeData.angle) / 360)
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .fill(Color.purple.opacity(0.85))
                        .frame(width: 300, height: 300)
                    Circle()
                        .fill(.gray)
                        .frame(width: 25, height: 25)
                        .offset(x: (300 / 2))
                        .rotationEffect(Angle(degrees: metronomeData.angle))
                        .overlay(
                            RoundedRectangle(cornerRadius: 180)
                                .stroke(Color.white, lineWidth: 2)
                                .shadow(color: .black, radius: 2, x: 0, y: 2)
                                .frame(width: 27, height: 28)
                                .offset(x: (300 / 2))
                                .rotationEffect(Angle(degrees: metronomeData.angle))
                        )
                        .simultaneousGesture(
                            DragGesture()
                                .onChanged(metronomeData.onChanged(value:))
                                .onEnded(metronomeData.onFinished(value:))
                        )
                }
                .rotationEffect(.init(degrees: 126))
                
            }
        }
    
    }
    
    func toggleMetronome() {
        metronomeData.toggle()
    }
}
