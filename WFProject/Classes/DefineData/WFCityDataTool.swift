//
//  WFCityDataTool.swift
//  WFProject
//
//  Created by hello on 2018/7/10.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation
import RAMReel

class WFCityDataTool: NSObject {
    
    var jsonString : String = String()
    var cityNameArr : [String] = []
    
    static let shared: WFCityDataTool = {
        return WFCityDataTool()
    }()
    
}

extension WFCityDataTool {
    
   func getCityData(){

        DispatchQueue.global().async {
            
            var dataTempArr : [[String]] = [[],[],[],[],[],[],[],[],[],[],[]]
            let group = DispatchGroup()
            for index in 0...10{
                let fileName = "city.list" + "\(index)"
                print(fileName,Date())
                let path = Bundle.main.path(forResource: fileName,ofType:"json")
                let data = NSData(contentsOfFile: path!)
//                self.jsonString = String.init(data: data! as Data, encoding: .utf8)!
                do{
                    let dataArr = try JSONDecoder().decode([CityName].self, from: data! as Data)
                    if(dataArr.count > 0){
                        var dataArray: [String] = []
                        group.enter()
                        DispatchQueue.global().async {
                            dataArr.forEach { (item) in
                                dataArray.append(item.name)
                            }
                            
                            dataTempArr[index] = dataArray
                            print("request"+"\(index)"+"complete")
                            group.leave()
                        }
                    }
                }catch let error {
                    print(error)
                }
            }
            
            group.notify(queue: DispatchQueue.main) {
                print("all requests come back")
                
                for indexNum in 0...10{
                    self.cityNameArr.append(contentsOf: dataTempArr[indexNum])
                }
                print(Date())
                NotificationCenter.default.post(name: Notification.Name(rawValue: "GetCityNames"), object: nil)
            }
        }
    }
}
