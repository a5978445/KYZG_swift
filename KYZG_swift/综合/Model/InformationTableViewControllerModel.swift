//
//  InformationTableViewControllerModel.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/25.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire





class InformationTableViewControllerModel: NSObject {
    private var banners = [OSCBanner]()
    
    private var newsModel = NewsModel()
    
    //MARK: public method
    func requestImageInfo(complete:@escaping (KYZGResponse<[String]>) -> Void)  {
        
        KYZGProvider.shareKYZGProvider.requestImageInfo { response in
            switch response {
            case let .sucess(banners):
                self.banners = banners
                complete(KYZGResponse.sucess(banners.map{$0.img!}))
            case let .failure(error):
                complete(KYZGResponse<[String]>.failure(error))
            }
        }
        
    }
    
    
    
    func appendNews(complete: @escaping (KYZGResponse<NewsModel>) -> Void) {
        KYZGProvider.shareKYZGProvider.requestNews(nextPageToken: self.newsModel.nextPageToken) {[weak self]  response in
            guard self != nil else {
                return
            }
            switch response {
            case let .sucess(aNewsModel):
                self?.newsModel = self!.newsModel + aNewsModel
                complete(KYZGResponse.sucess(self!.newsModel))
            case .failure(_):
                complete(response)
            }
            
        }
        
    }
    
    func refreshNews(complete: @escaping (KYZGResponse<NewsModel>) -> Void) {
        
        KYZGProvider.shareKYZGProvider.requestNews(nextPageToken: nil) {[weak self]  response in
            
            switch response {
            case let .sucess(aNewsModel):
                self?.newsModel = aNewsModel
                
            case .failure(_): break
            }
            complete(response)
        }
        
        
    }
    
    
    //MARK: private method

    private func imageURLs() -> [String] {
        
        return banners.map { $0.img!}
    }
    
}
