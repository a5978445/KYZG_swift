//
//  NewsModel.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/5/4.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import Foundation

public struct NewsModel {
    var cellModels = [InformationTableViewCellModel]()
    var nextPageToken:String?
    
//    init(cellModels: [InformationTableViewCellModel] = [InformationTableViewCellModel](),
//         nextPageToken: String? = nil) {
//        self.cellModels = cellModels
//        self.nextPageToken = nextPageToken
//    }
    
    static func + (lhs: NewsModel,rhs: NewsModel) -> NewsModel{
        
        var resultModels = lhs.cellModels
        var resultToken = lhs.nextPageToken
        resultModels.append(contentsOf: rhs.cellModels)
        
        resultToken = (resultToken ?? "") + (rhs.nextPageToken ?? "")
        
        return NewsModel(cellModels: resultModels, nextPageToken: resultToken)
    }
}
