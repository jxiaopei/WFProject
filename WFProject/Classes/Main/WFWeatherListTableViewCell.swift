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
    
    var dataModel : WFCityDataModel!
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "cityName"
        label.textColor = MainColorBlack
        label.font = TextFont(size: 25)
        return label
    }()
    
    lazy var tempLabel : UILabel = {
        let label = UILabel()
        label.text = "temp"
        label.textColor = MainColorBlack
        label.font = TextFont(size: 18)
        return label
    }()
    
    lazy var iconImg : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage.init(named: "")
        return imgView
    }()
    
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "description"
        label.textColor = MainColorGray
        label.font = TextFont(size: 13)
        return label
    }()
    
    lazy var windLabel : UILabel = {
        let label = UILabel()
        label.text = "wind"
        label.textColor = MainColorGray
        label.font = TextFont(size: 13)
        return label
    }()
    
    lazy var pressureLabel : UILabel = {
        let label = UILabel()
        label.text = "pressure"
        label.textColor = MainColorGray
        label.font = TextFont(size: 13)
        return label
    }()
    
    lazy var humidityLabel : UILabel = {
        let label = UILabel()
        label.text = "humidity"
        label.textColor = MainColorGray
        label.font = TextFont(size: 13)
        return label
    }()
    
    lazy var sunriseLabel : UILabel = {
        let label = UILabel()
        label.text = "humidity"
        label.textColor = MainColorGray
        label.font = TextFont(size: 13)
        return label
    }()
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    func setupUI()  {
        
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}
