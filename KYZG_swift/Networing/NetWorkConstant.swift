//
//  NetWorkConstant.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/4/28.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import Foundation
import Moya

enum RequestError: Swift.Error {
   // case mapToJson
    case mapToModel
    case statusCode(Int)
    case ackCode(Int)
    case moya(Moya.MoyaError)
}

enum KYZGResponse<T> {
    case sucess(T)
    case failure(RequestError)
}
