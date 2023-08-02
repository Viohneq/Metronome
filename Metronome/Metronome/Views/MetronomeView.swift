//
//  MetronomeView.swift
//  Metronome
//
//  Created by Yuriy Egorov on 09/04/2023.
//

import SwiftUI

struct MetronomeView: View {
    @ObservedObject var metronomeData: MetronomeViewModel
        
    var body: some View {
        
        VStack {
            ZStack {
                MetronomeTapButton(text: String(Int(metronomeData.bpm)), action: metronomeData.toggle)
                MetronomeSlider(angle: CGFloat(metronomeData.angle), onChanged: metronomeData.onChanged(value:), onFinished: metronomeData.onFinished(value:))
            }
            Spacer().frame(height: 50)
            HStack {
                makeChangeButton(value: -10)
                Spacer().frame(width: 15)
                makeChangeButton(value: -5)
                Spacer().frame(width: 15)
                makeChangeButton(value: +5)
                Spacer().frame(width: 15)
                makeChangeButton(value: +10)
            }
        }
    }
    
    func makeChangeButton(value: Int) -> MetronomeButton {
        let textForButton = value < 0 ? String(value) : "+"+String(value)
        return MetronomeButton(value: textForButton , action: {
            metronomeData.changeBpm(value: value)
        })
    }
}
