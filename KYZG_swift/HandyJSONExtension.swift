//
//  HandyJSONExtension.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/4.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import HandyJSON

public extension HandyJSON {
    
   public static func deserialize(from data:Data) -> Self? {
   // public class func getUserInfo(JSONData:Data) -> OSCUserInfo? {
        
        
        let jsonString  = String.init(data: data, encoding: String.Encoding.utf8)
        return JSONDeserializer<Self>.deserializeFrom(json: jsonString, designatedPath: nil)
        
    }
    
  
}
