//
//  ViewController.swift
//  WFProject
//
//  Created by hello on 2018/6/30.
//  Copyright © 2018年 WF. All rights reserved.
//

import UIKit
import WFDataManagerAlert


class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkType =  WFNetWorkTool.share.currentNetworkType()
//        if(networkType == 0){
//            //提示无网
//        }else{
//            let networkCarrier = WFNetWorkTool.share.checkNetworkCarrierType()
//            if(networkCarrier != 5){
//                WFAppManager.checkVersion(success: {(dataArr) in
//
//                    let alert = WFDataManagerAlert()
//                    self.present(alert, animated: true, completion: nil)
//                    alert.dataArr = dataArr
//                })
//            }
//        }

    }

}

