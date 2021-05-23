//
//  SoundsManage.swift
//  CardGames
//
//  Created by Vanbert on 28/09/20.
//

import Foundation
import AVFoundation

class SoundsManage{
    
    static var audioPlayer:AVAudioPlayer?
    
    //------------------------------------------------------------------------------------------
    
    enum soundForGame{
        
        case flip
        case shuffle
        case match
        case nomatch
        case soundHome
        case soundScore
        
    }
    
    //------------------------------------------------------------------------------------------
    
    //To play the sound
    static func playSound(_ mySounds:soundForGame){
        
        var soundFilename = ""
        switch mySounds {
        case .flip:
            soundFilename = "cardflip"
        case .shuffle:
            soundFilename = "shuffle"
        case .match:
            soundFilename = "correct"
        case .nomatch:
            soundFilename = "wrong"
        case .soundHome:
            soundFilename = "backsoundhome"
        case .soundScore:
            soundFilename = "backsoundscore"
        }
        
        let soundPath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard soundPath != nil else {
            print("Woops! your file name \(soundFilename) could not be found")
            return
        }
        
        //Create url
        let soundURL = URL(fileURLWithPath: soundPath!)
        
        //create Audio
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        }catch{
            print("Cannot create the object of audio player \(soundFilename)")
        }
    }
    
    //------------------------------------------------------------------------------------------
    
}
