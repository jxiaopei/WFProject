//
//  WFMenuViewController.swift
//  WFProject
//
//  Created by bi ying on 2018/8/27.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation

class WFMenuViewController : ViewController {
    
    let notificationView  : WFNotificationView = Bundle.main.loadNibNamed("WFNotificationView", owner: self, options: nil)?.first as! WFNotificationView
    
    let COrFSelcetView : WFCelsiusOrFahrenheitView = Bundle.main.loadNibNamed("WFCelsiusOrFahrenheitView", owner: self, options: nil)?.first as! WFCelsiusOrFahrenheitView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        notificationView.layer.masksToBounds = true
        notificationView.layer.cornerRadius = 10
        
        self.view.addSubview(notificationView)
        notificationView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(74)
            make.height.equalTo(145)
        }
        notificationView.paperSwitch.setOn(NotificationSetting(), animated: false)
    
        COrFSelcetView.layer.masksToBounds = true
        COrFSelcetView.layer.cornerRadius = 10
        self.view.addSubview(COrFSelcetView)
        COrFSelcetView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(notificationView.snp.bottom).offset(10)
            make.height.equalTo(145)
        }
        COrFSelcetView.paperSwitch.setOn(F_or_C(), animated: false)
        
        
    }
    
    
    
    
}
