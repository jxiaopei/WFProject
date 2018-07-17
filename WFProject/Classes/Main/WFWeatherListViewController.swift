//
//  WFWeatherListViewController.swift
//  WFProject
//
//  Created by hello on 2018/7/10.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation
import FoldingCell

class WFWeatherListViewController: UITableViewController {
    
    var cityNameArr : [WFWeatherModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getData()
    }
    
    func getData() {
//        WFNetWorkTool.shared.GET(urlString: "http://samples.openweathermap.org/data/2.5/forecast?id=524901&appid=b6907d289e10d714a6e88b30761fae22", parameters: nil, showHUD: true, success: {(respone) in
//            print(respone as Any)
//            do{
////                let dataModel   = try JSONDecoder().decode(WFWeatherModel.self, from: respone as! Data )
////                self.cityNameArr = dataModel.list
////                print(self.cityNameArr)
//            }catch let error {
//                print(error)
//            }
//
//        }) { (error) in
//
//        }
        for _ in 1...10{
            let dataModel = WFWeatherModel.init(cellRowHeight: 93, isClose: true)
            cityNameArr.append(dataModel)
        }
    }
    
    func setupUI()  {
        tableView.estimatedRowHeight = 93
        tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        tableView.mj_header = MJRefreshStateHeader.init(refreshingBlock: {
            
        })
        tableView.mj_footer = MJRefreshAutoStateFooter.init(refreshingBlock: {
            
        })
    }
    
}

extension WFWeatherListViewController {
    
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return cityNameArr.count
    }
    
    override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as WFWeatherListTableViewCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        let dataModel = cityNameArr[indexPath.row]
        
        if dataModel.isClose {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! WFWeatherListTableViewCell
        
        if cell.isAnimating() {
            return
        }

        var duration = 0.0
        var dataModel = cityNameArr[indexPath.row]
        if dataModel.isClose {
            dataModel.isClose = false
            dataModel.cellRowHeight = 260
            cityNameArr[indexPath.row] = dataModel
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            dataModel.isClose = true
            dataModel.cellRowHeight = 93
            cityNameArr[indexPath.row] = dataModel
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }

        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dataModel = cityNameArr[indexPath.row]
        print(dataModel.cellRowHeight)
        return dataModel.cellRowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherListCell", for: indexPath) as! WFWeatherListTableViewCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        cell.dataModel = cityNameArr[indexPath.row]
        return cell
    }
}
