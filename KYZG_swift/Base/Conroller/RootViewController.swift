//
//  RootViewController.swift
//  KYZG_swift
//
//  Created by LiTengFang on 17/2/22.
//  Copyright © 2017 LiTengFang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RootViewController: UITabBarController {
    
    private let disposeBag = DisposeBag()
    private let titles = ["综合", "动弹", "", "发现", "我的"];
    private let images = ["tabbar-news", "tabbar-tweet", "", "tabbar-discover", "tabbar-me"];
    private lazy var selectedImages: [String] = {() -> [String] in return self.images.map { $0 + "-selected" }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        configureItems()
        
        
        configureViewControllers()
        
        
        //   print(rx.delegate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureViewControllers() {
        let comprehensiveVC = (self.viewControllers![0] as! UINavigationController).topViewController as! ComposeViewController
        comprehensiveVC.titles = ["资讯","博客","问答","活动"]
        comprehensiveVC.addChildViewController(InformationTableViewController())
        comprehensiveVC.addChildViewController(BlogTableViewController())
        comprehensiveVC.addChildViewController(QuestionsTableViewController())
        comprehensiveVC.addChildViewController(ActivityTableViewController())
        
        
        let comprehensiveVC2 = (self.viewControllers![1] as! UINavigationController).topViewController as! ComposeViewController
        comprehensiveVC2.titles = ["最新动弹","热门动弹","我的动弹"]
        
        let TweetsViewController_1 = TweetsViewController()
        TweetsViewController_1.tweetType = .newTweet
        TweetsViewController_1.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0)
        
        let TweetsViewController_2 = TweetsViewController()
        TweetsViewController_2.tweetType = .hotTweet
        TweetsViewController_2.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0)
        
        let TweetsViewController_3 = TweetsViewController()
        TweetsViewController_3.tweetType = .myTweet
        TweetsViewController_3.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0)
        
        comprehensiveVC2.addChildViewController(TweetsViewController_1)
        comprehensiveVC2.addChildViewController(TweetsViewController_2)
        comprehensiveVC2.addChildViewController(TweetsViewController_3)
    }
    
    private func configureItems()  {
        
        func addCenterButton() {
            
            func centerButton() -> UIButton {
                
                func centerButtonframe() -> CGRect {
                    let origin = view.convert(tabBar.center, to: tabBar)
                    let buttonSize = CGSize(width: view.frame.width / 5, height: tabBar.frame.height - 4)
                    return CGRect(origin: CGPoint(x:origin.x - buttonSize.width / 2,y:origin.y - buttonSize.height / 2), size: buttonSize)
                }
                
                let centerButton = UIButton(type: .custom)
                
                
                centerButton.frame = centerButtonframe()
                
                centerButton.setImage(UIImage(named:"ic_nav_add"), for: .normal)
                centerButton.setImage(UIImage(named:"ic_nav_add_actived"), for:.highlighted)
                
                
                
                centerButton.rx.tap.subscribe(onNext: {[unowned self] _ in
                    let temp = self.selectedIndex
                    self.selectedIndex = 2;
                    
                    let VC = NavigationController(rootViewController: SendTweetsViewController())
                    self.present(VC, animated: true, completion: {
                        self.selectedIndex = temp
                    })
                })
                    .disposed(by: disposeBag)
                return centerButton
            }
            
            
            
            
            tabBar.addSubview(centerButton())
            
        }
        
        for (index,tabBar) in tabBar.items!.enumerated() {
            tabBar.title = titles[index]
            tabBar.image = UIImage(named: images[index])?.withRenderingMode(.alwaysOriginal)
            tabBar.selectedImage = UIImage(named: selectedImages[index])?.withRenderingMode(.alwaysOriginal)
        }
        
        tabBar.tintColor = UIColor(colorLiteralRed: 50/255.0, green: 205/255.0, blue: 100/255.0, alpha: 1.0)
        
        tabBar.items?[2].isEnabled = false;
        
        addCenterButton()
    }
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
