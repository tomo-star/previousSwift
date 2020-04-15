//
//  SoundFile.swift
//  QuestionApp1
//
//  Created by 小川智也 on 2020/03/10.
//  Copyright © 2020 小川智也. All rights reserved.
//

import Foundation
import AVFoundation

class SoundFile{
    
    var player:AVAudioPlayer?
    
    func playSound(fileName:String,extensionName:String){
        
        let soundURL = Bundle.main.url(forResource: fileName, withExtension: extensionName)
        
        do {
            
            player = try AVAudioPlayer(contentsOf: soundURL!)
            
            player?.play()
            
        } catch  {
            print("エラーです")
        }
        
    }
}
