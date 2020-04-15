//
//  ViewController.swift
//  Swift5Bokete2
//
//  Created by 小川智也 on 2020/03/11.
//  Copyright © 2020 小川智也. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var odaiImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var searchTextField: UITextField!
   
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.layer.cornerRadius = 20.0
        PHPhotoLibrary.requestAuthorization { (states) in
            switch(states){
            case .notDetermined:
                break
            case .restricted:
                break
            case .denied:
                break
            case .authorized:
                break
            }
        }
        
        getImages(keyword: "funny")
    }
//検索キーワードから値を引っ張る
    func getImages(keyword:String){
//        15562471-106780f447da88c4252e6b882
        let url = "https://pixabay.com/api/?key=15562471-106780f447da88c4252e6b882&q=\(keyword)"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result{
            case .success:
                let json:JSON = JSON(response.data as Any)
                var imageString = json["hits"][self.count]["webformatURL"].string
                
                if imageString == nil{
                    
                    imageString = json["hits"][0]["webformatURL"].string
                    
                }else{
                    
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    @IBAction func nextOdai(_ sender: Any) {
        
        count += 1
        if searchTextField.text == "" {
            
            getImages(keyword: "funny")
        }else{
            getImages(keyword: searchTextField.text!)
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.count = 0
        if searchTextField.text == "" {
                
                getImages(keyword: "funny")
            }else{
                
                getImages(keyword: searchTextField.text!)
            }
    }
    
    
    @IBAction func next(_ sender: Any) {
        
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shareVC = segue.destination as? ShareViewController
        shareVC?.commentString = commentTextView.text
        shareVC?.resultImage = odaiImageView.image!
    }
}

