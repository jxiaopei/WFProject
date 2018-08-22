//
//  String+Extension.swift
//  WFProject
//
//  Created by hello on 2018/8/16.
//  Copyright © 2018年 WF. All rights reserved.
//

import Foundation


extension String{
    
     func md5() -> String {
        let utf8String = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(utf8String!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
//        result.deinitialize()
        return String(format: hash as String)
    }
    
}
