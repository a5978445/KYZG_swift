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


class InformationTableViewController: UITableViewController {
    
    let imageScrollView = BannerScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 144))
    
    var model = InformationTableViewControllerModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.tableHeaderView = imageScrollView
        self.tableView.tableHeaderView?.backgroundColor = UIColor.red
        self.tableView.backgroundColor = UIColor.green
        
        
        requestImageInfo()
        reqeustNews()
    }
    
    func reqeustNews() ->Void {
        Alamofire.request(OSCAPI_V2_HTTPS_PREFIX + "news", method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
            if response.result.value != nil {
                
                let dic = JSON(data: response.data!)
                print(dic)
                if dic["code"] == 1 {
                   
                   self.model.setInfomations(infomationsJSON: dic["result"]["items"].arrayValue)
                
                    
                     print("sucess")
                } else {
                    print(response.error)
                }
            }
        })

        
        //  NSMutableURLRequest *request = [self newsRequest:@{@"pageToken":_nextPageToken}];
    }
    
    func requestImageInfo() ->Void{
        Alamofire.request(OSCAPI_V2_HTTPS_PREFIX + "banner", method: HTTPMethod.get, parameters: ["catalog":Int(1)], encoding:URLEncoding.default , headers: nil).responseJSON { response in
            
            
            if response.result.value != nil {
             //   print("JSON: \(aJSON)")
                let dic = JSON(data: response.data!)
                if dic["code"] == 1 {
                    print("sucess")
                    
                    self.model.setBanners(banersJSON: dic["result"]["items"].arrayValue)
                    
                    self.imageScrollView.urls = self.model.imageURLs()
                    
                } else { //处理错误信息
                    print(dic["code"])
                }
                
                
            }
        }
        
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
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
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
