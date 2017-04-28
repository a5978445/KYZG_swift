//
//  MyTableViewDataSource.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/3.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class MyTableViewDataSource: NSObject,UITableViewDataSource {
    
    var model:[CellModel] = [CellModel]()
    
    
    private override init() {
        
    }
    
    public convenience init(model:[CellModel]) {
        self.init()
        self.model = model

    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = model[indexPath.row].title;
        cell?.imageView?.image = UIImage(named:model[indexPath.row].imageName!);
        //tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        
        return cell!
    }
}
