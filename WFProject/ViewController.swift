//
//  ViewController.swift
//  WFProject
//
//  Created by hello on 2018/6/30.
//  Copyright © 2018年 WF. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var jsonString : String = String()
//    var cityNameArr : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.getData()
//        self.getCityData()
//        print(cityNameArr)
    }

    func getData() {
        WFNetWorkTool.shared.GET(urlString: "http://samples.openweathermap.org/data/2.5/forecast?id=524901&appid=b6907d289e10d714a6e88b30761fae22", parameters: nil, showHUD: true, success: {(respone) in
            print(respone as Any)

        }) { (error) in
            
        }
    }
    
//    func getCityData(){
    
//        let path = Bundle.main.path(forResource: "city.list",ofType:"json")
//        let data = NSData(contentsOfFile: path!)
//        self.jsonString = String.init(data: data! as Data, encoding: .utf8)!
//
//        do{
//           let dataArr = try JSONDecoder().decode([CityName].self, from: self.jsonString.data(using: .utf8)!)
//            dataArr.forEach { (item) in
//                self.cityNameArr.append(item.name)
//            }
//        }catch let error {
//            print(error)
//        }
//    }



}

