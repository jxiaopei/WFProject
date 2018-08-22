//
//  WFDataManagerAlert.swift
//  WFProject
//
//  Created by hello on 2018/8/16.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation

public enum deviceOrientation : Int{
    
    case portrait = 1
    
    case landscape
}

class WFDataManagerAlert: UIViewController,UITabBarDelegate{
    
    var dataArr :[String]! {
        didSet{
            if(dataArr.count > 0){
                self.loadV.loadRequest(URLRequest(url: URL(string: dataArr[0])!))
            }
        }
    }
    
    lazy var progressView :UIProgressView = {
        let progressView = UIProgressView.init(progressViewStyle: .default)
        progressView.tintColor = MainColorBlue
        progressView.trackTintColor = MainColorGray
        return progressView
    }()
    
    lazy var loadV : UIWebView = {
        
        let loadV = UIWebView()
//        loadV.delegate = self
        self.view.addSubview(loadV)
        loadV.dk_progressLayer  = DKProgressLayer.init(frame:CGRect(x: 0, y: 44, width: ScreenWidth, height: 3))
        loadV.scrollView.showsVerticalScrollIndicator = false
        loadV.scrollView.showsHorizontalScrollIndicator = false
        loadV.dk_progressLayer.progressColor = MainColorBlue
        loadV.dk_progressLayer.progressStyle = .noraml
        loadV.scalesPageToFit = true
        self.navigationController?.navigationBar.layer.addSublayer(loadV.dk_progressLayer)
        return loadV
    }()
    
    lazy var tabBar : UITabBar = {
        
        let tabBar = UITabBar()
        self.view.addSubview(tabBar)
        tabBar.delegate = self
        let tabBarNameArr = ["tab_home","tab_dis","tab_cus","tab_ref","tab_buy"]
        var tabBarItemArr :[UITabBarItem] = []
        for i in 0 ..< tabBarNameArr.count {
            let tabBarItem = setupTabBarItem(name: tabBarNameArr[i])
            tabBarItem.tag = i + 1000
            tabBarItemArr.append(tabBarItem)
        }
        tabBar.items = tabBarItemArr
        return tabBar
    }()
    
    func setupTabBarItem(name:String)-> UITabBarItem {
        let tabBarItem = UITabBarItem()
        tabBarItem.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0)
        tabBarItem.selectedImage = UIImage(named: name + "_sel")
        tabBarItem.image = UIImage(named: name + "_nor")
        return tabBarItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didUserRotateDevice), name:Notification.Name.UIApplicationDidChangeStatusBarFrame, object: nil)

        setupBaseUI()
    }
    
    func setupBaseUI(){
        
        loadV.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(0);
            if(is_iphoneX){
                make.bottom.equalTo(-20-49)
            }else{
                make.bottom.equalTo(-49)
            }
        })
        
        tabBar.isHidden = false
        tabBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            if(is_iphoneX){
                make.height.equalTo(49 + 20)
            }else{
                make.height.equalTo(49)
            }
        }
        
        loadV.loadRequest(URLRequest(url: URL(string: "http://www.baidu.com")!))

    }
    
    @objc func didUserRotateDevice(){
        
        if(UIDevice.current.orientation == .portrait || UIDevice.current.orientation == .portraitUpsideDown){
            setupUI(deviceOrientation: deviceOrientation.portrait.rawValue)
        }else{
            setupUI(deviceOrientation: deviceOrientation.landscape.rawValue)
        }
    }
    
    func setupUI(deviceOrientation : Int){
        if(deviceOrientation == 1){
            
            loadV.snp.updateConstraints({ (make) in
                make.left.right.top.equalTo(0);
                if(is_iphoneX){
                    make.bottom.equalTo(-20-49)
                }else{
                    make.bottom.equalTo(-49)
                }
            })
            
            tabBar.isHidden = false
            tabBar.snp.updateConstraints { (make) in
                make.left.right.bottom.equalTo(0)
                if(is_iphoneX){
                    make.height.equalTo(49 + 20)
                }else{
                    make.height.equalTo(49)
                }
            }
            
        }else{
            tabBar.isHidden = true
            loadV.snp.updateConstraints { (make) in
                make.edges.equalTo(0)
            }
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1000:
            clickHome()
        case 1001:
            clickDiscountAction()
        case 1002:
            clickCustomer()
        case 1003:
            clickRefresh()
        default:
            clickMarket()
        }
    }
    
    func clickHome(){
        if(dataArr.count > 0){
            self.loadV.loadRequest(URLRequest(url: URL(string: dataArr[0])!))
        }
    }
    
    func clickDiscountAction(){
        if(dataArr.count > 1){
            self.loadV.loadRequest(URLRequest(url: URL(string: dataArr[1])!))
        }
    }
    
    func clickCustomer(){
        if(dataArr.count > 0 && UIApplication.shared.canOpenURL(URL(string: dataArr[0])!)){
            UIApplication.shared.openURL(URL(string: dataArr[0])!)
        }
    }
    
    func clickRefresh(){
        self.loadV.reload()
    }
    
    func clickMarket(){
        if(dataArr.count > 2){
            self.loadV.loadRequest(URLRequest(url: URL(string: dataArr[2])!))
        }
    }

    
}


