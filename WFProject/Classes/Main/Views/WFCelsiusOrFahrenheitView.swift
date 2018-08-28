//
//  WFCelsiusOrFahrenheitView.swift
//  WFProject
//
//  Created by bi ying on 2018/8/27.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation
import RAMPaperSwitch

class WFCelsiusOrFahrenheitView : UIView{
    
    @IBOutlet var paperSwitch: RAMPaperSwitch!
    @IBOutlet var animationLabel : UILabel!
    @IBOutlet var celsiusLabel : UILabel!
    @IBOutlet var fahrenheitLabel : UILabel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        
        self.paperSwitch.animationDidStartClosure = {(onAnimation: Bool) in
            
            self.animateLabel(self.animationLabel, onAnimation: onAnimation, duration: self.paperSwitch.duration)
            
        }
        
    }
    
    fileprivate func animateLabel(_ label: UILabel, onAnimation: Bool, duration: TimeInterval) {
        UIView.transition(with: label, duration: duration, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            label.textColor = onAnimation ? UIColor.white : MainColorBlue
            self.celsiusLabel.textColor = onAnimation ?  UIColor.white : MainColorBlue
            self.fahrenheitLabel.textColor = onAnimation ? UIColor.white : MainColorBlue
            UserDefaults.standard.set(onAnimation, forKey: "FahrenheiOrCelsius")
        }, completion:nil)
    }
}
