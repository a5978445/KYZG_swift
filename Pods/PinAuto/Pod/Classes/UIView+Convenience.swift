//
//  UIView+convenience.swift
//  Pods
//
//  Created by Haizhen Lee on 16/1/20.
//
//

import UIKit

// PinAuo Convenience Method
public extension UIView{
  
  public func pac_size(_ size:CGSize){
      pa_width.eq(size.width).install()
      pa_height.eq(size.height).install()
  }
  
  public func pac_size(_ width:CGFloat,height:CGFloat){
      pa_width.eq(width).install()
      pa_height.eq(height).install()
  }
  
  
  public func pac_size(_ width:CGFloat,aspectRatio:CGFloat = 1){
    pa_width.eq(width).install()
    pa_aspectRatio(aspectRatio).install()
  }
  
  public func pac_aspectRatio(_ ratio:CGFloat){
    pa_aspectRatio(ratio).install()
  }
  
  public func pac_edge(_ edgeInsets:UIEdgeInsets){
    pac_edge(edgeInsets.top, left: edgeInsets.left, bottom: edgeInsets.bottom, right: edgeInsets.right)
  }
  
  public func pac_edge(_ top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0){
    pa_top.eq(top).install()
    pa_leading.eq(left).install()
    pa_trailing.eq(right).install()
    pa_bottom.eq(bottom).install()
  }
  
  public func pac_margin(_ top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0){
    pac_edge(top, left: left, bottom: bottom, right: right)
  }
  
  @nonobjc
  public func pac_edge(_ offset:UIOffset){
    pac_edge(offset.vertical, left: offset.horizontal, bottom: offset.vertical, right: offset.horizontal)
  }
  
  public func pac_center(_ offset:UIOffset){
    pa_centerX.offset(offset.horizontal).install()
    pa_centerY.offset(offset.vertical).install()
  }
  
  public func pac_center(_ xOffset:CGFloat = 0,yOffset:CGFloat = 0){
    pa_centerX.offset(xOffset).install()
    pa_centerY.offset(yOffset).install()
  }
  
  public func pac_horizontal(_ offset:CGFloat = 0){
    pa_leading.eq(offset).install()
    pa_trailing.eq(offset).install()
  }
  
  public func pac_vertical(_ offset:CGFloat = 0){
    pa_top.eq(offset).install()
    pa_bottom.eq(offset).install()
  }
  
}
