//
//  WFNetWorkTool.swift
//  WFProject
//
//  Created by hello on 2018/6/30.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation

public enum NetworkStatusType :Int {
    
    case noNetWork
    
    case wifi
    
    case other
}

class WFNetWorkTool: NSObject {
    
    static let shared: WFNetWorkTool = {
        return WFNetWorkTool()
    }()
    
    static let netWorkManager : AFHTTPSessionManager = {
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 15
        return manager
    }()
}

extension WFNetWorkTool{
    
    func GET(urlString:String,parameters: [String : Any]? = nil, showHUD: Bool = true, success: ((Any?)->Void)?, failure:((Error?)->Void)?) {
        
        let keyWindow = UIApplication.shared.keyWindow
        
//        if showHUD { MBProgressHUD.showAdded(to: keyWindow!, animated: true) }
        
        WFNetWorkTool.netWorkManager.get(urlString, parameters: parameters, progress:nil, success:{(task, respone) in
            
//            if showHUD { MBProgressHUD.hide(for: keyWindow!, animated: true) }
            success!(respone)
            
        },failure:{ (task,error) in
//            MBProgressHUD.hide(for: keyWindow!, animated: true)
            failure!(error)
        })
    }
    
    /**
     获取当前网络状态
     
     - returns: -1:没网 0:未知 1:wifi 2:2G 3:3G 4:4G
     */
    func currentNetworkType() -> Int {
        let reach = Reachability(hostName: "www.baidu.com")
        let reachType = reach!.currentReachabilityStatus()
        switch reachType {
        case NotReachable:
            return NetworkStatusType.noNetWork.rawValue
        case ReachableViaWiFi:
            return NetworkStatusType.wifi.rawValue
        case ReachableVia2G:
            return NetworkStatusType.other.rawValue
        case ReachableVia3G:
            return NetworkStatusType.other.rawValue
        case ReachableVia4G:
            return NetworkStatusType.other.rawValue
        default:
            return NetworkStatusType.noNetWork.rawValue
        }
    }
    
}
