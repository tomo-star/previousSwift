//
//  ViewController.swift
//  MapAndProtocol
//
//  Created by 小川智也 on 2020/03/06.
//  Copyright © 2020 小川智也. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController,CLLocationManagerDelegate,UIGestureRecognizerDelegate, MKMapViewDelegate,SearchLocationDelegate {
    

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {}
    var adressString=""
    var locationManager:CLLocationManager!
    
    mapView.delegate=self
    mapView.showsUserLocation=true
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    
    @IBOutlet weak var settingButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locManager: CLLocationManager!
    
   
    
    @IBOutlet weak var adressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingButton.backgroundColor = .white
        settingButton.layer.cornerRadius = 20.0
        
    }


    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
    
//        タップ開始
        if sender.state == .began{
        
        
        
        
        }else if sender.state == .ended{
            
//            タップを終了
//            緯度経度を取得
//            住所を特定
            let tapPoint = sender.location(in: view)
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            let lat = center.latitude
            let log = center.longitude
            convert(lat: lat, log: log)
            let countryCode = NSLocale.preferredLanguages.first! as String
            print(countryCode)
            
        }
    
    }

    func convert(lat:CLLocationDegrees,log:CLLocationDegrees){
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: log)
        
        geocoder.reverseGeocodeLocation(location) { (placeMark, error) in
            
            if let placeMark = placeMark{
                
                if let pm = placeMark.first{
                    if pm.administrativeArea != nil || pm.locality != nil{
//                        ！は値がなかったらその先に行かない
//                        selfは上で宣言しているから必要
                        self.adressString = pm.name! + pm.administrativeArea! + pm.locality!
                    }else{
                        
                        self.adressString = pm.name!
                        
                    }
                    self.adressLabel.text = self.adressString
                    
                }
                
            }
            
        }
        
    }
    
    
    
    
    @IBAction func goToSearchVC(_ sender: Any) {
    
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            
            let nextVC = segue.destination as! NextViewController
            nextVC.delegate = self
        }
    }
    
    func searchLocation(idoValue: String, keidoValue: String) {
        if idoValue.isEmpty != true && keidoValue.isEmpty != true{
            
            let idoString = idoValue
            let keidoString = keidoValue
            
            let coordinate = CLLocationCoordinate2DMake(Double(idoString)!, Double(keidoString)!)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            convert(lat: Double(idoString)!, log: Double(keidoString)!)
            
            adressLabel.text = adressString
        }else{
            
            adressLabel.text = "表示できません"
            
        }
    }
    
}
