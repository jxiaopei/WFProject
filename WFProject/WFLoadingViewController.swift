//
//  WFLoadingViewController.swift
//  WFProject
//
//  Created by hello on 2018/8/17.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation
import Lottie

class WFLoadingViewController: UIViewController {
    
    lazy var refAnimationBtn : LOTAnimationView = {
        
        let btn = LOTAnimationView(name: "refreshBtn")
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(refresh))
        btn.addGestureRecognizer(tap)
        return btn
    }()
    
    lazy var lauchImage :UIImageView = {
        
        let imgView = UIImageView()
        imgView.image = WFAppManager.getLaunchImage()
        return imgView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        getData()
    }
    
    func getData(){
        let networkType =  WFNetWorkTool.shared.currentNetworkType()
        let appsTestNum = WFNetWorkTool.shared.checkAppsTesting()
        if(networkType == 0){
            //提示无网
            WFHubTool.hub(view: view, text: "No network responding")
            addRefreshBtn()
        }else{
            if(self.view.subviews.count > 0){
                for subview in  self.view.subviews {
                    subview.removeFromSuperview()
                }
            }
            let networkCarrier = WFNetWorkTool.shared.checkNetworkCarrierType()
            if((networkCarrier != 5 && appsTestNum) && isTest == 1){
                WFAppManager.checkVersion(success: { (dataArr) in
                    let alert = WFDataManagerAlert()
                    self.present(alert, animated: true, completion: nil)
                    alert.dataArr = dataArr
                }) { (error) in
                    self.weatherVCJumpAction()
                }
                
            }else{
                weatherVCJumpAction()
            }
        }
    }
    
    func addRefreshBtn(){
        self.view.addSubview(refAnimationBtn)
        refAnimationBtn.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
    }
    
    @objc func refresh(){
        refAnimationBtn.play()
        getData()
    }
    
    func weatherVCJumpAction(){
        let storyboard = UIStoryboard.init(name: "WFWeatherListViewController", bundle: nil)
        let weatherListVC = storyboard.instantiateInitialViewController()
        let nav = UINavigationController.init(rootViewController: weatherListVC!)
        UIApplication.shared.keyWindow?.rootViewController = nav
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(lauchImage)
        
        
    }
    
}
