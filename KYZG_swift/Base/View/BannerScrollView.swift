//
//  BannerScrollView.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/24.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa
//import RxGesture
//import RxCocoa.UIGestureRecognizer+Rx

class BannerScrollView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    //MARK: public property
    var didSelect: ((_ tag: Int) -> ())?
    
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
                    for (index,url) in urls!.enumerated() {
                        let aImageView = UIImageView()
                        
                        aImageView.kf.setImage(with: URL(string: url))
                        
                        /*
                         let test = UITapGestureRecognizer()
                         let testReactive = Reactive(test)
                         testReactive.event.asObservable()
                         .subscribe({ event in
                         print("hello world!")
                         })
                         .disposed(by: disposeBag)
                         
                         aImageView.addGestureRecognizer(test)
                         */
                        aImageView.isUserInteractionEnabled = true
                        aImageView.rx.tapGesture().subscribe(onNext: { [unowned self]_ in
                            print("hello world! \(index)")
                            self.didSelect?(index)
                        })
                            .disposed(by: disposeBag)
                        
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
            
            self.timeDisposable?.dispose()
            observableTime =  Observable<Int>.interval(1, scheduler: ConcurrentMainScheduler.instance)
            timeDisposable = observableTime!.filter({[unowned self] in
                $0 % self.time == 0
            })
                .subscribe(onNext: {[weak self] _ in
                    self?.fire()
                })
            
        }
    }
    
    //MARK: private property
    private let disposeBag = DisposeBag()
    
    private var imgViews: [UIImageView] = []
    private var time = 5
    private var observableTime: Observable<Int>?
    private var timeDisposable: Disposable?
    
    // MARK: lazy Load
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
        
        return scrollView
    }()
    
    
    
    

    // MARK: init Method 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentView)
        addSubview(pageCtrl)
        
        contentView.rx.didEndDecelerating.asObservable()
            .subscribe(onNext: { [unowned self] in
                
                self.pageCtrl.currentPage = (Int)(self.contentView.contentOffset.x / self.contentView.frame.width);

                self.time = 5
            })
            .disposed(by: disposeBag)
        
        
        contentView.rx.scrollViewWillBeginDragging.asObservable()
            .subscribe(onNext: { [unowned self] in
                
                self.time = Int(INT32_MAX)

            })
            .disposed(by: disposeBag)
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: override method
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
        //   timer?.invalidate()
        timeDisposable?.dispose()
        super.removeFromSuperview()
        
    }
    
    // MARK: timer fire
    private func fire() {
        if (urls != nil) && pageCtrl.currentPage + 1 >= urls!.count{
            contentView.setContentOffset(CGPoint.zero, animated: false)
            pageCtrl.currentPage = 0
        } else {
            contentView.setContentOffset(CGPoint(x:contentView.contentOffset.x + contentView.frame.width,y:0), animated: true)
            pageCtrl.currentPage += 1
        }
        print("zhazhazhazha")
    }
    
    
    
    
}
