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
            _placeholderView.text = placeholder
        }
    }
    let kTextKey = "text"
    let _placeholderView = UITextView()
    
    override var font: UIFont? {
        didSet {
            _placeholderView.font = font;
        }
    }
    
    override var textAlignment: NSTextAlignment {
        didSet {
            _placeholderView.textAlignment = textAlignment;
        }
    }
    
    override var contentInset: UIEdgeInsets {
        didSet {
            _placeholderView.contentInset = contentInset
        }
    }
    
    override var contentOffset: CGPoint {
        didSet {
            _placeholderView.contentOffset = contentOffset
        }
    }
    
    override var textContainerInset: UIEdgeInsets {
        didSet {
            _placeholderView.textContainerInset = textContainerInset
        }
    }
    
    func setUpPlaceholderView() {
        
        
        _placeholderView.isEditable = false;
        _placeholderView.isScrollEnabled = false;
        _placeholderView.showsHorizontalScrollIndicator = false;
        _placeholderView.showsVerticalScrollIndicator = false;
        _placeholderView.isUserInteractionEnabled = false;
        _placeholderView.font = self.font;
        _placeholderView.contentInset = self.contentInset;
        _placeholderView.contentOffset = self.contentOffset;
        _placeholderView.textContainerInset = self.textContainerInset;
        _placeholderView.textColor = UIColor.RGB(hex: 0xc8c8ce)
        _placeholderView.backgroundColor = UIColor.clear
        self.addSubview(_placeholderView)

        
        NotificationCenter.default.addObserver(self, selector: #selector(PlaceholderTextView.textDidChange(notification:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
     
        self.addObserver(self, forKeyPath: kTextKey, options: NSKeyValueObservingOptions.new, context: nil)
        
        
    }
    
    func textDidChange(notification:NSNotification) {
        
        _placeholderView.isHidden = self.hasText
        
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
            _placeholderView.isHidden = self.hasText
        }
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        _placeholderView.frame = self.bounds
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: kTextKey)
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
