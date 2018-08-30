//
//  WFMenuViewController.swift
//  WFProject
//
//  Created by bi ying on 2018/8/27.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation

class WFMenuViewController : ViewController {
    
    let dataArr : [[String: String]] = [["icon":"icon_clear","title":"Clear cache"],["icon":"icon_about","title":"About Us"]]//["icon":"icon_feedback","title":"Feedback"],
    
    let notificationView  : WFNotificationView = Bundle.main.loadNibNamed("WFNotificationView", owner: self, options: nil)?.first as! WFNotificationView
    
    let COrFSelcetView : WFCelsiusOrFahrenheitView = Bundle.main.loadNibNamed("WFCelsiusOrFahrenheitView", owner: self, options: nil)?.first as! WFCelsiusOrFahrenheitView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        notificationView.layer.masksToBounds = true
        notificationView.layer.cornerRadius = 10
        
        self.view.addSubview(notificationView)
        notificationView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            if(is_iphoneX){
               make.top.equalTo(94) 
            }else{
               make.top.equalTo(74) 
            }
            make.height.equalTo(145)
        }
        notificationView.paperSwitch.setOn(NotificationSetting(), animated: false)
    
        COrFSelcetView.layer.masksToBounds = true
        COrFSelcetView.layer.cornerRadius = 10
        self.view.addSubview(COrFSelcetView)
        COrFSelcetView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(notificationView.snp.bottom).offset(10)
            make.height.equalTo(145)
        }
        COrFSelcetView.paperSwitch.setOn(F_or_C(), animated: false)
        
        for i in 0 ..< dataArr.count {
            let dict = dataArr[i]
            addCellView(title: dict["title"]!, icon:dict["icon"]!, index: i)
        }
    }
    
    func addCellView(title:String, icon:String, index: Int) {
        
        let cell = UIView()
        cell.backgroundColor = UIColor.white
        self.view.addSubview(cell)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10;
        if(is_iphoneX){
            cell.frame = CGRect(x: 10, y: 404 + index * 70, width: Int(ScreenWidth - 20.0), height: 60)
        }else{
            cell.frame = CGRect(x: 10, y: 384 + index * 70, width: Int(ScreenWidth - 20.0), height: 60)
        }
        
        let imgView = UIImageView()
        imgView.image = UIImage(named: icon)
        
        cell.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(cell)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = MainColorBlue
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        cell.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(10)
            make.centerY.equalTo(cell)
        }
        
        let arrowImg = UIImageView()
        arrowImg.image = UIImage(named: "icon_arrow")
        cell.addSubview(arrowImg)
        arrowImg.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.centerY.equalTo(cell)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        let btn = UIButton()
        btn.addTarget(self, action: #selector(didClickBtn(sender:)), for: .touchUpInside)
        cell.addSubview(btn)
        btn.frame = cell.bounds
        btn.tag = index + 100
        
    }
    
    @objc func didClickBtn(sender: UIButton){
        if(sender.tag == 100){
            WFAppManager.Alert(title: "Sure to clear cache?", confirm: "Sure", cancel: "Cancel", confirmActin: { 
                let fileSize = KKCleanCacheManager.folderSizeAtPath()
                KKCleanCacheManager.cleanCache({ 
                   let tip = String(format: "Success to cleaned up %.02fM memory", fileSize) 
                   WFHubTool.hub(view: self.view, text: tip)
                })
            }) {}
        }else if(sender.tag == 101){
            let aboutUsVC = WFAboutUsViewController()
            self.navigationController?.pushViewController(aboutUsVC, animated: true)
            
        }
    }
    
}
