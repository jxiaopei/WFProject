//
//  WFSevenDaysWeatherModel.swift
//  WFProject
//
//  Created by hello on 2018/8/15.
//  Copyright © 2018年 WF. All rights reserved.
//

struct WFSevenDaysWeatherModel : Decodable {
    
    var dt : Int16?
    var temp : WFSevenDaysWeatherDataModel?
    var pressure :Float?
    var humidity : Float?
    var weather: WFWeatherDataModel?
    var speed : Float?
    var deg : Float?
    var clouds : Float?
}

struct WFSevenDaysWeatherDataModel : Decodable {
    var day: Float?
    var min : Float?
    var max : Float?
    var night : Float?
    var eve : Float?
    var morn : Float?
}
