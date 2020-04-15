//
//  ViewController.swift
//  Swift5CameraAlbum1
//
//  Created by 小川智也 on 2020/03/10.
//  Copyright © 2020 小川智也. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var backImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //       ユーザーに許可を促す
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status){
            case .authorized:
                print("許可されてます")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("制限された")
            case .denied:
                print("拒否された")
            }
        }
    }
    
    
    @IBAction func openCamera(_ sender: Any) {
        
        let sourceType = UIImagePickerController.SourceType.camera
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            present(cameraPicker, animated: true, completion: nil)
        }else{
            
            print("エラーです")
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openAlbum(_ sender: Any) {
        let sourceType = UIImagePickerController.SourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            present(cameraPicker, animated: true, completion: nil)
        }else{
            
            print("エラーです")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage{
            
            backImageView.image = pickedImage
//            保存
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, nil, nil)
            picker.dismiss(animated: true, completion: nil)
            
            
            
        }
    }
//    シェアボタン
    
    @IBAction func share(_ sender: Any) {
        
        let text = "#ウイイレ"
        let image = backImageView.image?.jpegData(compressionQuality: 0.2)
        let items = [text,image] as [Any]
        
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
}

