//
//  InformationTableViewController.swift
//  KYZG_swift
//
//  Created by LiTengFang on 17/2/23.
//  Copyright © 2017 LiTengFang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MJRefresh


class InformationTableViewController: UITableViewController {
    
    let imageScrollView = BannerScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 144))
    
    var model = InformationTableViewControllerModel()
    var cellModels = [InformationTableViewCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.tableHeaderView = imageScrollView
        self.tableView.tableHeaderView?.backgroundColor = UIColor.red
        self.tableView.backgroundColor = UIColor.green
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0)
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
          //  [weak self] in
          //  self.reqeustNews()
            self.model.refreshNews(complete: { (models:[InformationTableViewCellModel]?, error:NSError?) in
                if error == nil {
                    self.cellModels = models!
                    self.tableView.reloadData()
                } else { //to do待处理
                    print(error!)
                }
                self.tableView.mj_header.endRefreshing()
            })
        })
        
        
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { 
            self.model.appendNews(complete: { (models:[InformationTableViewCellModel]?, error:NSError?) in
                if error == nil {
                    self.cellModels = models!
                    self.tableView.reloadData()
                } else { //to do待处理
                    print(error!)
                }
                self.tableView.mj_footer.endRefreshing()
            })
        })
        
        //利用iOS8新特性计算cell的实际高度
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
      //  self.requestImageInfo()
        model.requestImageInfo { (URLs:[String]?, error:NSError?) in
            if error == nil {
            self.imageScrollView.urls = URLs;
            } else { //to do待处理
                print(error!)
            }
        }
        
        self.tableView.mj_header.beginRefreshing()
        
        
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        imageScrollView.startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageScrollView.cancelTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellModels.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:InformationTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell") as! InformationTableViewCell?
        if cell == nil {
            cell = InformationTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        
       // cell?.textLabel?.text = "hello"
        cell?.model = cellModels[indexPath.row]
        return cell!
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100.0
//    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
