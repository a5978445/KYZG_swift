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
    
    
    var tweetType: TweetType = .newTweet;
    var tweets: Tweets?
    
    func addTweets(complete: @escaping (KYZGResponse<Tweets>) -> Void)  {
        let parameters = ["type": tweetType.rawValue,
                          "pageToken": self.tweets!.nextPageToken!] as [String : Any]
        
        
        KYZGProvider.shareKYZGProvider.requesTweets(parameters)  { response in
            switch response {
            case let .sucess(tweets):
                self.tweets = self.tweets! + tweets
                complete(KYZGResponse.sucess(self.tweets!))
            default:
                complete(response)
            }
            
            
        }
    }
    
    func requestNewTweets(complete: @escaping (KYZGResponse<Tweets>) -> Void)  {
        let parameters = ["type":tweetType.rawValue]
        KYZGProvider.shareKYZGProvider.requesTweets(parameters)  { response in
            switch response {
            case let .sucess(tweets):
                self.tweets = tweets
                
            default:
                break;
            }
            complete(response)
            
        }
        
    }
    
}
