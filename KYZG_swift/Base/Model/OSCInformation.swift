//
//  OSCInformation.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/24.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import HandyJSON

public enum InformationType:Int,HandyJSONEnum {
    case linkNews = 0//链接新闻
    case softWare//软件推荐
    case forum//讨论区帖子
    case blog//博客
    case translation//翻译文章
    case activity//活动类型
    case info = 6//资讯
    case unknown
}

class OSCInformation: HandyJSON {

    var id:Int = 0
    
    var title:String = ""
    
    var body:String = ""
    
    var commentCount:Int = 0
    
    var viewCount:Int = 0
    
    var author:String = ""
    
    var href:String = ""
    
    var recommend:Int = 0
    
    var pubDate:String = ""
    
    var type:InformationType = .unknown
    
    required init() {}
    
  
}
