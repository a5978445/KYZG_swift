//
//  OSCUser.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/1.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import HandyJSON

class OSCUser: NSObject {
    
    
    static let sharedInstance = OSCUser()
    
    var userInfo:OSCUserInfo?
    
   
   // private override init() {} //This prevents others from using the default '()' initializer for this class.
    
}

class OSCUserInfo: HandyJSON {
    var id:NSNumber?
    var devplatform:String?
    var jointime:String?
    var favorite_count:NSNumber?
    var expertise:String?
    var from:String?
    var portrait:String?
    
    var latestonline:String?
    var fans:NSNumber?
    var followers:NSNumber?
    
    var score:NSNumber?
    var gender:NSNumber?
    var name:String?
    
     required init() {}
}
