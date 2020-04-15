//
//  TableViewController.swift
//  Swift5GoogleAdmb1
//
//  Created by 小川智也 on 2020/03/13.
//  Copyright © 2020 小川智也. All rights reserved.
//

import UIKit
import GoogleMobileAds

class TableViewController: UITableViewController,GADBannerViewDelegate,GADInterstitialDelegate {

    var profileImageArray = ["0","1","2","3","4"]
    var textArray = ["顔文字0","顔文字1","顔文字2","顔文字3","インタースティシャル広告"]
    var interstitial:GADInterstitial!
    var backImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "backGrondImage")
        backImageView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        backImageView.image = image
        tableView.backgroundView = backImageView
        
        interstitial = createAndLoadInterstitial()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1 + textArray.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexNumber = indexPath.row
        print(indexPath.row)
        if indexPath.row == 0{
//            インタースティシャル
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath)
            let bannerView = cell.viewWithTag(1) as! GADBannerView
            bannerView.adUnitID = "ca-app-pub-4918725590056091/1981275594"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            return cell
            
        }else{
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            let profileImageView = cell2.viewWithTag(1) as! UIImageView
            profileImageView.image = UIImage(named: profileImageArray[indexNumber - 1])
            let nameLabel = cell2.viewWithTag(2) as! UILabel
            nameLabel.textColor = .white
            nameLabel.font = .boldSystemFont(ofSize: 20)
            nameLabel.numberOfLines = 3
            nameLabel.text = textArray[indexNumber - 1]
            
            return cell2
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5{
            
            if interstitial.isReady{
                
                interstitial.present(fromRootViewController: self)
                
            }else{
                print("まだ広告の準備ができていません")
            }
            
        }
    }
    
    func createAndLoadInterstitial() -> GADInterstitial{
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-4918725590056091/2172847283")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    
    
    }
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        
    }
}
