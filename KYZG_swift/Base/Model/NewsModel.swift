//
//  NewsModel.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/5/4.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import Foundation
import HandyJSON

struct NewsModel: HandyJSON {
    var informations = [OSCInformation]()
    var nextPageToken:String?
    
    var prevPageToken : String!
    var requestCount : Int!
    var responseCount : Int!
    var totalResults : Int!
    
    static func + (lhs: NewsModel,rhs: NewsModel) -> NewsModel{
        
        var resultModels = lhs.informations
        var resultToken = lhs.nextPageToken
        
        resultModels.append(contentsOf: rhs.informations)
        resultToken = rhs.nextPageToken!
        let prevPageToken = lhs.prevPageToken
        let requestCount = lhs.requestCount + rhs.requestCount
        let responseCount = lhs.responseCount + rhs.responseCount
        let totalResults = lhs.totalResults + rhs.totalResults
        
        return NewsModel(informations: resultModels,
                         nextPageToken: resultToken!,
                         prevPageToken: prevPageToken!,
                         requestCount: requestCount,
                         responseCount: responseCount,
                         totalResults: totalResults)
    }
    
//    required init() {}
//    init(informations: [OSCInformation],
//         nextPageToken: String,
//         prevPageToken: String,
//         requestCount: Int,
//         responseCount: Int,
//         totalResults: Int) {
//        self.informations = informations;
//        self.nextPageToken = nextPageToken
//        self.prevPageToken = prevPageToken
//        self.requestCount = requestCount
//        self.responseCount = responseCount
//        self.totalResults = totalResults
//    }
    
    mutating func mapping(mapper: HelpingMapper) {
        // specify 'cat_id' field in json map to 'id' property in object
        mapper <<<
            self.informations <-- "items"
        
        // specify 'parent' field in json parse as following to 'parent' property in object

    }
}
