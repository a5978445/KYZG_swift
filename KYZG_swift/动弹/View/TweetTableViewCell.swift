//
//  TweetTableViewCell.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/6.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit





class TweetTableViewCell: UITableViewCell {
    
    
    class BodyView: UIView {
        
        
        class AboutView: UIView {
            var about: OSCAbout? {
                didSet {
                    titleLabel.text = about?.title
                    contentLabel.text = about?.content
                }
            }
            
            var titleLabel = UILabel()
            
            var contentLabel = UILabel()
            
            override init(frame: CGRect) {
                
                
                
                
                
                
                super.init(frame: frame)
                
                titleLabel.numberOfLines = 0
                contentLabel.numberOfLines = 0
                
                titleLabel.textColor = UIColor.green
                contentLabel.textColor = UIColor.black
                titleLabel.font = UIFont.systemFont(ofSize: 14)
                contentLabel.font = UIFont.systemFont(ofSize: 14)
                
                self.addSubview(titleLabel)
                self.addSubview(contentLabel)
                
                titleLabel.snp.makeConstraints { make in
                    make.left.equalTo(8)
                    make.right.equalTo(-8)
                    make.top.equalTo(2)
                }
                
                contentLabel.snp.makeConstraints { make in
                    make.left.equalTo(8)
                    make.right.equalTo(-8)
                    make.top.equalTo(titleLabel.snp.bottom).offset(8)
                    make.bottom.equalToSuperview().offset(-8)
                }
            }
            
            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
        }
        
        
        let contentLable = UILabel()
        var infoType: InfoType?
        var text: String? {
            didSet {
                contentLable.text = text
            }
        }
        var singleImage: OSCNetImage? {
            didSet {
                
           
                
                
                singleImageView?.kf.setImage(with: URL(string: (singleImage?.thumb)!))
                singleImageView?.snp.updateConstraints({ make in
                    make.width.equalTo(calculateSize().width)
                    make.height.equalTo(calculateSize().height)
                })
            }
        }
        
        
        var aboutView: AboutView?
        var singleImageView: UIImageView?
        
        var about:OSCAbout? {
            didSet {
                aboutView?.about = about
            }
        }
        
        
        var suggestHeight: CGFloat {
            
           get {
                
                func contentLabelHeight() ->CGFloat {
                    return contentLable.textRect(forBounds: CGRect(x:CGFloat(0),y:CGFloat(0),width:self.frame.width,height:CGFloat.greatestFiniteMagnitude), limitedToNumberOfLines: 0).height
                }
                
                switch infoType! {
                case .about:
                    return contentLabelHeight() + 10 + 60 + 10
                case .normal:
                    return contentLabelHeight()
                default:
                   return contentLabelHeight() + 10 + calculateSize().height + 10
                }
                
            }
        }
        
        func calculateSize() ->CGSize {
      
            let originImageSize = CGSize(width: (singleImage?.w)! / 4, height: (self.singleImage?.h)! / 4)
            let originScale = originImageSize.width / originImageSize.height
            if  originScale > 1 {
                
                if originImageSize.width > self.frame.width / 2 {
                    let width = self.frame.width / 2
                    return CGSize(width: width, height: width / originScale)
                } else {
                    return originImageSize
                }
                
            } else {
                if originImageSize.height > 200 / 2  {
                    let height:CGFloat = 200 / 2
                    return CGSize(width:height * originScale, height: height)
                } else {
                    return originImageSize
                }
            }
        }
        
        private override init(frame: CGRect) {
            super.init(frame: frame)
            
            
        }
        
        convenience init(frame: CGRect,type:InfoType) {
            
            self.init(frame:frame)
            
            self.infoType = type;
            contentLable.font = UIFont.systemFont(ofSize: 14)
            contentLable.numberOfLines = 0
            self.addSubview(contentLable)
          
            
        
            
            switch infoType! {
            case.normal:
                contentLable.snp.makeConstraints { make in
                    make.left.equalTo(0)
                    make.right.equalTo(0)
                    make.top.equalTo(0)
                    make.bottom.equalTo(0)
                }
            case .about:
                aboutView = AboutView(frame: self.frame)
                aboutView?.backgroundColor = UIColor.gray
                self.addSubview(aboutView!)
                
                contentLable.snp.makeConstraints { make in
                    make.left.equalTo(0)
                    make.right.equalTo(0)
                    make.top.equalTo(0)
                   
                }
                
                aboutView!.snp.makeConstraints({ make in
                    make.left.equalTo(0)
                    make.right.equalTo(0)
                    make.top.equalTo(contentLable.snp.bottom).offset(10)
                    make.height.equalTo(60)
                    make.bottom.equalTo(0)
                })
            case .singleImage(let aImageInfo):
                singleImageView = UIImageView()
                self.addSubview(singleImageView!)
                
                
                contentLable.snp.makeConstraints { make in
                    make.left.equalTo(0)
                    make.right.equalTo(0)
                    make.top.equalTo(0)
                   // make.bottom.equalTo(0)
                }
                
                singleImageView?.snp.makeConstraints({ make in
                    make.top.equalTo(contentLable.snp.bottom).offset(10)
                    make.left.equalTo(0)
                //    make.right.equalTo(0)
                    make.width.equalTo(40)
                    make.height.equalTo(40)
                    make.bottom.equalTo(0)
                })
            default:
                contentLable.snp.makeConstraints { make in
                    make.left.equalTo(0)
                    make.right.equalTo(0)
                    make.top.equalTo(0)
                    make.bottom.equalTo(0)
                }
                break
            }
        }
        
        
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }
    
    class BottomView:UIView {
        
        let timeInfoLabel = UILabel()
        let commentButton = UIButton()
        let priaseButton = UIButton()
        let transpondButton = UIButton()
        
        var pubDate:String?
        var appClient:AppClientType?
        
        
        override init(frame:CGRect) {
            super.init(frame: frame)
            
            
            timeInfoLabel.font = UIFont.systemFont(ofSize: 13)
            timeInfoLabel.textColor = UIColor.gray
            timeInfoLabel.text = "2分钟前 Android"
            
            // priaseButton.titleLabel?.textColor = UIColor.gray
            priaseButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            priaseButton.setTitleColor(UIColor.gray, for: UIControlState.normal)
            
            //  commentButton.tintColor = UIColor.gray
            commentButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            commentButton.setTitleColor(UIColor.gray, for: UIControlState.normal)
            
            //  transpondButton.tintColor = UIColor.gray
            transpondButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            transpondButton.setTitleColor(UIColor.gray, for: UIControlState.normal)
            
            
            priaseButton.setTitle("赞", for: UIControlState.normal)
            commentButton.setTitle("评论", for: UIControlState.normal)
            transpondButton.setTitle("转发", for: UIControlState.normal)
            
            self.addSubview(timeInfoLabel)
            self.addSubview(commentButton)
            self.addSubview(priaseButton)
            self.addSubview(transpondButton)
            
            timeInfoLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(15)
            }
            
            priaseButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalTo(commentButton.snp.left)
            }
            
            commentButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalTo(transpondButton.snp.left)
            }
            
            transpondButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-15)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    private var userLabel = UILabel()
    private var portraitImageView = UIImageView()
    
    
    private var bottomView = BottomView()
    private var bodyView: BodyView?
    
    var model:TweetModel? {
        didSet {
            if let name = model?.author?.name  {
                userLabel.text = name
            }
            
            if let portraitURL = model?.author?.portrait {
                portraitImageView.kf.setImage(with: URL(string: portraitURL))
            }
            
            if let pubDate = model?.pubDate {
                
                func getDeviceType() -> String {
                    switch model!.appClient! {
                    case .AppClientType_Android:
                        return "Android"
                    case .AppClientType_iPhone:
                        return "iPhone"
                    default:
                        return ""
                    }
                }
                
                let date = Date(dateString: pubDate, format: "yyyy-MM-dd HH:mm:ss")
                
                
                
                
                bottomView.timeInfoLabel.text = date.timeAgoSinceNow + " " + getDeviceType();
                
               
            }
            
            if model?.images?.count == 1 {
                bodyView?.singleImage = model?.images?.first
            }
            
            if model?.about != nil{
                bodyView?.about = model?.about
            }
            
            bodyView!.text = model?.content
            bodyView!.snp.updateConstraints({ make in
                make.height.equalTo(bodyView!.suggestHeight)
            })
        }
    }
    
    
    
    
    override func awakeFromNib() {
        
        // Initialization code
        fatalError("awakeFromNib has not been implemented")
    }
    
    convenience init(reuseIdentifier: String?,model:TweetModel) {
        
        
        self.init(style:UITableViewCellStyle.default,reuseIdentifier:reuseIdentifier)
        
        bodyView = BodyView(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 75, height: 0),type:model.infoType)
        
        userLabel.font = UIFont.systemFont(ofSize: 15)
        
        contentView.addSubview(userLabel)
        contentView.addSubview(portraitImageView)
        contentView.addSubview(bodyView!)
        contentView.addSubview(bottomView)
        
        //  bodyView.backgroundColor = UIColor.red
        //   bottomView.backgroundColor = UIColor.gray
        
        portraitImageView.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        userLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(portraitImageView.snp.right).offset(15)
        }
        
        bodyView!.snp.makeConstraints { make in
            make.top.equalTo(userLabel.snp.bottom).offset(10)
            make.left.equalTo(userLabel)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(bodyView!.snp.bottom).offset(10)
            make.left.equalTo(userLabel)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(30)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        self.model = model
    }
    
    private override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style:style,reuseIdentifier:reuseIdentifier)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


