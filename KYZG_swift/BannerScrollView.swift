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
    private var imgViews:[UIImageView] = []
    
    private var pageCtrl = { () -> UIPageControl in
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.RGB(r: 74, g: 210, b: 240)
        return pageControl;
    }()
    
    private lazy var contentView = { () -> UIScrollView in
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self;
        return scrollView
    }()
    
    private var timer:Timer?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(contentView)
        addSubview(pageCtrl)
        

        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        pageCtrl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(10)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        super.updateConstraints()
    }
    
    override func removeFromSuperview() {
         timer?.invalidate()
        super.removeFromSuperview()
    }
    
    // MARK: interface
    var urls:[String]? {
        didSet {
            func removeOldImageViews() {
                for imageView in imgViews {
                    imageView.removeFromSuperview()
                }
            }
            
            
            func addNewImageViews() {
                imgViews = { () -> [UIImageView] in
                    var result = [UIImageView]()
                    for url in urls! {
                        let aImageView = UIImageView()
                        
                        aImageView.kf.setImage(with: URL(string: url))
                        result.append(aImageView)
                    }
                    return result
                }()
                
                for imageView in imgViews {
                    contentView.addSubview(imageView)
                }
            }
            
            func addImageViewsLayout() {
                for (index,aImageView) in imgViews.enumerated() {
                    
                    
                    aImageView.snp.makeConstraints({ make in
                        make.top.equalToSuperview()
                        make.height.equalToSuperview()
                        make.width.equalToSuperview()
                        make.bottom.equalToSuperview()
                        make.left.equalToSuperview().offset( CGFloat(index) * frame.width)
                        if imgViews.last == aImageView {
                            make.right.equalToSuperview().offset(0)
                        }
                    })
                }
            }
            
            removeOldImageViews()
            imgViews.removeAll()
            
            addNewImageViews()
            addImageViewsLayout()
        
            pageCtrl.currentPage = 0
            pageCtrl.numberOfPages = (urls?.count)!
        }
    }
    
    func cancelTimer() {
        timer?.invalidate()
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: fireTime,
                                     target: self,
                                     selector: #selector(self.fire(aTimer:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    
    
    // MARK: UIScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        pageCtrl.currentPage = (Int)(scrollView.contentOffset.x / scrollView.frame.width);
        timer?.fireDate = Date().addingTimeInterval(fireTime)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.fireDate = (timer?.fireDate.addingTimeInterval(TimeInterval(CGFloat.greatestFiniteMagnitude)))!
    }
    
    // MARK: timer fire
    func fire(aTimer:Timer) {
        if (urls != nil) && pageCtrl.currentPage + 1 >= urls!.count{
            contentView.setContentOffset(CGPoint.zero, animated: false)
            pageCtrl.currentPage = 0
        } else {
            contentView.setContentOffset(CGPoint(x:contentView.contentOffset.x + contentView.frame.width,y:0), animated: true)
            pageCtrl.currentPage += 1
        }
        print("zhazhazhazha")
    }
    
    /*
     #pragma mark - UIScrollViewDelegate
     - (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
     timer.fireDate = [timer.fireDate dateByAddingTimeInterval:MAXFLOAT];
     }
     
     - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     //   NSLog(@"hello!");
     _pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
     timer.fireDate = [[NSDate date] dateByAddingTimeInterval:FIREtimer];
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
