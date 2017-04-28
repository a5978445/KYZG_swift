//
//  TweetsViewControllerModel.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/6.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
import SwiftyJSON

class TweetsViewControllerModel: NSObject {
    
    private var models = [TweetModel]()
    var tweetType: TweetType = .newTweet;
    var nextPageToken: String?
    
    
    func addTweets(complete: @escaping ([TweetModel]?,NSError?) -> Void)  {
        self.requestTweets(complete: complete,
                           parameters: ["type": tweetType.rawValue, "pageToken": self.nextPageToken!],
                           isRefresh: false)
    }
    
    func requestNewTweets(complete: @escaping ([TweetModel]?, NSError?) -> Void)  {
        self.requestTweets(complete: complete,
                           parameters: ["type":tweetType.rawValue],
                           isRefresh: true)
    }
    
    func requestTweets(complete: @escaping ([TweetModel]?,NSError?) -> Void,
                       parameters: [String:Any],
                       isRefresh: Bool)  {
        Alamofire.request(OSCAPI_V2_HTTPS_PREFIX + OSCAPI_TWEETS,
                          method: HTTPMethod.get,
                          parameters: parameters,
                          encoding: URLEncoding.default ,
                          headers: nil)
            .responseJSON { response in
                
                
                if response.result.value != nil {
                    
                    let dic = JSON(data: response.data!)
                    print(dic)
                    if dic["code"] == 1 {
                        
                        let aModels = self.getModelsWithJSONs(aJSONs: dic["result"]["items"].arrayValue as! [JSON])
                        if isRefresh {
                            self.models = aModels
                        } else {
                            self.models.append(contentsOf: aModels)
                        }
                        
                        self.nextPageToken = (dic["result"]["nextPageToken"].rawValue as AnyObject) as? String;
                        
                        print("sucess")
                        
                        if aModels.count == 0 {
                            complete(nil,nil)
                        } else {
                            complete(self.models,nil)
                        }
                        
                    } else { //处理错误信息
                        print(dic)
                        complete(nil,NSError(domain: "未知原因", code: 0, userInfo: nil));
                    }
                    
                    
                } else {
                    //    let error = response.error as! NSError
                    complete(nil,response.error as! NSError)
                    // throw response.error
                    
                }
        }
        
    }
    
    
    
    
    
    
    private func getModelsWithJSONs(aJSONs:[JSON]) -> [TweetModel] {
     
        return aJSONs.map { value in
            let data:Data
            do {
                data = try value.rawData()
                return TweetModel.deserialize(from: data)!
            } catch  {
                fatalError("model解析失败")
            }
        }
    }
    
}
