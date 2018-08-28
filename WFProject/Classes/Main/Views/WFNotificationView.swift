//
//  WFNotificationView.swift
//  WFProject
//
//  Created by bi ying on 2018/8/27.
//  Copyright © 2018年 WF. All rights reserved.
//

import UIKit
import RAMPaperSwitch

class WFNotificationView : UIView {
    
    @IBOutlet var paperSwitch: RAMPaperSwitch!
    @IBOutlet var animationlabel : UILabel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        
        self.paperSwitch.animationDidStartClosure = {(onAnimation: Bool) in
            
            self.animateLabel(self.animationlabel, onAnimation: onAnimation, duration: self.paperSwitch.duration)
            
        }
        
    }
    
    fileprivate func animateLabel(_ label: UILabel, onAnimation: Bool, duration: TimeInterval) {
        UIView.transition(with: label, duration: duration, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            if(onAnimation){
                if(UIApplication.shared.currentUserNotificationSettings?.types.rawValue == 0){
                    let infoDict = Bundle.main.infoDictionary
                    let app_name = infoDict!["CFBundleDisplayName"] as! String
                    WFAppManager.Alert(title: "Tip",message: ("Your Notification Setting of " + app_name + "is off,open it and you can get the receive emergency weather announcers in time"), confirm: "Sure", cancel: "", confirmActin: {
                        
                        self.paperSwitch.setOn(!onAnimation, animated: false)
                        
                    }, cancelAction: {})
                }else{
                    label.textColor = onAnimation ? UIColor.white : MainColorBlue
                    UserDefaults.standard.set(onAnimation, forKey: "NotificationCenter") 
                } 
            }else{
                label.textColor = onAnimation ? UIColor.white : MainColorBlue
                UserDefaults.standard.set(onAnimation, forKey: "NotificationCenter") 
            } 
           
        }, completion:nil)
    }
    
}
