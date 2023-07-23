//
//  ContentView.swift
//  Metronome
//
//  Created by Yuriy Egorov on 22/07/2023.
//

import SwiftUI

struct ContentView: View {
    var metronomeViewModel = MetronomeViewModel()
    var body: some View {
        TabView {
           MetronomeView(metronomeData: metronomeViewModel)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Metronome")
                }
            TunerView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Tuner")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
