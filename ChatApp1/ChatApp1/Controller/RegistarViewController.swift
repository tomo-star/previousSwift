//
//  RegistarViewController.swift
//  ChatApp1
//
//  Created by 小川智也 on 2020/03/14.
//  Copyright © 2020 小川智也. All rights reserved.
//

import UIKit
import Firebase
import Lottie


class RegistarViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func registarNewUser(_ sender: Any) {
        
        startAnimation()
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil{
                
                print(error as Any)
                
            }else{
                
                print("ユーザーの作成が成功しました！")
//                関数の中に関数があるときはselfをつける
                self.stopAnimation()
                
                self.performSegue(withIdentifier: "chat", sender: nil)
            }
        }

    }
    
    func startAnimation(){
        let animation = Animation.named("loading")
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/1.5)
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        view.addSubview(animationView)
        
        
    }
    
    func stopAnimation(){
        
        animationView.removeFromSuperview()
        
    }
    
}
