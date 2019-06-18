//
//  SettingViewController.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/28.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {

    var model = [[CellModel(title:"清除缓存",imageName:nil,reponse:{()->Void in })],
                 [CellModel(title:"应用评分",imageName:nil,reponse:{()->Void in }),
                 CellModel(title:"关于我们",imageName:nil,reponse:{()->Void in }),
                 CellModel(title:"开源许可",imageName:nil,reponse:{()->Void in }),
                 CellModel(title:"问题反馈",imageName:nil,reponse:{()->Void in })]]
    
    /*
     if ([UserInfo myUserInfo].user) {
     _dataModels = @[@[@"清除缓存"],
     @[@"应用评分",@"关于我们",@"开源许可",@"问题反馈"],
     @[@"注销登录"]];
     } else {
     _dataModels = @[@[@"清除缓存"],
     @[@"应用评分",@"关于我们",@"开源许可",@"问题反馈"]];
     }
 */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if OSCUser.sharedInstance.userInfo != nil {
            model.append([CellModel(title:"注销登录",imageName:nil,reponse:{()->Void in })])
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = model[indexPath.section][indexPath.row].title;
       
        //tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        
        return cell!
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
