//
//  WFWeatherDataModel.swift
//  WFProject
//
//  Created by hello on 2018/7/10.
//  Copyright © 2018年 WF. All rights reserved.
//


struct WFWeatherModel : Decodable {
//    var city : String
//    var cnt  : Int
//    var cod  : Int
//    var list : String
//    var message : String
    var cellRowHeight :CGFloat
    var isClose : Bool {
        didSet(isClose){
//            self.isClose = isClose
            self.cellRowHeight = isClose ? 93 : 260
        }
    }
}

struct WFWeatherListDataModel : Decodable {
    var clouds : WFWeatherCloudsModel
    var dt : Int32
    var dt_txt : String
    var main : WFWeatherMianModel
    var weather : [WFWeatherDataModel]
    var wind : WFWeatherWindModel
    var snow : WFWeatherSnowModel
    var sys : WFWeatherSysModel
}

struct WFWeatherCloudsModel : Decodable{
    var all : Int
}

struct WFWeatherMianModel : Decodable{
    var grnd_level : String
    var humidity   : Int
    var pressure   : String
    var sea_level  : String
    var temp       : String
    var temp_kf    : String
    var temp_max   : String
    var temp_min   : String
}

struct WFWeatherSnowModel : Decodable{
    
}

struct WFWeatherSysModel : Decodable{
    var pod : String
}

struct WFWeatherDataModel : Decodable {
    var description : String
    var icon : String
    var id : Int
    var main : String
}

struct WFWeatherWindModel : Decodable {
    var deg : String
    var speed : String
}


