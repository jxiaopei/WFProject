//
//  WFWeatherListTableViewCell.swift
//  WFProject
//
//  Created by hello on 2018/7/17.
//  Copyright © 2018年 WF. All rights reserved.
//

import UIKit
import FoldingCell

class WFWeatherListTableViewCell: FoldingCell {
    
    var dataModel : WFWeatherModel!
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}
