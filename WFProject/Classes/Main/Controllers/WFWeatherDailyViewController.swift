//
//  WFWeatherDailyViewController.swift
//  WFProject
//
//  Created by hello on 2018/8/20.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation


class WFWeatherDailyViewController: ViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var dataModel : WFWeatherModel?
    var cityName : String?
    var dataArr :[WFWeatherListDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "weather in hours"
        setupUI()
        getData()
    }
    
    lazy var tableView : UITableView = {
        
        let tableView = UITableView()
        tableView.rowHeight = 300
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WFWeatherDailyTableViewCell.self, forCellReuseIdentifier: "dailyCell")
        return tableView
    }()
    
    func setupUI()  {
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.bottom.left.right.equalTo(0)
        }
    }
    
    func getData(){
        let parameters = ["q" : cityName!, "APPID" : WFAppId]
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WFNetWorkTool.shared.GET(urlString: "https://api.openweathermap.org/data/2.5/forecast", parameters: parameters, showHUD: true, success: {(respone) in
             MBProgressHUD.hide(for: self.view, animated: true)
            let dict = respone as! [String : Any]
            let data = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            
            do{
                let dataModel = try JSONDecoder().decode(WFWeatherModel.self,  from: data)
                self.dataModel = dataModel
                self.dataArr = dataModel.list!
                self.tableView.reloadData()
            }catch let error {
                print(error)
            }
            
        }) { (error) in
             MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell", for: indexPath) as! WFWeatherDailyTableViewCell
        cell.model = dataArr[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
}
