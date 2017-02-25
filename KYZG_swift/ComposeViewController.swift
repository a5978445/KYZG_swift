//
//  ViewController.swift
//  KYZG_swift
//
//  Created by LiTengFang on 17/2/22.
//  Copyright © 2017 LiTengFang. All rights reserved.
//

import UIKit
import SnapKit

class ComposeViewController: UIViewController {
    
    open var titles:[String]? {
        didSet {
            buttons.titles = titles
        }
    }
    
    let buttons = NavButtons(frame: CGRect(x: 0, y: 64, width:kScreenWidth, height: 44))
    let contentView = UIView()
    var currentVC:UIViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        addSubViews()
        
        currentVC = self.childViewControllers[0]
        
        
        self.updateContentView(addChildVC: currentVC!, toRomoveChildVC: nil)
        
    }
 
    
    func addSubViews() -> Void {
        self.view.addSubview(buttons)
        self.view.addSubview(contentView)
        
        buttons.reponse = { (x:Int) ->Void in
            if x < self.childViewControllers.count {
                
                self.updateContentView(addChildVC: self.childViewControllers[x], toRomoveChildVC: self.currentVC)
                self.currentVC = self.childViewControllers[x]
                //  self.currentVC?.didMove(toParentViewController: self)
            }
            print(x)
        }
        
        buttons.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(64)
            make.height.equalTo(44)
            make.width.equalTo(kScreenWidth)
        }
        contentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(buttons.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
       
    }
    
    func updateContentView(addChildVC:UIViewController,toRomoveChildVC:UIViewController?) -> Void {
        
        if toRomoveChildVC != nil {
            toRomoveChildVC!.view.removeFromSuperview()
        }
        
        contentView.addSubview(addChildVC.view)
        addChildVC.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

