//
//  SoundManager.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

//import Foundation
import AVFoundation

class SoundManager: NSObject {
    
    static let shared = SoundManager()
    
    private var player: AVAudioPlayer?
    
    var isSoundEnabled: Bool? {
        get {
            // Since UserDefaults.standard.bool(forKey: "sound") will default to "false" if it has not been set
            // You might want to use `object`, because if an object has not been set yet it will be nil
            // Then if it's nil you know it's the user's first time launching the app
            UserDefaults.standard.object(forKey: "sound") as? Bool
        }
        set(newSetting) {
            UserDefaults.standard.set(newSetting, forKey: "sound")
        }
    }
    
    func playSound() {
        let path = Bundle.main.path(forResource: "Jeopardy-theme-song.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            checkSound()
        } catch {
            let nserror = error as NSError
            fatalError("Player does not work \(nserror), \(nserror.userInfo)")
        }
    }
    
    func checkSound() {
        if !(isSoundEnabled ?? true) {
            player?.stop()
        } else {
            player?.numberOfLoops = -1
            player?.play()
        }
    }
    
    func toggleSoundPreference() {
        isSoundEnabled = !(isSoundEnabled ?? true)
        checkSound()
    }
    
}
