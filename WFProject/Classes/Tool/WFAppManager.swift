//
//  WFAppManager.swift
//  WFProject
//
//  Created by hello on 2018/6/30.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation

//let api = "http://slavex.3dabuliu.com/app/info"

class WFAppManager{
    
    let dataArray :[String] = []
//    
//    class func checkVersion(success: (([String]?)->Void)?, failure:((Error?)->Void)?){
//        
//        let parameters = ["a":APPID_A,"b":"2"]
//        do {
//            let jsonData =  try JSONSerialization.data(withJSONObject: parameters, options: [])
//            let jsonString = jsonData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
//            let signString = jsonString.appending("123456")
//            let sign = signString.md5()
//            let newPara = ["object":jsonString,"sign":sign]
//            
//            WFNetWorkTool.shared.POST(urlString: api.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!, parameters: newPara, showHUD: true, success: {(respone) in
//                
//                let dict : [String : Any] = respone as! [String : Any]
//                print(dict)
//        
//
//                if dict["data"] is NSNull {
//                    failure!(nil)
//                    return
//                }else{
//                    let data = dict["data"]
//                    let dataDict = data as! [String : Any]
//                    let dataString = dataDict ["app_url"]! as! String
//                    success!(dealWithDataString(dataString: dataString))
//                }
//                
//            }) { (error) in
//                print(error)
//                failure!(error)
//            }
//        }catch let error {
//            print(error)
//            failure!(error)
//        }
//       
//    }
    
    class func getLaunchImage()-> UIImage{
        
        var viewOrientation = "Portrait"
        if (UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)){
            viewOrientation = "Landscape"
        }
        var launchImageName = ""
        let imagesDict :[[String : String]]  = Bundle.main.infoDictionary!["UILaunchImages"] as! [[String : String]]
        let currentWindow = UIApplication.shared.windows.first
        let viewSize = currentWindow?.bounds.size
        for dict in imagesDict as Array{
            let imageSize = CGSizeFromString((dict["UILaunchImageSize"])!)
            
            if(__CGSizeEqualToSize(imageSize, viewSize!) && viewOrientation.compare(dict["UILaunchImageOrientation"] as! String).rawValue == 0){
                launchImageName = dict["UILaunchImageName"]!
            }
            
           
            
        }
        if(launchImageName.compare("").rawValue == 0){
            for dict in imagesDict as Array{
                let imageSize = CGSizeFromString((dict["UILaunchImageSize"])!)
                if(imageSize.width == viewSize?.height && imageSize.height == viewSize?.width){
                    launchImageName = dict["UILaunchImageName"]!
                }
            }
        }
        return UIImage(named: launchImageName)!
        
    }
    
//    class func settingUMeng() {
//        let infoDict = Bundle.main.infoDictionary
//        let app_bundleId = infoDict!["CFBundleIdentifier"] as! String
//        let app_version = infoDict!["CFBundleShortVersionString"] as! String
//        let app_name = infoDict!["CFBundleDisplayName"] as! String
//        let app_bundleversion = infoDict!["CFBundleVersion"] as! String
//        let channelName =  app_bundleId + "||" + app_version + "||" + app_name + "||" + app_bundleversion
//        UMConfigure.initWithAppkey(UMengAppKey, channel: channelName)
//    }
    
    class func dealWithDataString(dataString : String) -> [String]{
        
        var stringArr : [String] = dataString.components(separatedBy: "||")
        for i in 0 ..< 4 {
            if(stringArr.count > i){
                var str = stringArr[i]
                str = "http://" + str
                stringArr[i] = str
            }else{
               return stringArr
            }
        }
        return stringArr
    }
    
    class func Alert(title:String,message:String? = nil,confirm:String,cancel:String,confirmActin:(()->())?,cancelAction:(()->())?) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAct = UIAlertAction(title: confirm, style: .default) { (action) in
            confirmActin!()
        }
        alertVC.addAction(confirmAct)
        
        if(cancel.compare("").rawValue != 0){
            let cancelAct = UIAlertAction(title: cancel, style: .cancel) { (action) in
                cancelAction!()
            }
            alertVC.addAction(cancelAct)
        }
        
        self.getCurrentVC().present(alertVC, animated: true, completion: nil)
        
    }
    
    class func getCurrentVC() -> UIViewController {
        var result : UIViewController?
        var window = UIApplication.shared.keyWindow
        if (window?.windowLevel != UIWindowLevelNormal){
            
            let windows = UIApplication.shared.windows as Array
            
            for tempWindow in windows {
                if(tempWindow.windowLevel == UIWindowLevelNormal){
                    window = tempWindow
                    break
                }
            }
        }
        
        let frontView = window?.subviews.first
        let nextResponder = frontView?.next
        
        if(nextResponder?.isKind(of: UIViewController.self))!{
            if(nextResponder?.isKind(of: UITabBarController.self))!{
                result = (nextResponder as! UITabBarController).selectedViewController
                if(result?.isKind(of: UINavigationController.self))!{
                    result = (nextResponder as! UINavigationController).visibleViewController
                }
            }else if(nextResponder?.isKind(of: UINavigationController.self))!{
                result = (nextResponder as! UINavigationController).visibleViewController
            }else{
                result = nextResponder as? UIViewController
            }
        }else{
            result = window?.rootViewController
        }
        
        return result!
        
    }
    
}
