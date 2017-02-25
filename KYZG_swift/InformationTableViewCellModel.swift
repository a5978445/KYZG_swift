//
//  NewsTableViewCellModel.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/25.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import DateToolsSwift

class InformationTableViewCellModel: NSObject {
    
    private var attributedTittle:NSMutableAttributedString?
    private var attributedCommentCount:NSAttributedString?
    private var bodyString:NSAttributedString?
    private var timeString:NSAttributedString?
    private var information:OSCInformation {
        didSet {
            attributedTittle = nil
            attributedCommentCount = nil
            bodyString = nil
            timeString = nil
        }
    }
    
    public init(information:OSCInformation) {
        self.information = information
    }
    
    open func getAttributedTittle()->NSAttributedString {
        if attributedTittle == nil {
            let date = Date(dateString: information.pubDate!, format: "yyyy-MM-dd HH:mm:ss")
            if (date.isToday) {
                let textAttachment = NSTextAttachment()
                textAttachment.image = UIImage(named:"widget_taday");
                //      [textAttachment adjustY:-2];
                let attachmentString = NSAttributedString(attachment: textAttachment)
                
                attributedTittle = NSMutableAttributedString(attributedString: attachmentString)
                attributedTittle?.append(NSAttributedString(string: " "))
                
                attributedTittle?.append(NSAttributedString(string: information.title!))
                
            } else {
                attributedTittle = NSMutableAttributedString(string: information.title!)
                
            }
        }
        
        return attributedTittle!;
    }
    
    open func getAttributedCommentCount()->NSAttributedString {
        if attributedCommentCount == nil {
          //   attributedCommentCount = [Utils attributedCommentCount:_information.commentCount];
           
            
            attributedCommentCount = NSAttributedString(string: "回复：" + String(information.commentCount!.intValue), attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.gray])
        }
        
        return attributedCommentCount!
    }
    
 
    open func getTimeString()->NSAttributedString {
        if timeString == nil {
            let aDate = Date(dateString: information.pubDate!, format: "yyyy-MM-dd HH:mm:ss")
            timeString = NSAttributedString(string: aDate.timeAgoSinceNow, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.gray])
        }
        return timeString!
        
    }
    
    open func getBodyString()->NSAttributedString {
        if bodyString == nil {
         
            bodyString = NSAttributedString(string: information.body!, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.gray])
        }
        return bodyString!
        
    }
    
}
