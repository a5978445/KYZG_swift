//
//  PlaceholderTextView.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/4.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class PlaceholderTextView: UITextView {
    var placeholder:String? {
        didSet {
            placeholderView.text = placeholder
        }
    }
    let kTextKey = "text"
    let placeholderView = UITextView()
    
    override var font: UIFont? {
        didSet {
            placeholderView.font = font;
        }
    }
    
    override var textAlignment: NSTextAlignment {
        didSet {
            placeholderView.textAlignment = textAlignment;
        }
    }
    
    override var contentInset: UIEdgeInsets {
        didSet {
            placeholderView.contentInset = contentInset
        }
    }
    
    override var contentOffset: CGPoint {
        didSet {
            placeholderView.contentOffset = contentOffset
        }
    }
    
    override var textContainerInset: UIEdgeInsets {
        didSet {
            placeholderView.textContainerInset = textContainerInset
        }
    }
    
    func setUpPlaceholderView() {
        
        
        placeholderView.isEditable = false;
        placeholderView.isScrollEnabled = false;
        placeholderView.showsHorizontalScrollIndicator = false;
        placeholderView.showsVerticalScrollIndicator = false;
        placeholderView.isUserInteractionEnabled = false;
        placeholderView.font = font;
        placeholderView.contentInset = contentInset;
        placeholderView.contentOffset = contentOffset;
        placeholderView.textContainerInset = textContainerInset;
        placeholderView.textColor = UIColor.RGB(hex: 0xc8c8ce)
        placeholderView.backgroundColor = UIColor.clear
        addSubview(placeholderView)

        
        NotificationCenter.default.addObserver(self, selector: #selector(PlaceholderTextView.textDidChange(notification:)), name: UITextView.textDidChangeNotification, object: nil)
     
        addObserver(self, forKeyPath: kTextKey, options: .new, context: nil)
        
        
    }
    
    @objc func textDidChange(notification:NSNotification) {
        
        placeholderView.isHidden = hasText
        
    }
    
    override  init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        font = UIFont.systemFont(ofSize: 14)
        textColor = UIColor.black
        setUpPlaceholderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if (keyPath == kTextKey) {
            placeholderView.isHidden = hasText
        }
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        placeholderView.frame = bounds
    }
    
    deinit {
        removeObserver(self, forKeyPath: kTextKey)
        NotificationCenter.default.removeObserver(self)
   
    }
    
   
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
