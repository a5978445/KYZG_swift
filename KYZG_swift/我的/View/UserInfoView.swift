//
//  UserInfoVIew.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/27.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class UserInfoView: UIView {
    
    let headimageView = UIImageView()
    let userNameLabel = UILabel()
    let userInfoLabel = UILabel()
    let integralLabel = UILabel()
    
    let setButton = UIButton()
    let codeButton = UIButton()
    var animationView:QuartzCanvasView?
    
    let view_userPortrait:CGFloat = 63
    let userPortrait_width:CGFloat = 80
    
    
    var showQRCode:(()->())?
    var showSet:(()->())?
    var showHeadImage:(()->())?
  
    
    let model = UserInfoViewModel()
    var userinfo:OSCUserInfo? {
        didSet {
            model.user = userinfo;
            
            if model.headimageURL != nil {
                headimageView.kf.setImage(with: URL(string:model.headimageURL!))
            } else {
                headimageView.image = UIImage(named: "default-portrait")
            }
            
            
            userNameLabel.text = model.userName
            userInfoLabel.text = model.userInfo
            integralLabel.text = model.integral
        }
    }
    
    
    
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        addSubviews()
        addLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews()  {
        
        func addHeadImageView() -> Void {
            
            // headimageView.backgroundColor = [UIColor redColor];
            headimageView.contentMode = UIViewContentMode.scaleAspectFit;
            headimageView.layer.cornerRadius = 25;
            headimageView.layer.masksToBounds = true;
            headimageView.image = UIImage(named:"default-portrait")
            
            headimageView.isUserInteractionEnabled = true;
            //   [headimageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clcikImage:)]];
            headimageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UserInfoView.clickImage(gestureRecognizer:))))
            
            self.addSubview(headimageView)
        }
        
        func addUserNameLabel() -> Void {
            
            
            userNameLabel.font = UIFont.systemFont(ofSize: 20)
            userNameLabel.textAlignment = NSTextAlignment.center;
            userNameLabel.numberOfLines = 1;
            userNameLabel.textColor = UIColor.RGB(hex: 0xffffff)
            userNameLabel.text = "点击头像登陆";
            
            self.addSubview(userNameLabel)
            
        }
        
        func addUserInfoLabel() -> Void {
            
            userInfoLabel.font = UIFont.systemFont(ofSize: 13)
            userInfoLabel.textAlignment = NSTextAlignment.center;
            userInfoLabel.numberOfLines = 3;
            userInfoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping;
            userInfoLabel.textColor = UIColor.RGB(hex: 0xffffff)
            userInfoLabel.text = "该用户还没有填写描述...";
            userInfoLabel.preferredMaxLayoutWidth = kScreenWidth - 60 ;
            self.addSubview(userInfoLabel)
            
        }
        
        func addIntegralLabel() -> Void {
            
            integralLabel.font = UIFont.systemFont(ofSize: 13)
            integralLabel.textAlignment = NSTextAlignment.center;
            integralLabel.numberOfLines = 1;
            integralLabel.textColor = UIColor.RGB(hex: 0xffffff)
            integralLabel.text = "积分：0";
            self.addSubview(integralLabel)
        }
        
        func addSetButton() -> Void {
            
            setButton.setImage(UIImage(named:"btn_my_setting"), for: UIControlState.normal)
            
            setButton.addTarget(self, action: #selector(UserInfoView.setAction(button:)), for: UIControlEvents.touchUpInside)
            
            self.addSubview(setButton)
            
        }
        
        func addCodeButton() -> Void {
            
            codeButton.setImage(UIImage(named:"btn_qrcode"), for: UIControlState.normal)
            
            codeButton.addTarget(self, action: #selector(UserInfoView.codeAction(button:)), for: UIControlEvents.touchUpInside)
            self.addSubview(codeButton)
        }
        
        func addDrawView() -> Void {
            
            let viewHeight = self.frame.height;
            
            animationView = QuartzCanvasView(frame: self.bounds)
            animationView?.minimumRoundRadius = userPortrait_width * 0.5 + 30;
            // animationView.openRandomness = NO;
            // animationView.duration = 25;
            animationView?.backgroundColor = UIColor.RGB(hex: 0x24cf5f)
            animationView?.strokeColor = UIColor.RGB(hex: 0x6FDB94)
            animationView?.offestCenter = CGPoint(x:0,y:view_userPortrait + userPortrait_width * 0.5 - viewHeight * 0.5)
            
            
            
            
            self.addSubview(animationView!)
            self.sendSubview(toBack: animationView!)
        }
        
        addSetButton()
        
        addCodeButton()
        
        addHeadImageView()
        
        addUserNameLabel()
        
        addUserInfoLabel()
        
        
        addIntegralLabel();
        
        addDrawView();
    }
    
    
    
  
    
    func addLayouts()  {
        
        setButton.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(36)
        }
        
        codeButton.snp.makeConstraints { make in
            // make.right.equalToSuperview().offset(-16)
            make.right.equalTo(-16)
            make.top.equalTo(36)
        }
        
        
        
        
        headimageView.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(73)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headimageView.snp.bottom).offset(10)
        }
        
        
        userInfoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
        }
        
        integralLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userInfoLabel.snp.bottom).offset(10)
        }
        
        animationView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        //     [_drawView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.insets(UIEdgeInsetsZero);
        //        }];
        
    }
    
    //MARK:-tapGestureRecognizer
    //   #pragma mark tapGestureRecognizer
    func clickImage(gestureRecognizer:UITapGestureRecognizer)  {
        
        print("clcikImage")
        if showHeadImage != nil {
            showHeadImage!()
        }
        
       
    }
    
    func setAction(button:UIButton)  {
         print("setAction")

        if showSet != nil {
            showSet!()
        }
    }
    
    func codeAction(button:UIButton) {
         print("codeAction")
        if showQRCode != nil {
            showQRCode!()
        }
      
    }
    
    
    
    
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
