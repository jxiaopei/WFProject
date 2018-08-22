//
//  WFHubTool.swift
//  WFProject
//
//  Created by hello on 2018/8/18.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation

class WFHubTool: NSObject {
    
    class func hub(view:UIView , text:String) {
        let hub = MBProgressHUD(view: view)
        hub.contentColor = UIColor.white
        hub.bezelView.color = UIColor.black
        hub.mode = .text
        hub.label.text = text
        hub.removeFromSuperViewOnHide = true
        view.addSubview(hub)
        hub.show(animated: true)
        hub.hide(animated: true, afterDelay: 1.5)
    }
    
    
}
