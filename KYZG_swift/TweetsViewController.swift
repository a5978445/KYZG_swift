//
//  TweetsViewController.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/2.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TweetsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.requestImageInfo(complete:{ (test:[String]?, error:NSError?) in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open func requestImageInfo(complete:@escaping ([String]?,NSError?)->Void) ->Void{
        Alamofire.request(rootAddress + tweetList, method: HTTPMethod.get, parameters: nil, encoding:URLEncoding.default , headers: nil).responseJSON { response in
            
            
            if response.result.value != nil {
                
                
                
                let dic = JSON(data: response.data!)
                print(dic)
                if dic["code"] == 1 {
                    
         
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
