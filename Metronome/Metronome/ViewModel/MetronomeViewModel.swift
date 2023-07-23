//
//  MetronomeViewModel.swift
//  Metronome
//
//  Created by Yuriy Egorov on 12/04/2023.
//

import AVKit
import SwiftUI

let url = Bundle.main.url(forResource: "tick_sound", withExtension: "wav")!

class MetronomeViewModel : ObservableObject {
    @Published var player = try! AVAudioPlayer(contentsOf: url)
    @Published var isPlaying = false
    @Published var angle: Double = 0
    @Published var bpm = 120.0
    @Published var bpmRange = 40.0...280.0
    @Published var ticks = 0
    
    private var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block:  {
        _ in
        return
    })
    
    
    init() {
        updateAngle()
    }
    
    func toggle() {
        updatePlayerRate()
        if !isPlaying {
            let interval = 60.0 / bpm
            timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
                self.player.play()
                self.isPlaying = true
                self.ticks += 1
            }
        } else {
            self.timer.invalidate()
            self.player.stop()
            self.isPlaying = false
        }
    }
    
    func onChanged(value: DragGesture.Value) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        let radians = atan2(vector.dy - 25, vector.dx - 25)
        let tempAngle = radians * 180 / .pi
        
        let angle = tempAngle < 0 ? 360 + tempAngle : tempAngle
        if angle <= 288 {
            withAnimation(Animation.linear(duration: 0.1)) {
                self.angle = Double(angle)
                updateBpm()
            }
        }
    }
    
    func changeBpm(value: Int) {
        let newValue = bpm + Double(value)
        switch newValue {
        case 0...bpmRange.lowerBound:
            bpm = 40
        case bpmRange.lowerBound...bpmRange.upperBound:
            bpm = newValue
        default:
            bpm = bpmRange.upperBound
        }
        if newValue < 40.0 || newValue > 280.0 {
            return
        } else {
            bpm = newValue
        }
        updateAngle()
        updatePlayerRate()
        restartAfterChangedValue()
    }
    
    func onFinished(value: DragGesture.Value) {
        restartAfterChangedValue()
    }
    
    private func updatePlayerRate() {
        player.rate = Float(bpm / 60)
        player.prepareToPlay()
    }
    
    private func getPlayer(tickUrl: URL) -> AVAudioPlayer {
        do {
            let player = try AVAudioPlayer(contentsOf: tickUrl)
            return player
        } catch {
            print(error.localizedDescription)
            return player
        }
    }
    
    private func updateAngle() {
        angle = (bpm - 40) / 0.833
    }
    
    private func updateBpm() {
        bpm = angle * 0.833 + 40
    }
    
    private func restartAfterChangedValue() {
        if isPlaying {
            toggle()
            toggle()
        }
    }
}
