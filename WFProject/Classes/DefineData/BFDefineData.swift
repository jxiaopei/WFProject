//
//  BFDefineData.swift
//  WFProject
//
//  Created by hello on 2018/7/1.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation
import UIKit

public let isTest =  0  //1 是测试 0是正常

public var isSettingLocation = 0 //选择地点

public let defaultsCityIdArr : [String] = ["2643743"]

public let baseURL = "http://api.jinribifenjiekou.com"

public let url = "https://samples.openweathermap.org/data/2.5/weather?id=2172797&appid=b6907d289e10d714a6e88b30761fae22"

public let F_or_C = UserDefaults.standard.bool(forKey: "FahrenheiOrCelsius")

//摄氏度 华氏度转换
func CelsiusOrFahrenheit(degree: CGFloat) -> String{
    if F_or_C  {
        return  String(format: "%.0f",((degree - 273.15) * 9/5 + 32)) + "℉"
    }else{
        return  String(format: "%.0f",degree - 273.15) + "℃"
    }
}

//时间戳转时间字符串
func TimeIntervalToTimeString(timeInterval : Int,formatter: String = "MM-dd HH:mm") -> String{
    let timeSta:TimeInterval = TimeInterval(timeInterval)
    let dfmatter = DateFormatter()
    dfmatter.dateFormat = "MM-dd HH:mm"
    let date = NSDate(timeIntervalSince1970: timeSta)
    return dfmatter.string(from: date as Date)
}

///请求参数
public let APPID_A = "67f311b5e8d4f90345b77fa4111c1e4e"
public let APPID_A_IDENTIFIER = Bundle.main.infoDictionary!["CFBundleIdentifier"]

///appId
public let WFAppId = "8c0e04b52e6da9e67c51a102d6269a60"
/// 屏幕的宽度
public let ScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕的高度
public let ScreenHeight = UIScreen.main.bounds.size.height
/// 屏幕的bounds
public let MainBounds = UIScreen.main.bounds

///判断是否为iPhone
public let is_iphone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
///判断是否为iPhoneX
public let is_iphoneX = is_iphone && ScreenHeight == 812

/// 字体
func TextFont(size:CGFloat) -> UIFont {
    return UIFont.init(name: "PingFangSC-Regular", size: size)!
}

func adjustMeasure(measure: CGFloat) -> CGFloat{
    return measure * ScreenWidth / 375.0
}

public let UMengAppKey = "5ab20dad8f4a9d18c1000199"
public let jPushAppKey = "a3771f6afae83fb7044aace4v"

//颜色
public let MainColorBlue = UIColor.colorWithHexString("568FFE")
public let MainColorBlack = UIColor.black
public let MainColorWhite = UIColor.white
public let MainColorLightGray = UIColor.lightGray
public let MainColorGray = UIColor.gray


