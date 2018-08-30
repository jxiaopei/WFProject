//
//  WFAboutUsViewController.swift
//  WFProject
//
//  Created by bi ying on 2018/8/28.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation

class WFAboutUsViewController : ViewController {
    
    lazy var imgView : UIImageView = {
        
        let imgView = UIImageView()
        let infoDict = Bundle.main.infoDictionary
        let bundleIcon = infoDict!["CFBundleIcons"] as! [String : Any]
        let primaryIcon = bundleIcon["CFBundlePrimaryIcon"] as! [String : Any]
        let iconArr = primaryIcon["CFBundleIconFiles"] as! [String]
        imgView.image = UIImage(named: iconArr.last!)
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 10
        return imgView
    }()
    
    lazy var versionLabel : UILabel = {
        
        let label = UILabel()
        let infoDict = Bundle.main.infoDictionary
        let app_bundleversion = infoDict!["CFBundleVersion"] as! String
        let app_version = infoDict!["CFBundleShortVersionString"] as! String
        label.text = "V" + app_version
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        return label
        
    }()
    
    lazy var detailLabel : UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.text = "Latest data of the city weather ,wind,humidity, and air pressure prediction,you also can search the city you like,and add to your favorite list"
        label.numberOfLines = 3
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        
        setupUI()
        
    }
    
    func setupUI(){
        
        self.view.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(124)
            make.centerX.equalTo(self.view)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        self.view.addSubview(versionLabel)
        versionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(10)
            make.centerX.equalTo(self.view)
        }
        
        self.view.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(versionLabel.snp.bottom).offset(15)
        }
        
    }
    
}
