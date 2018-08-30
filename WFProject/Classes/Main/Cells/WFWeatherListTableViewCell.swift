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

class WFWeatherListTableViewCell: FoldingCell,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var btnClickBlock:((_ cityName: String)->())?
    var delBtnClickBlock:(()->())?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sevenDayWeatherArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sevenDayCollectionViewCell", for: indexPath) as! WFSevenDayWeatherCollectionViewCell
        return cell
    }
    
    var sevenDayWeatherArr : [WFSevenDaysWeatherModel] = []
    
    var model : WFCityDataModel! {
        didSet{
            let imgName = WFWeatherImageManager.getWeatherCellBackgroundImage(id: (model.dataModel?.weather?.first?.id)!)
            self.backImg.image = UIImage(named: imgName)
//            self.backImg1.image = UIImage(named: imgName + "_open")
            self.backImg1.setImageToBlur(UIImage.init(named: imgName + "_open"), blurRadius: kLBBlurredImageDefaultBlurRadius, completionBlock: nil)
            self.tempLabel.text =  MainViewCelsiusOrFahrenheit(degree: (model.dataModel?.main?.temp)!)
            self.tempLabel1.text = MainViewCelsiusOrFahrenheit(degree: (model.dataModel?.main?.temp)!)
            self.descriptionLabel.text = model.dataModel?.weather?.first?.description
            self.descriptionLabel1.text = model.dataModel?.weather?.first?.description
            self.cityLabel.text = model.dataModel?.name
            self.cityLabel1.text = model.dataModel?.name
            self.dateLabel.text = "last update time : " + TimeIntervalToTimeString(timeInterval: (model.dataModel?.dt!)!)
            self.dateLabel1.text = "last update time : " + TimeIntervalToTimeString(timeInterval: (model.dataModel?.dt!)!)
            self.iconImg.image = UIImage(named: WFWeatherImageManager.getWeatherIcon(id: (model.dataModel?.weather?.first?.id)!, icon: (model.dataModel?.weather?.first?.icon)!))
            self.windLabel.text = String(format: "%.0f", (model.dataModel?.wind?.speed)!)  + "m/s"
            self.pressureLabel.text = String(format: "%.0f", (model.dataModel?.main?.pressure)!) + "hpa"
            self.humidityLabel.text = String(format: "%.0f", (model.dataModel?.main?.humidity)!) + "%"
            self.sunsetLabel.text = "sunset : " + TimeIntervalToTimeString(timeInterval: (model.dataModel?.sys?.sunset)!, formatter: "HH:mm")
            self.sunriseLabel.text = "sunrise : " + TimeIntervalToTimeString(timeInterval: (model.dataModel?.sys?.sunrise)!, formatter: "HH:mm")
        }
    }
    
    lazy var sevenDayCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 80.0)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth-40, height: 80), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(WFSevenDayWeatherCollectionViewCell.self, forCellWithReuseIdentifier: "sevenDayCollectionViewCell")
        return collectionView
    }()
    
    
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "cityName"
        label.textColor = MainColorWhite
        label.font = TextFont(size: 17)
        return label
    }()
    
    lazy var cityLabel1: UILabel = {
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
    
    lazy var tempLabel1 : UILabel = {
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
        imgView.image = UIImage.init(named: "cell_back_sunny")
        return imgView
    }()
    
    lazy var backImg1 : UIImageView = {
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
    
    lazy var descriptionLabel1 : UILabel = {
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
        label.textColor = MainColorGray
        label.font = TextFont(size: 18)
        return label
    }()
    
    lazy var dateLabel1 : UILabel = {
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
    
    lazy var deleteBtn : UIButton = {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: "del_city"), for: .normal)
        btn.addTarget(self, action: #selector(didClickDeleteBtn), for: .touchUpInside)
        return btn
    }()
    
    @objc func didClickDetailBtn() {
        if(btnClickBlock != nil){
            btnClickBlock!((model.dataModel?.name)!)
        }
    }

    @objc func didClickDeleteBtn(){
        if(delBtnClickBlock != nil){
            delBtnClickBlock!()
        }
    }    

    override func awakeFromNib() {
        setupUI()
        super.awakeFromNib()
    }
    
    func setupUI()  {
        
        self.backViewColor = UIColor.lightGray
        //关闭cell
        foregroundView.addSubview(backImg)
        backImg.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
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
        
        //展开cell
        containerView.addSubview(backImg1)
        backImg1.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
        
        containerView.addSubview(cityLabel1)
        cityLabel1.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(20)
        }
        
        containerView.addSubview(tempLabel1)
        tempLabel1.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(cityLabel1.snp.bottom).offset(5)
        }
        
        containerView.addSubview(descriptionLabel1)
        descriptionLabel1.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(tempLabel1.snp.bottom).offset(5)
        }
        
        containerView.addSubview(dateLabel1)
        dateLabel1.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(descriptionLabel1.snp.bottom).offset(10)
        }
        
        containerView.addSubview(iconImg)
        iconImg.snp.makeConstraints { (make) in
            make.left.equalTo(tempLabel1.snp.right).offset(20)
            make.centerY.equalTo(tempLabel1)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        containerView.addSubview(sunIconImg)
        sunIconImg.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(dateLabel1.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        containerView.addSubview(sunriseLabel)
        sunriseLabel.snp.makeConstraints { (make) in
            make.left.equalTo(sunIconImg.snp.right).offset(10)
            make.centerY.equalTo(sunIconImg)
        }
        
        containerView.addSubview(sunsetLabel)
        sunsetLabel.snp.makeConstraints { (make) in
            make.left.equalTo(sunriseLabel.snp.right).offset(10)
            make.centerY.equalTo(sunIconImg)
        }
        
        containerView.addSubview(windIconImg)
        windIconImg.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(sunIconImg.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        containerView.addSubview(windLabel)
        windLabel.snp.makeConstraints { (make) in
            make.left.equalTo(windIconImg.snp.right).offset(10)
            make.centerY.equalTo(windIconImg)
        }
        
        containerView.addSubview(pressureIconImg)
        pressureIconImg.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(windIconImg.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        containerView.addSubview(pressureLabel)
        pressureLabel.snp.makeConstraints { (make) in
            make.left.equalTo(pressureIconImg.snp.right).offset(10)
            make.centerY.equalTo(pressureIconImg)
        }
        
        containerView.addSubview(humidityIconImg)
        humidityIconImg.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(pressureIconImg.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        containerView.addSubview(humidityLabel)
        humidityLabel.snp.makeConstraints { (make) in
            make.left.equalTo(humidityIconImg.snp.right).offset(10)
            make.centerY.equalTo(humidityIconImg)
        }
        
        containerView.addSubview(detailBtn)
        detailBtn.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.bottom.equalTo(-20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        containerView.addSubview(deleteBtn)
        deleteBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(20)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}
