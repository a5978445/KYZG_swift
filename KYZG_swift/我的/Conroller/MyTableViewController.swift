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
    var title: String?
    var imageName: String?
    var reponse: () -> Void
    
}


class MyTableViewController: UITableViewController {
    
    private lazy var headerView: MyTableHeaderView = {() -> MyTableHeaderView in
        let aMyTableHeaderView = MyTableHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 280 + 64))
        
        aMyTableHeaderView.showLogin = {[weak self]  in
            self?.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        
        aMyTableHeaderView.showSet = {[weak self]  in
            self?.navigationController?.pushViewController(SettingViewController(), animated: true)
        }
        
        aMyTableHeaderView.showQRCode = {[weak self] in
            
            let checkmarkView = UIImageView(image: Utils.createQRCodeFromString(string: (OSCUser.sharedInstance.userInfo?.id?.description)!))
            let hud = BXProgressHUD.Builder(forView: (self?.view)!).mode(.customView).customView(checkmarkView).text("扫一扫上面的二维码，加我为好友")
            let xx = hud.show() //.hide(afterDelay: 3)
            xx.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MyTableViewController.hideHUD)))
            
            
            
        }
        
        aMyTableHeaderView.showHeadImage = { [unowned self] in
            let alertController = UIAlertController(title: nil, message: "选择操作", preferredStyle: UIAlertController.Style.actionSheet)
            alertController.addAction(UIAlertAction(title: "更换头像", style: UIAlertAction.Style.default, handler: { action in
                self.showPhotoSlectAlertView()
            }))
            
            alertController.addAction(UIAlertAction(title: "查看大头像", style: UIAlertAction.Style.default, handler: { action in
                
            }))
            
            alertController.addAction(UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: { action in
                
            }))
                print(self.navigationController)
          //  self.show(alertController, sender: nil)
            self.present(alertController, animated: true, completion: nil)
        }
        return aMyTableHeaderView
    }()
    
    let dataSouce =
        MyTableViewDataSource(model: [CellModel(title:"我的消息",imageName:"ic_my_messege",reponse:{()->Void in }),
                                      CellModel(title:"我的博客",imageName:"ic_my_blog",reponse:{()->Void in }),
                                      CellModel(title:"我的活动",imageName:"ic_my_event",reponse:{()->Void in }),
                                      CellModel(title:"我的团队",imageName:"ic_my_team",reponse:{()->Void in })])
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.tableHeaderView = headerView
        tableView.dataSource = dataSouce
        self.tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 44, right: 0)
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        headerView.userInfo = OSCUser.sharedInstance.userInfo;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideHUD() {
        BXProgressHUD.hideHUDForView(self.view)
        print("test")
        HUD.hide()
    }
    
    private func showPhotoSlectAlertView() {
        
        func showCameraCtrl() {
            
            let p = UIImagePickerController()
            p.sourceType = UIImagePickerController.SourceType.camera;
            p.allowsEditing = true;
            p.delegate = self;
            self.present(p, animated: true, completion: nil)
            
        }
        
        func showPhotoSelectCtrl() {
            
            let p = UIImagePickerController()
            p.sourceType = UIImagePickerController.SourceType.photoLibrary;
            p.allowsEditing = true;
            p.delegate = self;
            self.present(p, animated: true, completion: nil)
            
        }
        
        func creatAlertController() -> UIAlertController {
            let alertController = UIAlertController(title: nil, message: "选择操作", preferredStyle: UIAlertController.Style.actionSheet)
            
            
            alertController.addAction(UIAlertAction(title: "相机", style: UIAlertAction.Style.default, handler: { action in
                showCameraCtrl()
            }))
            
            
            alertController.addAction(UIAlertAction(title: "相册", style: UIAlertAction.Style.default, handler: { action in
                
                showPhotoSelectCtrl()
            }))
            
            
            alertController.addAction(UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: { action in
                
            }))
            return alertController
        }
        
        
        
        self.present(creatAlertController(), animated: true, completion: nil)
    }
    // MARK: - Table view data source
    
    
    
}

extension MyTableViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //MARK - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info["UIImagePickerControllerEditedImage"] as! UIImage;
        
        
        picker.dismiss(animated: true, completion: nil)
        //NSData *data = UIImageJPEGRepresentation(image, 0.7f);
        // [self updatePortraitWithData:data];
    }
    
}
