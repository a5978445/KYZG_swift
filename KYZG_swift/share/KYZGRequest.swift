//
//  MoyaProvider+Extension.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/5/4.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import SwiftyJSON
import Result


// MARK: - Provider setup
func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}
class KYZGProvider: MoyaProvider<KYZG> {
    
    
    public static let shareKYZGProvider = KYZGProvider(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
    
    func requestNews(nextPageToken: String?,complete: @escaping (KYZGResponse<NewsModel>) -> Void) {
        
        KYZGProvider.shareKYZGProvider.request(.news(nextPageToken)) { completion in
            
            self.dealMoyaCompletion(input: completion, complete: complete) { (dic: JSON) in
                
                
                var models = [InformationTableViewCellModel]()
                
                do {
                    models = try self.infomations(infomationsJSON: dic["result"]["items"].arrayValue)
                } catch {
                    let error = RequestError.mapToModel
                    return KYZGResponse<NewsModel>.failure(error)
                    
                }
                
                let token = (dic["result"]["nextPageToken"].rawValue as AnyObject) as? String;
                
                let newsModel = NewsModel(cellModels: models, nextPageToken: token)
                
                return KYZGResponse.sucess(newsModel)
                
            }
            
        }
    }
    
    func requestImageInfo(complete:@escaping (KYZGResponse<[OSCBanner]>) -> Void)  {
        
        KYZGProvider.shareKYZGProvider.request(.imageInfo) { completion in
            
            self.dealMoyaCompletion(input: completion, complete: complete) { (dic: JSON) in
                do {
                    
                    let banners = try self.getBanners(banersJSON: dic["result"]["items"].arrayValue)
                    
                    return (KYZGResponse
                        .sucess(banners));
                } catch {
                    return KYZGResponse.failure(RequestError.mapToModel)
                }
            }
            
        }
        
    }
    
    private func dealMoyaCompletion<T> (
        input: (Result<Moya.Response, Moya.MoyaError>),
        complete: @escaping (KYZGResponse<T>) -> Void ,
        deal: (JSON) -> (KYZGResponse<T>)
        ) {
        
        switch input {
        case let .success(response):
            let dic = JSON(data: response.data)
            if dic["code"] == 1 {
                
                complete(deal(dic))
            } else { //处理错误信息
                //  print(dic)
                let error = RequestError.ackCode(dic["code"].intValue)
                complete(KYZGResponse.failure(error))
            }
            
        case let .failure(error):
            complete(KYZGResponse.failure(RequestError.moya(error)))
            
        }
    }
}

extension KYZGProvider {
    //MARK: private method
    fileprivate func infomations(infomationsJSON: [JSON]) throws -> [InformationTableViewCellModel] {
        
        let result: [InformationTableViewCellModel]
        
        result = try infomationsJSON.map { aInformationJSON in
            let data:Data
            data = try aInformationJSON.rawData()
            let aOSCInformation = OSCInformation.deserialize(from: data)
            
            return InformationTableViewCellModel(information: aOSCInformation!)
            
            
        }
        
        return result
        
        
    }
    
    fileprivate func getBanners(banersJSON: [JSON]) throws -> [OSCBanner] {
        
        return try banersJSON.map { aBanerDic in
            
            let data = try aBanerDic.rawData()
            return OSCBanner.deserialize(from:data)!
            
        }
        
    }
    
}
