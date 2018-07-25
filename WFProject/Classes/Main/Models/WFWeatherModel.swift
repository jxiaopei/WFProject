//
//  WFWeatherDataModel.swift
//  WFProject
//
//  Created by hello on 2018/7/10.
//  Copyright © 2018年 WF. All rights reserved.
//


struct WFWeatherModel : Decodable {
    var city : CityName
    var cnt  : Int
    var cod  : String
    var list : [WFWeatherListDataModel]
    var message : Float
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
    var grnd_level : Float
    var humidity   : Float
    var pressure   : Float
    var sea_level  : Float
    var temp       : Float
    var temp_kf    : Float
    var temp_max   : Float
    var temp_min   : Float
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
    var deg : Float
    var speed : Float
}



