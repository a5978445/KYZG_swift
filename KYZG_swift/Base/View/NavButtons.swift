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
    
    private var buttons = [UIButton]()
    
    private var text: String?
    
    private var selectButton: UIButton?
    
    
    // public var reponse = {(x:Int)->Void in }
    
    var reponse: ((Int)->Void)?
    
    var titles: [String]? {
        didSet {
            
            func removeButtons() {
                for button in buttons {
                    button.removeFromSuperview()
                }
                
            }
            
            func defaultButton() -> UIButton {
                let button = UIButton(type: .custom)
                
                button.setTitleColor(UIColor.RGB(hex: 0x909090), for: .normal)
                
                button.setTitleColor(UIColor.RGB(hex: 0x24cf5f), for: .selected)
                button.backgroundColor = UIColor.RGB(hex: 0xf6f6f6)
                
                
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                
                return button
            }
            
            func creatButtons() -> [UIButton] {
                var result = [UIButton]()
                for (index,title) in titles! .enumerated() {
                    let button = defaultButton()
                    button.setTitle(title, for: UIControl.State.normal)
                    
                    button.tag = index
                    
                    button.addTarget(self, action: #selector(self.click(button:)), for: .touchUpInside)
                    result.append(button)
                }
                return result
            }
            
            
            func addSubviews() {
                for button in buttons {
                    addSubview(button)
                }
            }
            
            func addLayouts() {
                let width = frame.width / CGFloat(titles!.count)
                for (index,button) in buttons.enumerated() {
                    button.snp.makeConstraints({ (make) in
                        make.top.equalTo(self)
                        make.width.equalTo(width)
                        make.left.equalTo(width * CGFloat(index))
                        make.height.equalTo(self)
                    })
                }
            }
            
            
            buttons.removeAll()
            
            buttons = creatButtons()
            addSubviews()
            addLayouts()
            
            buttons.first?.isSelected = true
            selectButton = buttons.first
        }
        
    }
    
    
    
 
    
    @objc func click(button: UIButton) -> Void {
        
        // print(button.tag)
        func setSlectedButton() {
            for aButton in buttons {
                aButton.isSelected = false
            }
            
            button.isSelected = true
            selectButton = button
        }
        
        guard selectButton != button else {
            return
        }
        
        setSlectedButton()
        
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



