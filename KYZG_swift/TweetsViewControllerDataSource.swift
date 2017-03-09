//
//  TweetsViewControllerDataSource.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/8.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class TweetsViewControllerDataSource: NSObject,UITableViewDataSource {
    var models = [TweetModel]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.row]
        
        var cell:TweetTableViewCell? = tableView.dequeueReusableCell(withIdentifier: model.reuseIdentifier) as! TweetTableViewCell?
        if cell == nil {
         //   cell = TweetTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: model.reuseIdentifier)
            cell = TweetTableViewCell.init(reuseIdentifier: model.reuseIdentifier, model: model)
        }
     //   cell?.textLabel?.text = "hello world!"
        cell?.model = models[indexPath.row]
        return cell!
    }
}
