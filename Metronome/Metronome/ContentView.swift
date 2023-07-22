//
//  ContentView.swift
//  Metronome
//
//  Created by Yuriy Egorov on 22/07/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MetronomeView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
