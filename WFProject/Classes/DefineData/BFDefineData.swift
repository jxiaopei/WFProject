//
//  BFDefineData.swift
//  WFProject
//
//  Created by hello on 2018/7/1.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation
import UIKit

public let baseURL = "http://api.jinribifenjiekou.com"

///appId
public let WFAppId = "b6907d289e10d714a6e88b30761fae22"
/// 屏幕的宽度
public let ScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕的高度
public let ScreenHeight = UIScreen.main.bounds.size.height
/// 屏幕的bounds
public let MainBounds = UIScreen.main.bounds
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


