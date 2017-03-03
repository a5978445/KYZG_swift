//
//  RootViewController.swift
//  KYZG_swift
//
//  Created by LiTengFang on 17/2/22.
//  Copyright © 2017 LiTengFang. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        configureItems()
        
        let comprehensiveVC = (self.viewControllers![0] as! UINavigationController).topViewController as! ComposeViewController
        comprehensiveVC.titles = ["资讯","博客","问答","活动"]
        comprehensiveVC.addChildViewController(InformationTableViewController())
        comprehensiveVC.addChildViewController(BlogTableViewController())
        comprehensiveVC.addChildViewController(QuestionsTableViewController())
        comprehensiveVC.addChildViewController(ActivityTableViewController())
        
        
        let comprehensiveVC2 = (self.viewControllers![1] as! UINavigationController).topViewController as! ComposeViewController
        comprehensiveVC2.titles = ["最新动弹","热门动弹","我的动弹"]
        comprehensiveVC2.addChildViewController(TweetsViewController())
        comprehensiveVC2.addChildViewController(TweetsViewController())
        comprehensiveVC2.addChildViewController(TweetsViewController())
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureItems()  {
        
        func addItems() {
            let centerButton = UIButton(type: UIButtonType.custom)
            
            
            let origin = view.convert(tabBar.center, to: tabBar)
            let buttonSize = CGSize(width: view.frame.size.width/5, height: tabBar.frame.size.height - 4)
            centerButton.frame = CGRect(origin: CGPoint(x:origin.x - buttonSize.width/2,y:origin.y - buttonSize.height/2), size: buttonSize)
            
            centerButton.setImage(UIImage(named:"ic_nav_add"), for: UIControlState.normal)
            centerButton.setImage(UIImage(named:"ic_nav_add_actived"), for: UIControlState.highlighted)
            
            
            
            
            centerButton.addTarget(self,
                                   action:#selector(RootViewController.handleTap),
                                   for: UIControlEvents.touchUpInside)
            
            
            tabBar.addSubview(centerButton)
            
        }
        
        let titles = ["综合", "动弹", "", "发现", "我的"];
        let images = ["tabbar-news", "tabbar-tweet", "", "tabbar-discover", "tabbar-me"];
       
        
        for (index,tabBar) in tabBar.items!.enumerated() {
            tabBar.title = titles[index]
            tabBar.image = UIImage(named: images[index])?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            tabBar.selectedImage = UIImage(named: images[index] + "-selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
        
        tabBar.tintColor = UIColor(colorLiteralRed: 50/255.0, green: 205/255.0, blue: 100/255.0, alpha: 1.0)
        
        tabBar.items?[2].isEnabled = false;
        
        addItems()
    }
    
    
    
    func handleTap()  {
        selectedIndex = 2;
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
