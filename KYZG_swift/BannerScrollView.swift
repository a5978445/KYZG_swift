//
//  BannerScrollView.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/24.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import Kingfisher

class BannerScrollView: UIView,UIScrollViewDelegate {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    let fireTime = 5.0
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        contentView.isPagingEnabled = true
        contentView.showsHorizontalScrollIndicator = false
        contentView.delegate = self;
        
        
        
        
        pageCtrl.currentPage = 0
        pageCtrl.currentPageIndicatorTintColor = UIColor.white
        pageCtrl.currentPageIndicatorTintColor = UIColor.RGB(r: 74, g: 210, b: 240)
        
        self.addSubview(contentView)
        self.addSubview(pageCtrl)
        
        pageCtrl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(10)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open var urls:[String]? {
        didSet {
            for imageView in imgViews {
                imageView.removeFromSuperview()
            }
            
            imgViews .removeAll()
            
            for (index,url) in urls!.enumerated() {
                let aImageView = UIImageView()
                
                aImageView.kf.setImage(with: URL(string: url))
                contentView.addSubview(aImageView)
                
                aImageView.snp.makeConstraints({ make in
                    make.top.equalToSuperview()
                    make.height.equalToSuperview()
                    make.width.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.left.equalToSuperview().offset( CGFloat(index) * self.frame.size.width)
                    if urls?.last == url {
                        make.right.equalToSuperview().offset(0)
                    }
                })
                
                
            }
            
            startTimer()
            
            pageCtrl.currentPage = 0
            pageCtrl.numberOfPages = (urls?.count)!
        }
    }
    
    open func cancelTimer() -> Void {
        _timer?.invalidate()
    }
    
    open func startTimer() -> Void {
        _timer?.invalidate()
        _timer = Timer.scheduledTimer(timeInterval: fireTime, target: self, selector: #selector(self.fire(aTimer:)), userInfo: nil, repeats: true)
    }
    
    private  var imgViews:[UIImageView] = []
    
    private var pageCtrl = UIPageControl()
    
    private var contentView = UIScrollView()
    
    private var _timer:Timer?
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        pageCtrl.currentPage = (Int)(scrollView.contentOffset.x / scrollView.frame.size.width);
        _timer?.fireDate = Date().addingTimeInterval(fireTime)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _timer?.fireDate = (_timer?.fireDate.addingTimeInterval(TimeInterval(CGFloat.greatestFiniteMagnitude)))!
    }
    
    func fire(aTimer:Timer) -> Void {
        if (urls != nil) && pageCtrl.currentPage + 1 >= urls!.count{
            contentView.setContentOffset(CGPoint.zero, animated: false)
            pageCtrl.currentPage = 0
        } else {
            contentView.setContentOffset(CGPoint(x:contentView.contentOffset.x + contentView.frame.size.width,y:0), animated: true)
            pageCtrl.currentPage += 1
        }
        print("zhazhazhazha")
    }
    
    /*
     #pragma mark - UIScrollViewDelegate
     - (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
     _timer.fireDate = [_timer.fireDate dateByAddingTimeInterval:MAXFLOAT];
     }
     
     - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     //   NSLog(@"hello!");
     _pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
     _timer.fireDate = [[NSDate date] dateByAddingTimeInterval:FIRE_TIMER];
     }
     
     #pragma mark - imageView tapGestureRecognizer
     - (void)tap:(UITapGestureRecognizer *)tapGestureRecognizer {
     NSInteger tag = tapGestureRecognizer.view.tag;
     if (_block) {
     _block(tag);
     }
     }
     */
    
    
}
