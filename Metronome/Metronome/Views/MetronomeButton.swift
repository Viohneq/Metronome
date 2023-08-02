//
//  MetronomeView.swift
//  Metronome
//
//  Created by Yuriy Egorov on 09/04/2023.
//

import SwiftUI

struct MetronomeButton: View {
    
    var value: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(value)
                .foregroundColor(.white)
                .padding()
                .background(.purple)
                .cornerRadius(10)
                .frame(width: 80, height: 80, alignment: .center)
                .lineLimit(1) // Truncate the text if it doesn't fit within the width
                .minimumScaleFactor(0.5) // Adjust the minimum scale factor as needed
                .allowsTightening(true)
        }
        .frame(width: 80, height: 80, alignment: .center)
        .fixedSize(horizontal: true, vertical: true)

    }
}
