//
//  WFWeatherSearchTableViewCell.swift
//  WFProject
//
//  Created by hello on 2018/8/15.
//  Copyright © 2018年 WF. All rights reserved.
//

class WFWeatherSearchTableViewCell : UITableViewCell{
    
    var btnClickBlock:((_ cityName: String)->())?
    
    var model : WFWeatherCurrentDataModel! {
        didSet{
            let imgName = WFWeatherImageManager.getWeatherCellBackgroundImage(id: (model?.weather?.first?.id)!)
            self.backImg.setImageToBlur(UIImage.init(named: imgName + "_open"), blurRadius: kLBBlurredImageDefaultBlurRadius, completionBlock: nil)
            self.tempLabel.text = CelsiusOrFahrenheit(degree: (model?.main?.temp)!)
            self.descriptionLabel.text = model?.weather?.first?.description
            self.cityLabel.text = model?.name
            self.dateLabel.text = "last update time : " + TimeIntervalToTimeString(timeInterval: (model?.dt!)!)
            self.iconImg.image = UIImage(named: WFWeatherImageManager.getWeatherIcon(id: (model?.weather?.first?.id)!, icon: (model?.weather?.first?.icon)!))
            self.windLabel.text = String(format: "%.0f", (model?.wind?.speed)!)  + "m/s"
            self.pressureLabel.text = String(format: "%.0f", (model?.main?.pressure)!) + "hpa"
            self.humidityLabel.text = String(format: "%.0f", (model?.main?.humidity)!) + "%"
            self.sunsetLabel.text = "sunset : " + TimeIntervalToTimeString(timeInterval: (model?.sys?.sunset)!, formatter: "HH:mm")
            self.sunriseLabel.text = "sunrise : " + TimeIntervalToTimeString(timeInterval: (model?.sys?.sunrise)!, formatter: "HH:mm")

        }
    }
    
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
        imgView.image = UIImage.init(named: "sunny")
        return imgView
    }()
    
    lazy var backImg : UIImageView = {
        let imgView = UIImageView() 
        imgView.layer.cornerRadius = 20
        imgView.layer.masksToBounds = true
        imgView.setImageToBlur(UIImage.init(named: "cell_back_sunny_open"), blurRadius: kLBBlurredImageDefaultBlurRadius, completionBlock: nil)
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
    
    lazy var sunIconImg : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage.init(named: "sunny")
        return imgView
    }()
    
    lazy var sunriseLabel : UILabel = {
        let label = UILabel()
        label.text = "sunrise"
        label.textColor = MainColorWhite
        label.font = TextFont(size: 13)
        return label
    }()
    
    lazy var sunsetLabel : UILabel = {
        let label = UILabel()
        label.text = "sunset"
        label.textColor = MainColorWhite
        label.font = TextFont(size: 13)
        return label
    }()
    
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.text = "last update time"
        label.textColor = MainColorWhite
        label.font = TextFont(size: 18)
        return label
    }()
    
    lazy var detailBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("Show More...", for: .normal)
        btn.setTitleColor(MainColorWhite, for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action:#selector(didClickDetailBtn) , for: .touchUpInside)
        return btn
    }()
    
    @objc func didClickDetailBtn() {
        if(btnClickBlock != nil){
            btnClickBlock!((model.name)!)
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI()  {
        
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
        
        contentView.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(20)
        }
        
        contentView.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(cityLabel.snp.bottom).offset(5)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(tempLabel.snp.bottom).offset(5)
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
        }
        
        contentView.addSubview(iconImg)
        iconImg.snp.makeConstraints { (make) in
            make.left.equalTo(tempLabel.snp.right).offset(20)
            make.centerY.equalTo(tempLabel)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        contentView.addSubview(sunIconImg)
        sunIconImg.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        contentView.addSubview(sunriseLabel)
        sunriseLabel.snp.makeConstraints { (make) in
            make.left.equalTo(sunIconImg.snp.right).offset(10)
            make.centerY.equalTo(sunIconImg)
        }
        
        contentView.addSubview(sunsetLabel)
        sunsetLabel.snp.makeConstraints { (make) in
            make.left.equalTo(sunriseLabel.snp.right).offset(10)
            make.centerY.equalTo(sunIconImg)
        }
        
        contentView.addSubview(windIconImg)
        windIconImg.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(sunIconImg.snp.bottom).offset(10)
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
            make.top.equalTo(windIconImg.snp.bottom).offset(10)
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
            make.top.equalTo(pressureIconImg.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        contentView.addSubview(humidityLabel)
        humidityLabel.snp.makeConstraints { (make) in
            make.left.equalTo(humidityIconImg.snp.right).offset(10)
            make.centerY.equalTo(humidityIconImg)
        }
        
        contentView.addSubview(detailBtn)
        detailBtn.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.bottom.equalTo(-10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
    }
}
