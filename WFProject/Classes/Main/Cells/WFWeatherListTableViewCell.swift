//
//  WFWeatherListTableViewCell.swift
//  WFProject
//
//  Created by hello on 2018/7/17.
//  Copyright © 2018年 WF. All rights reserved.
//

import UIKit
import FoldingCell
import SnapKit

class WFWeatherListTableViewCell: FoldingCell {
    
    var dataModel : WFCityDataModel!
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "cityName"
        label.textColor = MainColorWhite
        label.font = TextFont(size: 17)
        return label
    }()
    
    lazy var tempLabel : UILabel = {
        let label = UILabel()
        label.text = "00℃"
        label.textColor = MainColorWhite
        label.font = TextFont(size: 40)
        return label
    }()
    
    lazy var iconImg : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage.init(named: "")
        return imgView
    }()
    
    lazy var backImg : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage.init(named: "")
        return imgView
    }()
    
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "description"
        label.textColor = MainColorWhite
        label.font = TextFont(size: 17)
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
    
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00 Sunday"
        label.textColor = MainColorGray
        label.font = TextFont(size: 18)
        return label
    }()
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        setupUI()
        super.awakeFromNib()
    }
    
    func setupUI()  {
        foregroundView.addSubview(backImg)
        backImg.snp.makeConstraints { (make) in
            make.edges.equalTo(0);
        }
        
        foregroundView.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.left.equalTo(25)
        }
        
        foregroundView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tempLabel.snp.right).offset(10)
            make.top.equalTo(tempLabel).offset(5)
        }
        
        foregroundView.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tempLabel.snp.right).offset(10)
            make.bottom.equalTo(tempLabel).offset(-5)
        }
        
        foregroundView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tempLabel)
            make.top.equalTo(tempLabel.snp.bottom)
        }
        
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}
