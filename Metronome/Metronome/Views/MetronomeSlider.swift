//
//  MetronomeSlider.swift
//  Metronome
//
//  Created by Yuriy Egorov on 23/07/2023.
//

import SwiftUI

struct MetronomeSlider: View {
    
    var angle: CGFloat
    var onChanged: (DragGesture.Value) -> Void
    var onFinished: (DragGesture.Value) -> Void
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .fill(Color.gray.opacity(0.15))
                .frame(width: 300, height: 300)
            Circle()
                .trim(from: 0, to: angle / 360)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .fill(Color.purple.opacity(0.85))
                .frame(width: 300, height: 300)
            Circle()
                .fill(.gray)
                .frame(width: 25, height: 25)
                .offset(x: (300 / 2))
                .rotationEffect(Angle(degrees: angle))
                .overlay(
                    RoundedRectangle(cornerRadius: 180)
                        .stroke(Color.white, lineWidth: 2)
                        .shadow(color: .black, radius: 2, x: 0, y: 2)
                        .frame(width: 27, height: 28)
                        .offset(x: (300 / 2))
                        .rotationEffect(Angle(degrees: angle))
                )
                .simultaneousGesture(
                    DragGesture()
                        .onChanged(onChanged)
                        .onEnded(onFinished)
                )
        }
        .rotationEffect(.init(degrees: 126))
    }
}
