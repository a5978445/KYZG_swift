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
            
            func showPhotoSlectAlertView() {
                
                func showCameraCtrl() {
                    
                    let p = UIImagePickerController()
                    p.sourceType = UIImagePickerControllerSourceType.camera;
                    p.allowsEditing = true;
                    p.delegate = self;
                    self.present(p, animated: true, completion: nil)
                    
                }
                
                func showPhotoSelectCtrl() {
                    
                    let p = UIImagePickerController()
                    p.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                    p.allowsEditing = true;
                    p.delegate = self;
                    self.present(p, animated: true, completion: nil)
                    
                }
                
                
                let alertController = UIAlertController(title: nil, message: "选择操作", preferredStyle: UIAlertControllerStyle.actionSheet)
                
                
                alertController.addAction(UIAlertAction(title: "相机", style: UIAlertActionStyle.default, handler: { action in
                    showCameraCtrl()
                }))
                
                
                alertController.addAction(UIAlertAction(title: "相册", style: UIAlertActionStyle.default, handler: { action in
                    
                    showPhotoSelectCtrl()
                }))
                
                
                alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: { action in
                    
                }))
                
                self.present(alertController, animated: true, completion: nil)
                
            }
            
            headerView = MyTableHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 280 + 64))
            
            headerView?.showLogin = {[weak self]  in
                self?.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
            
            headerView?.showSet = {[weak self]  in
                self?.navigationController?.pushViewController(SettingViewController(), animated: true)
            }
            
            headerView?.showQRCode = {[weak self] in
                
                let checkmarkView = UIImageView(image: Utils.createQRCodeFromString(string: (OSCUser.sharedInstance.userInfo?.id?.description)!))
                let hud = BXProgressHUD.Builder(forView: (self?.view)!).mode(.customView).customView(checkmarkView).text("扫一扫上面的二维码，加我为好友")
                let xx = hud.show() //.hide(afterDelay: 3)
                xx.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MyTableViewController.hideHUD)))
                
                
                
            }
            
            headerView?.showHeadImage = { [weak self] in
                let alertController = UIAlertController(title: nil, message: "选择操作", preferredStyle: UIAlertControllerStyle.actionSheet)
                alertController.addAction(UIAlertAction(title: "更换头像", style: UIAlertActionStyle.default, handler: { action in
                    showPhotoSlectAlertView()
                }))
                
                alertController.addAction(UIAlertAction(title: "查看大头像", style: UIAlertActionStyle.default, handler: { action in
                    
                }))
                
                alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: { action in
                    
                }))
                
               // alertController.show(self!, sender: nil)
                self?.present(alertController, animated: true, completion: nil)
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

extension MyTableViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
   
    //MARK - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

    let image = info["UIImagePickerControllerEditedImage"] as! UIImage;
    
 
    picker.dismiss(animated: true, completion: nil)
    //NSData *data = UIImageJPEGRepresentation(image, 0.7f);
   // [self updatePortraitWithData:data];
    }
    
}
