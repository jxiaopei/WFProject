//
//  WFWeatherDailyTableViewCell.swift
//  WFProject
//
//  Created by hello on 2018/8/20.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation

class WFWeatherDailyTableViewCell: UITableViewCell {
    
    var model : WFWeatherListDataModel! {
        didSet{
            self.tempLabel.text = CelsiusOrFahrenheit(degree: CGFloat((model.main?.temp_min)!)) + "~" + CelsiusOrFahrenheit(degree: CGFloat((model.main?.temp_max)!))
            let imgName = WFWeatherImageManager.getWeatherCellBackgroundImage(id: (model.weather?.first?.id)!)
            self.dateLabel.text = TimeIntervalToTimeString(timeInterval: Int((model?.dt!)!))
            self.backImg.setImageToBlur(UIImage.init(named: imgName + "_open"), blurRadius: kLBBlurredImageDefaultBlurRadius, completionBlock: nil)
            self.iconImg.image = UIImage(named: WFWeatherImageManager.getWeatherIcon(id: (model.weather?.first?.id)!, icon: (model.weather?.first?.icon)!))
            self.descriptionLabel.text = model.weather?.first?.description
            self.windLabel.text = String(format: "%.0f", (model.wind?.speed)!)  + "m/s"
            self.humidityLabel.text = String(format: "%.0f", (model.main?.humidity)!) + "%"
            self.pressureLabel.text = String(format: "%.0f", (model.main?.pressure)!) + "hpa"
        }
    }
    
    lazy var tempLabel : UILabel = {
        let label = UILabel()
        label.text = "00℃"
        label.textColor = MainColorWhite
        label.font = TextFont(size: 40)
        return label
    }()
    
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.text = "last update time"
        label.textColor = MainColorWhite
        label.font = TextFont(size: 17)
        return label
    }()
    
    lazy var iconImg : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage.init(named: "sunny")
        return imgView
    }()
    
    lazy var backImg : UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 20
        imgView.layer.masksToBounds = true
        imgView.image = UIImage.init(named: "cell_back_sunny")
        return imgView
    }()
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "description"
        label.textColor = MainColorWhite
        label.font = TextFont(size: 17)
        return label
    }()
    lazy var windIconImg : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage.init(named: "wind")
        return imgView
    }()
    
    lazy var windLabel : UILabel = {
        let label = UILabel()
        label.text = "wind"
        label.textColor = MainColorWhite
        label.font = TextFont(size: 13)
        return label
    }()
    
    lazy var pressureIconImg : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage.init(named: "pressure")
        return imgView
    }()
    
    lazy var pressureLabel : UILabel = {
        let label = UILabel()
        label.text = "pressure"
        label.textColor = MainColorWhite
        label.font = TextFont(size: 13)
        return label
    }()
    
    lazy var humidityIconImg : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage.init(named: "humidity")
        return imgView
    }()
    
    lazy var humidityLabel : UILabel = {
        let label = UILabel()
        label.text = "humidity"
        label.textColor = MainColorWhite
        label.font = TextFont(size: 13)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.clear
        
        let contentView = UIView()
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.right.bottom.equalTo(-10)
        }
        
        contentView.addSubview(backImg)
        backImg.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
        
        contentView.addSubview(iconImg)
        iconImg.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(20)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImg.snp.right).offset(10)
            make.centerY.equalTo(iconImg).offset(13)
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImg.snp.right).offset(10)
            make.centerY.equalTo(iconImg).offset(-13)
        }
        
        contentView.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(iconImg.snp.bottom).offset(10)
        }
        
        contentView.addSubview(windIconImg)
        windIconImg.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(tempLabel.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        contentView.addSubview(windLabel)
        windLabel.snp.makeConstraints { (make) in
            make.left.equalTo(windIconImg.snp.right).offset(10)
            make.centerY.equalTo(windIconImg)
        }
        
        contentView.addSubview(pressureIconImg)
        pressureIconImg.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(windIconImg.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        contentView.addSubview(pressureLabel)
        pressureLabel.snp.makeConstraints { (make) in
            make.left.equalTo(pressureIconImg.snp.right).offset(10)
            make.centerY.equalTo(pressureIconImg)
        }
        
        contentView.addSubview(humidityIconImg)
        humidityIconImg.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(pressureIconImg.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        contentView.addSubview(humidityLabel)
        humidityLabel.snp.makeConstraints { (make) in
            make.left.equalTo(humidityIconImg.snp.right).offset(10)
            make.centerY.equalTo(humidityIconImg)
        }
        
    }
}
