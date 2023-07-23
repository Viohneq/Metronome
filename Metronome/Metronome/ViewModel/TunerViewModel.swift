//
//  MetronomeViewModel.swift
//  Metronome
//
//  Created by Yuriy Egorov on 12/04/2023.
//
import AudioKit
import AudioKitEX
import AVFoundation
import AudioToolbox
import SoundpipeAudioKit
import SwiftUI

class TunerViewModel : ObservableObject, HasAudioEngine {
    let engine = AudioEngine()
    
    @Published var note = "E"
    
    let initialDevice: Device
    
    let mic: AudioEngine.InputNode    
    var tracker: PitchTap!
    
    let noteFrequencies = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, 25.96, 27.5, 29.14, 30.87]
    let noteNamesWithSharps = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]
    
    init() {
        guard let input = engine.input else { fatalError() }
        
        guard let device = engine.inputDevice else { fatalError() }
        
        initialDevice = device
        
        mic = input
        engine.output = Fader(input)
        requestAccessIfNeeded()

        tracker = PitchTap(mic) { pitch, amp in
            DispatchQueue.main.async {
                self.update(pitch[0], amp[0])
            }
        }
        tracker.start()
    }
    
    func update(_ pitch: AUValue, _ amp: AUValue) {
        // Reduces sensitivity to background noise to prevent random / fluctuating data.
        guard amp > 0.1 else { return }
        
        var frequency = pitch
        while frequency > Float(noteFrequencies[noteFrequencies.count - 1]) {
            frequency /= 2.0
        }
        while frequency < Float(noteFrequencies[0]) {
            frequency *= 2.0
        }
        
        var minDistance: Float = 10000.0
        var index = 0
        
        for possibleIndex in 0 ..< noteFrequencies.count {
            let distance = fabsf(Float(noteFrequencies[possibleIndex]) - frequency)
            if distance < minDistance {
                index = possibleIndex
                minDistance = distance
            }
        }
        let octave = Int(log2f(pitch / frequency))
        note = "\(noteNamesWithSharps[index])\(octave)"
    }
    
    private func requestAccessIfNeeded() {
        switch AVAudioSession.sharedInstance().recordPermission {
            case .granted:
                print("Permission granted")
            case .undetermined:
                AVAudioSession.sharedInstance().requestRecordPermission({ granted in
                // Handle granted
                })
            case .denied:
                openAppSettings()
            @unknown default:
                print("Unknown case")
        }
    }
    
    private func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
}
