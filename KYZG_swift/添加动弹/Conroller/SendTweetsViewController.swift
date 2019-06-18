//
//  SendTweetsViewController.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/4.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class SendTweetsViewController: UIViewController {

    let textView = PlaceholderTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "谈一谈"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style: UIBarButtonItem.Style.done, target: self, action: #selector(SendTweetsViewController.cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发送", style: UIBarButtonItem.Style.done, target: self, action: #selector(SendTweetsViewController.send))
        
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        textView.backgroundColor = UIColor.white
        textView.placeholder = "今天你动弹了吗"
    //     textView.text = "see hello World!"
    }
    
    func cancel() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func send()  {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
