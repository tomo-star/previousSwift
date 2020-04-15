//
//  ViewController.swift
//  Swift5GoogleAdmb1
//
//  Created by 小川智也 on 2020/03/13.
//  Copyright © 2020 小川智也. All rights reserved.
//

import UIKit
import GoogleMobileAds


class ViewController: UIViewController {
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        bannerView.adUnitID = "ca-app-pub-4918725590056091/4990582317"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }


}

