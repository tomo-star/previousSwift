//
//  WithOutMP3.swift
//  QuestionApp1
//
//  Created by 小川智也 on 2020/03/10.
//  Copyright © 2020 小川智也. All rights reserved.
//

import Foundation

class WithOutMP3: SoundFile{
    
    override func playSound(fileName: String, extensionName: String) {
        if extensionName == "mp3"{
            
            print("このファイルは再生できませんごめん")
            
        }
        player?.stop()
    }
    
}
