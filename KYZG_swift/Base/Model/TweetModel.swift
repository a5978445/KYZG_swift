//
//  TweetModel.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/6.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import HandyJSON


enum InfoType {
    case normal
    case about
    case singleImage(OSCNetImage)
    
    func description() -> String {
        switch self {
        case .normal:
            return "InfoType.normal"
        case .about:
            return "InfoType.about"
        case .singleImage( _):
            return "InfoType.singleImage"
        }
    }
}


public enum AppClientType: Int,HandyJSONEnum {
    case AppClientType_Unknown       = 0
    case AppClientType_Phone         = 1 //手机
    case AppClientType_Android       = 2 //Android
    case AppClientType_iPhone        = 3 //iPhone
    case AppClientType_WindowsPhone  = 4 //Windows Phone
    case AppClientType_WeChat        = 5 //WeChat
}

struct OSCTweetAuthor: HandyJSON {
    var id: Int?
    var name: String?
    var portrait: String?
    
  //  required init() {}
    
}

struct OSCTweetAudio: HandyJSON {
 
    var href: String?
    var timeSpan: String?
    
  //  required init() {}
    
}

struct OSCTweetCode: HandyJSON {
    
    var brush: String?
    var content: String?
    
  //  required init() {}
    
}

struct OSCNetImage: HandyJSON {
    
    var thumb: String?
    var href: String?
    
    var w: Int?
    var h: Int?
    var type: String?
    var name: String?
    
    
   // required public init() {}
    
}

struct OSCAbout: HandyJSON {
    
    var id: Int?
    var title: String?
    var content: String?
    var type: InformationType?
    var statistics: OSCStatistics?
    var href: String?
    var images: [OSCNetImage]?
    
   // required init() {}
    
}

struct OSCStatistics: HandyJSON {
    
    var comment: Int?
    var view: Int?
    var like: Int?
    var transmit: Int?
 
  //  required init() {}
    
}


struct Tweets: HandyJSON {
    
    var tweetModels = [TweetModel]()
    var nextPageToken: String?
    var prevPageToken : String!
    var requestCount : Int!
    var responseCount : Int!
    var totalResults : Int!
    
    static func + (lhs: Tweets,rhs: Tweets) -> Tweets{
        
        var resultModels = lhs.tweetModels
        var resultToken = lhs.nextPageToken
        resultModels.append(contentsOf: rhs.tweetModels)
        
        resultToken = (rhs.nextPageToken ?? "")
        

        let prevPageToken = lhs.prevPageToken
        let requestCount = lhs.requestCount + rhs.requestCount
        let responseCount = lhs.responseCount + rhs.responseCount
        let totalResults = lhs.totalResults + rhs.totalResults
        
        return Tweets(tweetModels: resultModels,
                         nextPageToken: resultToken!,
                         prevPageToken: prevPageToken!,
                         requestCount: requestCount,
                         responseCount: responseCount,
                         totalResults: totalResults)
        

    }
    
    mutating func mapping(mapper: HelpingMapper) {
        // specify 'cat_id' field in json map to 'id' property in object
        mapper <<<
            self.tweetModels <-- "items"
        
        // specify 'parent' field in json parse as following to 'parent' property in object
        
    }
  //  required init() {}
}


struct TweetModel: HandyJSON {
    
    /*
     /*
     "author" : "麦壳饼",
     "recommend" : true,
     "id" : 82582,
     "title" : "GitLab Extension for Visual Studio 1.0.0.40 发布",
     "href" : "https:\/\/www.oschina.net\/news\/82582\/gitlab-extension-for-vs-1-0-0-40",
     "pubDate" : "2017-03-06 10:33:46",
     "type" : 6,
     "body" : "GitLab Extension for Visual Studio 1.0.0.40  主要更新了以下功能： 一、增加了编辑器右键菜单中加入了在浏览器中打开托管在GitLab服务器i上的功...",
     "viewCount" : 69,
     "commentCount" : 1
     */
     var author:String?
     var recommend:Bool?
     
     var title:String?
     
     var pubDate:String?
     var type:String?
     var body:String?
     var viewCount:Int?
     var commentCount:Int?
     
     var appClient:AppClientType?
     var content:String?
     var href:String?
     var id:Int?
     var liked:Bool?
     var likeCount:Int?
     
     */
    
    var id:Int?
    var appClient:AppClientType?
    var href:String?
    var author:OSCTweetAuthor?
    var pubDate:String?
    var audio:[OSCTweetAudio]?
    var code:OSCTweetCode?
    var images:[OSCNetImage]?
    var liked:Bool?
    var content:String?
    var about:OSCAbout?
    var statistics:OSCStatistics?
    
    var likeCount: Int?
    var commentCount: Int?
    
    
    var infoType:InfoType {
        if self.about != nil {
            return .about
        } else if self.images?.count == 1 {
           return .singleImage(self.images![0] )
        }
        
        else {
            return .normal
        }
    }
    
    var reuseIdentifier:String {
        return infoType.description()
    }
    
    
   // required init() {}
}
