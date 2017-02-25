//
//  NavButtons.swift
//  KYZG_swift
//
//  Created by LiTengFang on 17/2/22.
//  Copyright © 2017 LiTengFang. All rights reserved.
//

import UIKit
import SnapKit


class NavButtons: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    var buttons = [UIButton]()
    
    var text:String?
    
    
    // public var reponse = {(x:Int)->Void in }
    
    public var reponse:((Int)->Void)?
    
    public var titles:[String]? {
        didSet {
            for button in buttons {
                button.removeFromSuperview()
            }
            
            buttons.removeAll()
            
            addButtons()
            
            buttons.first?.isSelected = true
            
        }
        
    }
    
    
    func defaultButton() -> UIButton {
        let button = UIButton(type: UIButtonType.custom)
        
        button.setTitleColor(UIColor.RGB(hex: 0x909090), for: UIControlState.normal)
        
        button.setTitleColor(UIColor.RGB(hex: 0x24cf5f), for: UIControlState.selected)
        button.backgroundColor = UIColor.RGB(hex: 0xf6f6f6)
        
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        return button
    }
    
    
    func addButtons() -> Void {
        for (index,title) in titles! .enumerated() {
            let button = defaultButton()
            buttons.append(button)
            
            button.setTitle(title, for: UIControlState.normal)
            
            button.tag = index
            
            button.addTarget(self, action: #selector(self.click(button:)), for: UIControlEvents.touchUpInside)
            
            self.addSubview(button)
            
            //0x24CF5F
            
            button.snp.makeConstraints({ (make) in
                make.top.equalTo(self)
                make.width.equalTo(self).multipliedBy(1.0 / Double(titles!.count))
                make.left.equalTo(self).offset(Double((titles?.index(of: title))!) * Double(self.frame.size.width) / Double(titles!.count))
                make.height.equalTo(self)
            })
            
        }
        
    }
    
    func click(button:UIButton) -> Void {
        
        // print(button.tag)
        
        for aButton in buttons {
            aButton.isSelected = false
        }
        
        button.isSelected = true
        
        if reponse != nil {
            reponse!(button.tag)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



