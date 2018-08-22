//
//  WFCityDataModel.swift
//  WFProject
//
//  Created by hello on 2018/7/10.
//  Copyright © 2018年 WF. All rights reserved.
//

struct WFCityDataModel{
    var cellRowHeight :CGFloat
    var isClose : Bool
    var dataModel : WFWeatherCurrentDataModel?
}

struct WFCityListDataModel :Decodable{
    var cnt : Int?
    var list : [WFWeatherCurrentDataModel]?
}

struct WFWeatherCurrentDataModel :Decodable{
    var coord : CityCoord?
    var weather : [WFWeatherDataModel]?
    var base : String?
    var main : WFWeatherCurrentMianModel?
    var visibility : Int?
    var wind : WFWeatherWindModel?
    var clouds : WFWeatherCloudsModel?
    var dt : Int?
    var sys : WFWeatherCurrentSysModel?
    var id : Int?
    var name : String?
    var cod : Int?
}

struct WFWeatherCurrentSysModel : Decodable{
    var type : Int
    var id : Int
    var message : Float
    var country : String
    var sunrise : Int
    var sunset  : Int
}

struct WFWeatherCurrentMianModel : Decodable{
    var humidity   : Float
    var pressure   : Float
    var temp       : Float
    var temp_max   : Float
    var temp_min   : Float
}

struct CityName : Decodable {
    
    var id : Int32
    var name : String
    var country : String
    var coord : CityCoord
}

struct CityCoord : Decodable{
    var lon : Float
    var lat : Float
}

