//
//  MyTableHeaderView.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/27.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class MyTableHeaderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var userInfoView:UserInfoView
    var userInfoButton:UserInfoButtons
    var userInfo:OSCUserInfo? {
        didSet {
      
            
            userInfoButton.titles = [MultistageTitle(title: (userInfo?.score?.description),subTitle: "动弹"),
                                     MultistageTitle(title:userInfo?.favorite_count?.description,subTitle: "收藏"),
                                     MultistageTitle(title: userInfo?.fans?.description,subTitle: "关注"),
                                     MultistageTitle(title: userInfo?.followers?.description,subTitle: "粉丝")]
            
            userInfoView.userinfo = userInfo
        }
    }
    
    
    
    var showQRCode:(()->())?
    var showSet:(()->())? {
        didSet {
            userInfoView.showSet = showSet
        }
    }
    var showHeadImage:(()->())? 
    var showLogin:(()->())?
    
    let userInfoButtonHeight:CGFloat = 64.0
    
    override init(frame: CGRect) {
        userInfoView = UserInfoView(frame: frame)
       
        userInfoView.backgroundColor = UIColor.RGB(hex: 0x24CF5F) 
        
        userInfoButton = UserInfoButtons(frame: CGRect(x: 0, y: 0, width: frame.width, height: userInfoButtonHeight))
        userInfoButton.backgroundColor = UIColor.RGB(r: 44, g: 183, b: 90)
        userInfoButton.titles = [MultistageTitle(title: "0",subTitle: "动弹"),
                                 MultistageTitle(title: "0",subTitle: "收藏"),
                                 MultistageTitle(title: "0",subTitle: "关注"),
                                 MultistageTitle(title: "0",subTitle: "粉丝")]// 动弹，收藏，关注，粉丝
        
        super.init(frame: frame)
        
        userInfoView.showQRCode = {[weak self] in
            if self?.userInfo?.id != nil {
                if self?.showQRCode != nil {
                    self?.showQRCode!()
                }
            } else {
                if self?.showLogin != nil {
                    self?.showLogin!()
                }
            }
        }
        
        userInfoView.showHeadImage = {[weak self] in
            if self?.userInfo?.id != nil {
                if self?.showHeadImage != nil {
                    self?.showHeadImage!()
                }
            } else {
                if self?.showLogin != nil {
                    self?.showLogin!()
                }
            }
        }
        
        self.addSubview(userInfoView)
        self.addSubview(userInfoButton)
        
        userInfoView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        userInfoButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(userInfoView.snp.bottom)
            make.height.equalTo(userInfoButtonHeight)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
