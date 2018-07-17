//
//  CityDataModel.swift
//  WFProject
//
//  Created by hello on 2018/7/10.
//  Copyright © 2018年 WF. All rights reserved.
//

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

