//
//  MainViewController.swift
//  WFProject
//
//  Created by hello on 2018/7/1.
//  Copyright © 2018年 WF. All rights reserved.
//

import UIKit
import RAMReel

class MainViewController: UIViewController ,UICollectionViewDelegate,UITextFieldDelegate {
    
    var jsonString : String = String()
    var cityNameArr : [String] = []
    
    var dataSource: SimplePrefixQueryDataSource!
    var ramReel: RAMReel<RAMCell, RAMTextField, SimplePrefixQueryDataSource>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(getCityData), name: Notification.Name(rawValue: "GetCityNames"), object: nil)
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.cityNameArr = WFCityDataTool.shared.cityNameArr
        if(self.cityNameArr.count > 0){
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        
        dataSource = SimplePrefixQueryDataSource(cityNameArr)

        ramReel = RAMReel<RAMCell, RAMTextField, SimplePrefixQueryDataSource>(frame: view.bounds, dataSource: dataSource, placeholder: "City Name", hook: nil)

        ramReel.hooks.append {
            let r = Array($0.reversed())
            let j = String(r)
            print("Reversed:", j)
        }
    
        ramReel.textFieldDelegate = self
        view.addSubview(ramReel.view)
        ramReel.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        print(Date())
        
    }
    
    @objc func getCityData(){
    
        self.cityNameArr = WFCityDataTool.shared.cityNameArr
        MBProgressHUD.hide(for: self.view, animated: true)
        self.ramReel.view.removeFromSuperview()
        self.ramReel = nil;
        self.dataSource = SimplePrefixQueryDataSource(self.cityNameArr)
        self.ramReel = RAMReel<RAMCell, RAMTextField, SimplePrefixQueryDataSource>(frame: self.view.bounds, dataSource: self.self.dataSource, placeholder: "City Name", hook: nil)
        self.ramReel.hooks.append {
            let r = Array($0.reversed())
            let j = String(r)
            print("Reversed:", j)
        }
        self.ramReel.textFieldDelegate = self
        self.view.addSubview(self.ramReel.view)
        self.ramReel.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        print(Date())

    }
}

extension MainViewController{
    // 输入框按下键盘 return 收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("text=="+textField.text! as Any)
        return true
    }

}
