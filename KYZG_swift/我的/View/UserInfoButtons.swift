//
//  UserInfoButtons.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/27.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

struct MultistageTitle {
    var title:String
    var subTitle:String
    
    init(title:String?,subTitle:String) {
        self.title = title ?? "0"
        self.subTitle = subTitle
    }
    
}

class UserInfoButtons: UIView {

    var titles:[MultistageTitle]? {
        didSet {
            
            guard titles != nil else {
                return
            }
            
            for button in buttons {
                button.removeFromSuperview()
            }
            
            buttons.removeAll()
            
            let buttonWidth = frame.width / (CGFloat)(titles!.count)
            let buttonHeight = frame.height;
            for (index,aMultistageTitle) in titles!.enumerated() {
                
                
                let button = UIButton(frame: CGRect(x: buttonWidth * (CGFloat)(index), y: 0, width: buttonWidth, height: buttonHeight))
                
                button.setAttributedTitle(attributedString(aMultistageTitle: aMultistageTitle), for: UIControl.State.normal)
                button.titleLabel?.numberOfLines = 0;
                button.titleLabel?.textAlignment = NSTextAlignment.center;
                
                buttons.append(button)
                
                self.addSubview(button)
                
                
            }
        }
    }
    
    var buttons = [UIButton]()
    
    
    func attributedString(aMultistageTitle:MultistageTitle) -> NSAttributedString {
        
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 24),
                          NSAttributedString.Key.foregroundColor:UIColor.white]
        
        let title = NSAttributedString(string: aMultistageTitle.title, attributes:attributes)
        
        
        let fenGe = NSAttributedString(string: "\n", attributes:[NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12),
                                                                 NSAttributedString.Key.foregroundColor:UIColor.white])
        
        let subTitle = NSAttributedString(string: aMultistageTitle.subTitle,
                                          attributes:[NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12),
                                                      NSAttributedString.Key.foregroundColor:UIColor.white])
        
        
        
        let result = NSMutableAttributedString(attributedString: title)
        result.append(fenGe)
        result.append(subTitle)
        
        
        
        return result;
    }
    
 
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
