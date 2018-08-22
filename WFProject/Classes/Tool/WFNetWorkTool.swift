//
//  WFNetWorkTool.swift
//  WFProject
//
//  Created by hello on 2018/6/30.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation
import CoreTelephony

public enum NetworkStatusType :Int {
    
    case noNetWork
    
    case wifi
    
    case other
}

public enum NetworkCarrierType :Int{
    
    case chinaMobile
    
    case chinaTelecom
    
    case chinaUnicom
    
    case chinaTietong
    
    case chinaZG
    
    case otherCarrierType
}

class WFNetWorkTool: NSObject {
    
    static let shared: WFNetWorkTool = {
        return WFNetWorkTool()
    }()
    
    static let netWorkManager : AFHTTPSessionManager = {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(object:"application/json" ) as? Set<String>//setValue("application/json")
        manager.requestSerializer.timeoutInterval = 15
        return manager
    }()
}

extension WFNetWorkTool{
    
    func checkNetworkCarrierType()->Int
    {
        var carrierTypeString = ""
        let info = CTTelephonyNetworkInfo()
        if let carrier = info.subscriberCellularProvider {
            if(carrier.carrierName?.isEmpty)!{
                return NetworkCarrierType.otherCarrierType.rawValue
            }
            carrierTypeString = (carrier.carrierName)!
            
            if(carrierTypeString.contains("移动")){
                return NetworkCarrierType.chinaMobile.rawValue
            }else if(carrierTypeString.contains("联通")){
                return NetworkCarrierType.chinaTelecom.rawValue
            }else if(carrierTypeString.contains("电信")){
                return NetworkCarrierType.chinaUnicom.rawValue
            }else if(carrierTypeString.contains("铁通")){
                return NetworkCarrierType.chinaTietong.rawValue
            }else if(carrierTypeString.contains("中国")){
                return NetworkCarrierType.chinaZG.rawValue
            }
        }
        
        return NetworkCarrierType.otherCarrierType.rawValue
    }
    
    func GET(urlString:String,parameters: [String : Any]? = nil, showHUD: Bool = true, success: ((Any?)->Void)?, failure:((Error?)->Void)?) {
        
        WFNetWorkTool.netWorkManager.get(urlString, parameters: parameters, progress:nil, success:{(task, respone) in
            success!(respone)
            
        },failure:{ (task,error) in
            failure!(error)
        })
    }
    
    func POST(urlString:String,parameters: [String : Any]? = nil, showHUD: Bool = true, success: ((Any?)->Void)?, failure:((Error?)->Void)?) {
        
        WFNetWorkTool.netWorkManager.post(urlString, parameters: parameters, progress: nil, success: { (task, respone) in
            success!(respone)
        }) { (task, error) in
           failure!(error)
        }
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
    
    func checkAppsTesting()-> Bool {
        
        var num = 0;
        if(UIApplication.shared.canOpenURL(URL(string: "Sinaweibo://")!)){
            //安装了新浪微博
            num += 1
        }
        if(UIApplication.shared.canOpenURL(URL(string: "mqq://")!)){
            //安装了QQ
            num += 1
        }
        if(UIApplication.shared.canOpenURL(URL(string: "mqzone://")!)){
            //安装了QQ空间
            num += 1
        }
        if(UIApplication.shared.canOpenURL(URL(string: "weixin://")!)){
            //安装了微信
            num += 1
        }
        if(UIApplication.shared.canOpenURL(URL(string: "alipay://")!)){
            //安装了支付宝
            num += 1
        }
        return num > 0
    }
    
}
