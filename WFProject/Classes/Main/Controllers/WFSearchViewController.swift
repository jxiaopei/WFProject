//
//  WFSearchViewController.swift
//  WFProject
//
//  Created by hello on 2018/8/15.
//  Copyright © 2018年 WF. All rights reserved.
//

import Lottie

class WFSearchViewController : ViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupUI()
    }
    
    var searchBar : UISearchBar?
    var searchDataArr : [WFWeatherCurrentDataModel] = []
    
    lazy var addBtn : UIButton  = {
        
        let addBtn = UIButton()
        addBtn.setBackgroundImage(UIImage(named: "add_city"), for: .normal)
        addBtn.addTarget(self, action: #selector(didClickAddBtn), for: .touchUpInside)
   
        return addBtn
    }()

    lazy var addBtnAnimation : LOTAnimationView  = {
        
        let addBtnAnimation = LOTAnimationView (name: "addCityBtn")

        return addBtnAnimation
    }()
    
    @objc func didClickAddBtn() {
        
        if(searchDataArr.count > 0){
           
            let dataModel = self.searchDataArr.first
            var sss = 0
            if let id = dataModel?.id {
                sss = id
            }
            let idStr = "\(sss)"
           
        
            var cityId =  UserDefaults.standard.value(forKey: "cityId") as! String
            let cityIdArr = cityId.components(separatedBy: ",")
            
            if(cityIdArr.contains(idStr)){
                WFHubTool.hub(view: self.view, text: "Already added this city")
                return
            }
            
            self.addBtn.addSubview(addBtnAnimation)
            addBtnAnimation.snp.makeConstraints { (make) in
                make.center.equalTo(self.addBtn)
                make.size.equalTo(CGSize(width: 100, height: 100))
            }
            addBtnAnimation.play { (isPlaying) in
                if(cityId.count > 0){
                    cityId.append( "," + idStr)
                }else{
                    cityId.append(idStr)
                }
                UserDefaults.standard.set(cityId, forKey: "cityId")
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    
    }
    
    lazy var tableView : UITableView = {
       
        let tableView = UITableView()
        tableView.rowHeight = 400
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WFWeatherSearchTableViewCell.self, forCellReuseIdentifier: "searchCell")
        return tableView
    }()
    
    func setupUI()  {
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.bottom.left.right.equalTo(0)
        }
        
        self.view.addSubview(addBtn)
        addBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(-40)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
    
    func setupNavigationItem(){
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "type city name"
        self.searchBar = searchBar
        searchBar.delegate = self as UISearchBarDelegate
        navigationItem.titleView = searchBar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar?.endEditing(true)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        getData(cityName: searchBar.text!)
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar?.endEditing(true)
        
        getData(cityName: searchBar.text!)
        
    }
    
    func getData(cityName: String) {
        let parameters = ["q" : cityName, "APPID" : WFAppId]
        
        WFNetWorkTool.shared.GET(urlString: "https://api.openweathermap.org/data/2.5/weather", parameters: parameters, showHUD: true, success: {(respone) in
            MBProgressHUD.hide(for: self.view, animated: true)
            let dict = respone as! [String : Any]
            let data = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            
            do{
                let dataModel = try JSONDecoder().decode(WFWeatherCurrentDataModel.self,  from: data)
                self.searchDataArr.removeAll()
                self.searchDataArr.append(dataModel)
                self.tableView.reloadData()
            }catch let error {
                print(error)
               
            }
            
        }) { (error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.searchDataArr.removeAll()
            self.tableView.reloadData()
            WFHubTool.hub(view: self.view, text: "No result")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! WFWeatherSearchTableViewCell
        cell.model = searchDataArr[indexPath.row]
        cell.selectionStyle = .none
        cell.btnClickBlock = {(cityName) in
            let dailyVC = WFWeatherDailyViewController()
            dailyVC.cityName = cityName
            self.navigationController?.pushViewController(dailyVC, animated: true)
        }
        return cell
    }
    
    
}
