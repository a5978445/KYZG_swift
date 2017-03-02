//
//  UserInfoViewModel.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/2.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class UserInfoViewModel: NSObject {

    
    var headimageURL:String? {
        get {
            return user?.portrait
        }
    }
    var userName:String? {
        get {
            return user?.name ?? "点击头像登陆"
        }
    }
    var userInfo:String? {
        get {
           // return user?.description ?? "该用户还没有填写描述..."
        
            guard user != nil else {
                return nil
            }
            return  "该用户还没有填写描述..."
        }
    }
    var integral:String? {
        get {
            
            guard ((user?.score) != nil) else {
                return nil
            }
            
            
            return "积分：" + (user?.score?.intValue.description)!
            
        }
    }
    
    var user:OSCUserInfo?
    
    
}
