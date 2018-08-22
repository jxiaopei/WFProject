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
    
    var cityNameArr : [WFCityDataModel] = []
    let closeCellHeight: CGFloat = adjustMeasure(measure: 147.5)
    let openCellHeight: CGFloat = adjustMeasure(measure: 380)
    var sevenDayWeatherArr : [WFSevenDaysWeatherModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupNavigationItem()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    func setupNavigationItem() {
        let rightBtn = UIButton(type: .custom)
        rightBtn.setImage(UIImage(named: "add_city"), for: .normal)
        rightBtn.setTitleColor(MainColorWhite, for: .normal)
        rightBtn.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
   
    @objc func rightBtnClick() {
        let searchVC = WFSearchViewController.init()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    
    
    func getData() {
        
        var cityId = ""
        if let data = UserDefaults.standard.object(forKey: "cityId"){
            if(data is NSNull){
                cityId = "2643743"
                UserDefaults.standard.set(cityId, forKey: "cityId")
            }else{
                print(data)
                cityId = data as! String
            }
        }
        
        if (cityId.isEmpty){
            cityId = "2643743"
            UserDefaults.standard.set(cityId, forKey: "cityId")
        }
        
        let parameters = ["APPID" : WFAppId] as [String : Any]
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WFNetWorkTool.shared.GET(urlString: ("http://api.openweathermap.org/data/2.5/group?units=metric&id=" + cityId) , parameters: parameters, showHUD: true, success: {(respone) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tableView.mj_header.endRefreshing()
            let dict = respone as! [String : Any]
            let data = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
           
            do{
                let model = try JSONDecoder().decode(WFCityListDataModel.self,  from: data)
                self.cityNameArr.removeAll()
                for dataModel in (model as WFCityListDataModel).list! {
                    let cityModel = WFCityDataModel.init(cellRowHeight: self.closeCellHeight, isClose: true, dataModel: dataModel)
                    self.cityNameArr.append(cityModel)
                }
                
                self.tableView.reloadData()
            }catch let error {
                print(error)
                self.tableView.mj_header.endRefreshing()
            }

        }) { (error) in
            self.tableView.mj_header.endRefreshing()
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func getSevenDaysWeather(success: (([WFSevenDaysWeatherModel]?)->Void)?) {
        let parameters = ["q" : "Beijing","APPID" : WFAppId,"units" : "metric","cnt" : 7] as [String : Any]
        WFNetWorkTool.shared.GET(urlString: "https://api.openweathermap.org/data/2.5/forecast/daily", parameters: parameters, showHUD: true, success: {(respone) in
            let dict = respone as! [String : Any]
            let data = try! JSONSerialization.data(withJSONObject: dict["list"]!, options: .prettyPrinted)
            do{
                let weatherDataArr = try JSONDecoder().decode([WFSevenDaysWeatherModel].self,  from: data)
                self.sevenDayWeatherArr.removeAll()
                self.sevenDayWeatherArr.append(contentsOf: weatherDataArr)
            }catch let error {
                print(error)
            }
            
        }) { (error) in
            
        }
    }
    
    func setupUI()  {
        tableView.estimatedRowHeight = closeCellHeight
        tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        tableView.mj_header = MJRefreshStateHeader.init(refreshingBlock: {
            self.getData()
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
        
        self.getSevenDaysWeather { (respon) in
            
        }
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        var dataModel = cityNameArr[indexPath.row]
        if dataModel.isClose {
            dataModel.isClose = false
            dataModel.cellRowHeight = openCellHeight
            cityNameArr[indexPath.row] = dataModel
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            dataModel.isClose = true
            dataModel.cellRowHeight = closeCellHeight
            cityNameArr[indexPath.row] = dataModel
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }

        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
        cell.btnClickBlock = {(cityName) in
            let dailyVC = WFWeatherDailyViewController()
            dailyVC.cityName = cityName
            self.navigationController?.pushViewController(dailyVC, animated: true)
        }
    }
    
    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dataModel = cityNameArr[indexPath.row]
        return dataModel.cellRowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherListCell", for: indexPath) as! WFWeatherListTableViewCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        cell.model = cityNameArr[indexPath.row]
        return cell
    }
}
