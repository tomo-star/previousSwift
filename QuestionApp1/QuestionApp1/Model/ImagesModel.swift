//
//  imagesModel.swift
//  QuestionApp1
//
//  Created by 小川智也 on 2020/03/09.
//  Copyright © 2020 小川智也. All rights reserved.
//

import Foundation

class ImagesModel{
    
    let imageText: String
    let answer: Bool
    
    init(imageName: String,correctOrNot: Bool) {
        imageText = imageName
        answer = correctOrNot
    }
}
