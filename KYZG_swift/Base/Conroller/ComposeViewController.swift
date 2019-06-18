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
    
    private lazy var buttons = { () -> NavButtons  in
        let result = NavButtons(frame: CGRect(x: 0, y: 64, width:kScreenWidth, height: 44))
        result.reponse = {
            
            guard $0 < self.children.count else {
                return
            }
            
            self.updateContentView(addChildVC: self.children[$0], toRomoveChildVC: self.currentVC)
             
            self.currentVC = self.children[$0]
            
        }
        return result
    }()
    
    private let contentView = UIView()
    private var currentVC:UIViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        addSubViews()
        
        currentVC = children[0]
        
        
        updateContentView(addChildVC: currentVC!, toRomoveChildVC: nil)
        
    }
 
    
    func addSubViews() -> Void {
        view.addSubview(buttons)
        view.addSubview(contentView)
        

        
       
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
    
    
    // MARK: override method
    override func updateViewConstraints() {
        
        
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
        
        super.updateViewConstraints()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

