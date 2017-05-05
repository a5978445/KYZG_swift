//
//  LoginViewController.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/28.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PKHUD

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        // self.requestNewLoginAPI()
        HUD.show(.label("正在登录"))
        requestOldLoginAPI(finsh:{
            HUD.hide()
        })
    }
    
    // 待封装
    func requestOldLoginAPI(finsh:@escaping () -> ()) {
        
        let parameters = ["username": "510491354@qq.com", "pwd": "qq1634","keep_login":"1"] as [String : Any] ;
        
        KYZGProvider.shareKYZGProvider.requestLogin(parameters) { completion in
            switch completion {
            case let .sucess(userInfo):
                OSCUser.sharedInstance.userInfo = userInfo
                self.navigationController?.popViewController(animated: true)
            case let .failure(error):
                print(error)
            }
            finsh()
            
        }
        
       
        
//        //19e387f5ea910abf1e133bd88ddb645c1d814910
//        //19e387f5ea910abf1e133bd88ddb645c1d814910
//        Alamofire.request(OSCAPI_V2_HTTPS_PREFIX + OSCAPI_ACCOUNT_LOGIN,
//                          method: HTTPMethod.post,
//                          parameters:parameters,
//                          encoding: URLEncoding.default,
//                          headers: nil)
//            .responseData{ dataResponse in
//                
//                if (dataResponse.value != nil) {
//                    let aJSON = JSON(data: dataResponse.data!)
//                    
//                    if aJSON["code"] == 1 {
//                        print(aJSON["obj_data"].string)
//                        let data:Data
//                        do{  data  = try  aJSON["obj_data"].rawData()
//                            
//                            OSCUser.sharedInstance.userInfo = OSCUserInfo.deserialize(from: data)
//                            self.navigationController?.popViewController(animated: true)
//                        }
//                        catch {
//                            
//                        }
//                        
//                        
//                        
//                    } else {
//                        print(aJSON["message"])
//                    }
//                } else {
//                    print(dataResponse.error as! NSError)
//                }
//               // print(dataResponse)
//                finsh()
//        }
        
    }
    
    //新登陆接口无法使用
//    func requestNewLoginAPI() {
//        let password = "qq1634"
//        let data = password.data(using: String.Encoding.utf8)
//        print(data?.digestHex())
//        //19e387f5ea910abf1e133bd88ddb645c1d814910
//        //19e387f5ea910abf1e133bd88ddb645c1d814910
//        Alamofire.request(OSCAPI_V2_HTTPS_PREFIX + NEW_OSCAPI_ACCOUNT_LOGIN,
//                          method: HTTPMethod.post,
//                          parameters: [ "account": "510491354@qq.com",
//                                        "password":data?.digestHex()],
//                          encoding: URLEncoding.default,
//                          headers: nil)
//            .responseJSON { response in
//                if (response.value != nil) {
//                    let aJSON = JSON(data: response.data!)
//                    if aJSON["code"] == 1 {
//                      
//                        
//                    } else {
//                        print(aJSON["message"])
//                    }
//                }
//                print(response)
//        }
//    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
