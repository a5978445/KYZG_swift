//
//  NetWorkConstant.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/4/28.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import Foundation
import Moya
//let OSCAPI_V2_HTTPS_PREFIX = "https://www.oschina.net/action/api/"
let OSCAPI_V2_HTTPS_PREFIX = "https://www.oschina.net/action/apiv2/"
let OSCAPI_ACCOUNT_LOGIN = "login_validate"
let NEW_OSCAPI_ACCOUNT_LOGIN = "account_login" //登
//let tweetList = "/action/openapi/tweet_list"
//let rootAddress = "https://www.oschina.net"
let OSCAPI_TWEETS = "tweets"


let errorMsg = "请求失败"


enum RequestError: Swift.Error {
   // case mapToJson
    case mapToModel
   // case statusCode(Int)
    case ackCode(Int)
    case moya(Moya.MoyaError)
}

enum KYZGResponse<T> {
    case sucess(T)
    case failure(RequestError)
}
