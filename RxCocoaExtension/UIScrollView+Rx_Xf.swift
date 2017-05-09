//
//  UIscroller+RX_Xf.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/5/8.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import RxSwift
import RxCocoa

import Foundation

extension Reactive where Base: UIScrollView {
    public var scrollViewWillBeginDragging: ControlEvent<Void> {
        let source = delegate.methodInvoked(#selector(UIScrollViewDelegate.scrollViewWillBeginDragging(_:))).map { _ in }
        return ControlEvent(events: source)
    }
}

