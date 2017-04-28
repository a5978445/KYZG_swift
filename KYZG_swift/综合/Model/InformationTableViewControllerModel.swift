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
    
    // private var infomations = [OSCInformation]()
    
    private var cellModels = [InformationTableViewCellModel]()
    
    private var nextPageToken:String?
    
    let bannersHTTP = OSCAPI_V2_HTTPS_PREFIX + "banner"
    
    let newsHTTP = OSCAPI_V2_HTTPS_PREFIX + "news"
    
    
    func requestImageInfo(complete:@escaping ([String]?, NSError?) -> Void)  {
        Alamofire.request(bannersHTTP,
                          method: HTTPMethod.get,
                          parameters: ["catalog":Int(1)],
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { response in
                            
                            
                            if response.result.value != nil {
                                //   print("JSON: \(aJSON)")
                                let dic = JSON(data: response.data!)
                                if dic["code"] == 1 {
                                    
                                    
                                    self.setBanners(banersJSON: dic["result"]["items"].arrayValue)
                                    complete(self.imageURLs(),nil);
                                    
                                    
                                    // self.imageScrollView.urls = self.model.imageURLs()
                                    print("sucess")
                                    
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
    
    
    
    func appendNews(complete: @escaping ([InformationTableViewCellModel]?,NSError?) -> Void) {
        
        let parameters:[String:Any]? = (self.nextPageToken == nil) ? nil : ["pageToken":self.nextPageToken!];
        
        self.requestNews(complete: complete,
                         isRefresh: false,
                         parameters: parameters)
    }
    
    
    
    
    func refreshNews(complete: @escaping ([InformationTableViewCellModel]?,NSError?) ->Void)  {
        self.requestNews(complete: complete,
                         isRefresh: true,
                         parameters: nil)
        
    }
    
    
    func requestNews(complete:@escaping ([InformationTableViewCellModel]?, NSError?) -> Void,
                     isRefresh: Bool,
                     parameters: [String:Any]?)  {
        Alamofire.request(newsHTTP,
                          method: HTTPMethod.get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON(completionHandler: { response in
                            if response.result.value != nil {
                                
                                let dic = JSON(data: response.data!)
                                print(dic)
                                if dic["code"] == 1 {
                                    
                                    if isRefresh {
                                        self.cellModels = self.infomations(infomationsJSON: dic["result"]["items"].arrayValue)
                                    } else {
                                        self.cellModels.append(contentsOf: self.infomations(infomationsJSON: dic["result"]["items"].arrayValue))
                                    }
                                    
                                    complete(self.cellModels,nil)
                                    
                                    self.nextPageToken = (dic["result"]["nextPageToken"].rawValue as AnyObject) as? String;
                                   
                                    print("sucess")
                                } else {
                                    print(dic)
                                    complete(nil,NSError(domain: "未知原因", code: 0, userInfo: nil));
                                }
                                
                                // self.tableView.mj_header.endRefreshing()
                            } else {
                                complete(nil,response.error as! NSError)
                            }
                          })
        
        
    }
    
    func infomations(infomationsJSON: [JSON]) -> [InformationTableViewCellModel] {
        
        return infomationsJSON.map { aInformationJSON in
            let data:Data
            do { data = try aInformationJSON.rawData()
                let aOSCInformation = OSCInformation.deserialize(from: data)
                
                return InformationTableViewCellModel(information: aOSCInformation!)
            } catch {
                exit(0)
            }
        }
    }
    
    
    
    func setBanners(banersJSON: [JSON]) {
        
        banners = banersJSON.map { aBanerDic in
            let data: Data
            do { data = try aBanerDic.rawData()
                return OSCBanner.deserialize(from:data)!
            }
            catch  {
                exit(0)
            }
        }
        
    }
    
    func imageURLs() -> [String] {
        
        return banners.map { $0.img!}
    }
    
}
