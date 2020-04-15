//
//  ViewController.swift
//  QuestionApp1
//
//  Created by 小川智也 on 2020/03/08.
//  Copyright © 2020 小川智也. All rights reserved.
//

import UIKit

class ViewController: UIViewController,nowScoreDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var maxScoreLabel: UILabel!
    
    let imageslist = ImagesList()
    
    var correctCount = 0
    var wrongCount = 0
    var maxScore = 0
    var questionNumber = 0
    var soundFile = SoundFile()
    var gradientLayer = CAGradientLayer()
    
//    IBアクションで検知した正答がどちらかを取得
    var pickedAnswer = false
    var changeColor = ChangeColor()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLayer = changeColor.changeColor(topR: 0.07, topG: 0.13, topB: 0.26, topAlpha: 1.0, bottomR: 0.54, bottomG: 0.74, bottomB: 0.74, bottomAlpha: 1.0)
//        全体
        gradientLayer.frame = view.bounds
//        レイヤーを使うときはこれを使う
        view.layer.insertSublayer(gradientLayer, at: 0)
        imageView.layer.cornerRadius = 20.0
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
//        初期化
        correctCount = 0
        wrongCount = 0
        questionNumber = 0
        
        imageView.image = UIImage(named: imageslist.list[0].imageText)
        if UserDefaults.standard.object(forKey: "beforeCount") != nil{
            maxScore = UserDefaults.standard.object(forKey: "beforeCount") as! Int
        }
        
        maxScoreLabel.text = String(maxScore)
    }
    @IBAction func answer(_ sender: Any) {
        
//        senderはiboutletをしなくても使える
        if (sender as AnyObject).tag == 1{
            pickedAnswer = true
            
        }else if (sender as AnyObject).tag == 2{
            
//            バツボタン
            pickedAnswer = false
            
        }
        check()
        nextQuestions()
        
    }
    
    
    func check(){
        
        let correctAnswer = imageslist.list[questionNumber].answer
        if correctAnswer == pickedAnswer{
            
            print("正解です")
            soundFile.playSound(fileName: "maruSound", extensionName: "mp3")
            correctCount += 1
            
        }else{
            print("間違い")
            soundFile.playSound(fileName: "batsuSound", extensionName: "mp3")
            wrongCount += 1
        }
        
        
    }
    
    func nextQuestions(){
        
        if questionNumber <= 9{
            
            questionNumber += 1
            
            imageView.image = UIImage(named: imageslist.list[questionNumber].imageText)
            
        }else{
            print("問題終了")
            performSegue(withIdentifier: "next", sender: nil)
        }
        
        
    }
    func nowScore(score: Int) {
        maxScoreLabel.text = String(score)
        soundFile.playSound(fileName: "sound", extensionName: "mp3")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let nextVC = segue.destination as! NextViewController
            nextVC.correctedCount = correctCount
            nextVC.wrongCount = wrongCount
            nextVC.delegate = self
        }
    }
}

