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
        
        let password = "qq1634"
        let data = password.data(using: String.Encoding.utf8)
        print(data?.digestHex())
        //19e387f5ea910abf1e133bd88ddb645c1d814910
        //19e387f5ea910abf1e133bd88ddb645c1d814910
        Alamofire.request(OSCAPI_V2_HTTPS_PREFIX + OSCAPI_ACCOUNT_LOGIN,
                          method: HTTPMethod.post,
                          parameters: [ "account": "510491354@qq.com",
                                        "password":data?.digestHex()],
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseJSON { response in
                if (response.value != nil) {
                    let aJSON = JSON(data: response.data!)
                    if aJSON["code"] == 1 {
                        
                    } else {
                        print(aJSON["message"])
                    }
                }
                print(response)
        }
    }
    
   
    /*
     
     {
     [_userNameTextField resignFirstResponder];
     [_passwordTextField resignFirstResponder];
     
     _loginButton.backgroundColor = [UIColor navigationbarColor];
     
     [Config saveOwnAccount:_userNameTextField.text];
     
     
     AFHTTPRequestOperationManager* manger = [AFHTTPRequestOperationManager OSCJsonManager];
     
     NSLog(@"apptoken = %@", [Utils getAppToken]);
     
     [manger POST:[NSString stringWithFormat:@"%@%@", OSCAPI_V2_PREFIX, OSCAPI_ACCOUNT_LOGIN]
     parameters:@{
     @"account"   : _userNameTextField.text,
     @"password"  : [Utils sha1:_passwordTextField.text],
     }
     success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
     
     NSInteger code = [responseObject[@"code"] integerValue];
     if (code == 1) {
     NSDictionary *result = responseObject[@"result"];
     OSCUserItem *user = [OSCUserItem osc_modelWithDictionary:result];
     
     [self saveUserInfo:user];
     } else {
     NSString *message = responseObject[@"message"];
     switch (code) {
     case 211:
     {
     //用户名错误
     [Utils setButtonBorder:_userNameView isFail:YES isEditing:NO];
     break;
     }
     case 212:
     {
     //密码错误
     [Utils setButtonBorder:_passWordView isFail:YES isEditing:NO];
     message = @"用户名或密码错误";
     break;
     }
     default:
     break;
     }
     
     MBProgressHUD *HUD = [Utils createHUD];
     HUD.mode = MBProgressHUDModeCustomView;
     HUD.label.text = message;
     
     [HUD hideAnimated:YES afterDelay:2];
     }
     }
     failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
     MBProgressHUD *HUD = [Utils createHUD];
     HUD.mode = MBProgressHUDModeCustomView;
     HUD.label.text = @"网络异常，操作失败";
     
     [HUD hideAnimated:YES afterDelay:2];
     }];
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
