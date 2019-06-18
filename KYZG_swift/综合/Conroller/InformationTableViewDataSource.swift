//
//  InformationTableViewDataSource.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/3.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class InformationTableViewDataSource: NSObject,UITableViewDataSource {
    
    var cellModels = [InformationTableViewCellModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellModels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:InformationTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell") as! InformationTableViewCell?
        if cell == nil {
            cell = InformationTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        
        // cell?.textLabel?.text = "hello"
        cell?.model = cellModels[indexPath.row]
        return cell!
    }
}
