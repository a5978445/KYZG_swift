//
//  MyTableViewController.swift
//  KYZG_swift
//
//  Created by LiTengFang on 17/2/22.
//  Copyright © 2017 LiTengFang. All rights reserved.
//

import UIKit
import PKHUD
import BXProgressHUD

struct CellModel {
    var title:String?
    var imageName:String?
    var reponse:()->Void
    
}


class MyTableViewController: UITableViewController {
    
    var headerView:MyTableHeaderView?
    
    let dataSouce =
        MyTableViewDataSource(model: [CellModel(title:"我的消息",imageName:"ic_my_messege",reponse:{()->Void in }),
                                      CellModel(title:"我的博客",imageName:"ic_my_blog",reponse:{()->Void in }),
                                      CellModel(title:"我的活动",imageName:"ic_my_event",reponse:{()->Void in }),
                                      CellModel(title:"我的团队",imageName:"ic_my_team",reponse:{()->Void in })])
    
    
    
    override func viewDidLoad() {
        func configureTableHeadView() {
            headerView = MyTableHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 280 + 64))
            
            headerView?.showLogin = {[weak self]  in
                self?.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
            
            headerView?.showSet = {[weak self]  in
                self?.navigationController?.pushViewController(SettingViewController(), animated: true)
            }
            
            headerView?.showQRCode = {[weak self] in
                
                let checkmarkView = UIImageView(image: Utils.createQRCodeFromString(string: (OSCUser.sharedInstance.userInfo?.id?.intValue.description)!))
                let hud = BXProgressHUD.Builder(forView: (self?.view)!).mode(.customView).customView(checkmarkView).text("扫一扫上面的二维码，加我为好友")
                let xx = hud.show() //.hide(afterDelay: 3)
                xx.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MyTableViewController.hideHUD)))
                
                
                
            }
        }
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        
        
        configureTableHeadView()
        tableView.tableHeaderView = headerView
        tableView.dataSource = dataSouce
        self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 44, 0)
    }
    
    
    
    
    func hideHUD() {
        BXProgressHUD.hideHUDForView(self.view)
        print("test")
        HUD.hide()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        headerView?.userInfo = OSCUser.sharedInstance.userInfo;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    
}
