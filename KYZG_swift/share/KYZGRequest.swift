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
import RxSwift
import RxCocoa

let errorMsg = "请求失败"
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
class KYZGProvider: RxMoyaProvider<KYZG> {
    
    
    public static let shareKYZGProvider = KYZGProvider(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
    
    func requestNews(nextPageToken: String?,complete: @escaping (KYZGResponse<NewsModel>) -> Void) {
        
        request(.news(nextPageToken)) { completion in
            
            self.dealMoyaCompletion(input: completion, complete: complete) { (dic: JSON) in
                
                do {
                    let newsModel = try self.getNewsModel(dic["result"])
                    
                    return KYZGResponse.sucess(newsModel)
                } catch {
                    let error = RequestError.mapToModel
                    return KYZGResponse<NewsModel>.failure(error)
                    
                }
                
                
                
                
            }
            
            
            
        }
        
        
    }
    
    func rxRequestNews(nextPageToken: String?) -> Observable<KYZGResponse<NewsModel>> {
        let xx: Observable<Response> =  request(.news(nextPageToken))
        
        
       return xx.flatMap {[unowned self] (response) -> Observable<KYZGResponse<NewsModel>> in
            
            let completedResponse = self.dealResponse(response, sucessOpreation: { dic -> KYZGResponse<NewsModel> in
                if dic["code"] == 1 {
                    do {
                        let newsModel = try self.getNewsModel(dic["result"])
                        
                        return KYZGResponse.sucess(newsModel)
                    } catch {
                        let error = RequestError.mapToModel
                        return KYZGResponse<NewsModel>.failure(error)
                        
                    }
                    
                } else { //处理错误信息
                    //  print(dic)
                    let error = RequestError.ackCode(dic["code"].intValue)
                    
                    return KYZGResponse.failure(error)
                }
            })
            
            return  Observable<KYZGResponse<NewsModel>>.create { (ObservableKYZGResponse) -> Disposable in
                ObservableKYZGResponse.on(.next(completedResponse))
                ObservableKYZGResponse.on(.completed)
                return Disposables.create()
            }
        }

    }
    
    func requestImageInfo(complete:@escaping (KYZGResponse<[OSCBanner]>) -> Void)  {
        
        request(.imageInfo) { completion in
            
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
    
    
    func requesTweets(_ parameters:[String : Any],
                      complete:@escaping (KYZGResponse<Tweets>) -> Void) {
        request(.tweets(parameters)) { completion in
            self.dealMoyaCompletion(input: completion, complete: complete) { (dic: JSON) in
                
                do {
                    let aTweets = try self.getTweets(dic["result"])
                    return KYZGResponse.sucess(aTweets)
                } catch {
                    return KYZGResponse.failure(RequestError.mapToModel)
                }
                
            }
        }
        
        
    }
    
    func requestLogin(_ parameters:[String : Any],
                      complete:@escaping (KYZGResponse<OSCUserInfo>) -> Void) {
        request(.login(parameters)) { completion in
            self.dealMoyaCompletion(input: completion, complete: complete) { (dic: JSON) in
                
                let data:Data
                do{  data  = try  dic["obj_data"].rawData()
                    
                    let userInfo = OSCUserInfo.deserialize(from: data)
                    
                    return KYZGResponse.sucess(userInfo!)
                }
                catch {
                    return KYZGResponse.failure(RequestError.mapToModel)
                }
                
            }
        }
    }
    
    
    // MARK: private method
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
    
    private func dealResponse<T>(_ response: Response, sucessOpreation: (JSON) -> KYZGResponse<T>) -> KYZGResponse<T>{
        
        if response.statusCode == 200 {
            let dic = JSON(data: response.data)
            if dic["code"] == 1 {
                
              return sucessOpreation(dic)
                
            } else { //处理错误信息
                //  print(dic)
                let error = RequestError.ackCode(dic["code"].intValue)
               
                return KYZGResponse.failure(error)
            }
        } else {
            let error = RequestError.statusCode(response.statusCode)
            return KYZGResponse.failure(error)
        }
    }
}


extension KYZGProvider {
    //MARK: private method
    fileprivate func getNewsModel(_ aNewsJson: JSON) throws -> NewsModel {
        
        let data: Data = try aNewsJson.rawData()
        let aNewsModel = NewsModel.deserialize(from: data)
        
        return aNewsModel!
        
    }
    
    fileprivate func getBanners(banersJSON: [JSON]) throws -> [OSCBanner] {
        
        return try banersJSON.map { aBanerDic in
            
            let data = try aBanerDic.rawData()
            return OSCBanner.deserialize(from:data)!
            
        }
        
    }
    

    
    fileprivate func getTweets(_ aTweetsJSON:JSON) throws -> Tweets {
        
        let data: Data = try aTweetsJSON.rawData()
        let aTweets = Tweets.deserialize(from: data)
        
        return aTweets!
        
    }
    
    
}
