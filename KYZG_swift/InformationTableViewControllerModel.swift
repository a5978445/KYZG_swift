//
//  InformationTableViewControllerModel.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/25.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import SwiftyJSON

class InformationTableViewControllerModel: NSObject {
    private var banners = [OSCBanner]()
    
    private var infomations = [OSCInformation]()
    
    
    open func setInfomations(infomationsJSON:[JSON]) -> Void {
      
        for aInformationJSON in infomationsJSON{
            let aOSCInformation = OSCInformation()
            aOSCInformation.mj_setKeyValues(aInformationJSON.rawValue)
            
            infomations.append(aOSCInformation)
        }
    }
    
    open func getInfomations() -> [OSCInformation] {
        return infomations;
    }
    
    open func setBanners(banersJSON:[JSON]) ->Void {
        
      //  let items = dic["result"]["items"]
        banners.removeAll()
        for aBanerDic in banersJSON{
            let aBaner = OSCBanner()
            // to do
            aBaner.mj_setKeyValues(aBanerDic.rawValue)
            
            banners.append(aBaner)
        }
        
    }
    
    open func getBanners() ->[OSCBanner] {
        return banners
    }
    
    open func imageURLs()->[String] {
        var imageURLs = [String]()
        for aBaner in banners{
            imageURLs.append(aBaner.img as! String)
        }
        return imageURLs;
    }
    
}
