//
//  NewsTableViewCellModel.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/25.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import DateToolsSwift

// 注：由HandyJSON生产的model，无法触发didSet事件
class InformationTableViewCellModel: NSObject {
    
    var attributedTittle: NSAttributedString? {
        return getAttributedTittle()
    }
    var attributedCommentCount: NSAttributedString? {
        return getAttributedCommentCount()
    }
    var bodyString: NSAttributedString? {
        return getBodyString()
    }
    var timeString: NSAttributedString? {
        return getTimeString()
    }
    private var information: OSCInformation {
        didSet {
//            attributedTittle = getAttributedTittle()
//            attributedCommentCount = getAttributedCommentCount()
//            bodyString = getBodyString()
//            timeString = getTimeString()
  //          print("asdbasldjal")
            
        }
    }
    
    public init(information: OSCInformation) {
        self.information = information
    }
    
    
    // MARK: private method 
    private func getAttributedTittle() -> NSAttributedString {
        
        var result: NSMutableAttributedString
        
        let date = Date(dateString: information.pubDate!, format: "yyyy-MM-dd HH:mm:ss")
        if (date.isToday) {
            let textAttachment = NSTextAttachment()
            textAttachment.image = UIImage(named:"widget_taday");
            //      [textAttachment adjustY:-2];
            let attachmentString = NSAttributedString(attachment: textAttachment)
            
            result = NSMutableAttributedString(attributedString: attachmentString)
            result.append(NSAttributedString(string: " "))
            
            result.append(NSAttributedString(string: information.title!))
            
        } else {
            result = NSMutableAttributedString(string: information.title!)
            
        }
        
        
        return result;
    }
    
    private func getAttributedCommentCount() -> NSAttributedString {
    
            return NSAttributedString(string: "回复：" + String(information.commentCount!),
                                                        attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.gray])
       
    }
    
 
    private func getTimeString() -> NSAttributedString {
        
        let aDate = Date(dateString: information.pubDate!, format: "yyyy-MM-dd HH:mm:ss")
        return  NSAttributedString(string: aDate.timeAgoSinceNow, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.gray])
        
        
    }
    
    private func getBodyString() -> NSAttributedString {
  
            return  NSAttributedString(string: information.body!,
                                            attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.gray])
  
    }
    
}
