//
//  FoundTableViewController.swift
//  KYZG_swift
//
//  Created by LiTengFang on 17/2/22.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class FoundTableViewController: UITableViewController {
    
    let model = [[CellModel(title:"开源软件",imageName:"ic_discover_softwares",reponse:{()->Void in })],
                 [CellModel(title:"找人",imageName:"ic_discover_find",reponse:{()->Void in })],
                 [CellModel(title:"扫一扫",imageName:"ic_discover_scan",reponse:{()->Void in }),CellModel(title:"摇一摇",imageName:"ic_discover_shake",reponse:{()->Void in })]]
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        title = "发现"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model[section].count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = model[indexPath.section][indexPath.row].title;
        cell?.imageView?.image = UIImage(named:model[indexPath.section][indexPath.row].imageName!);
        //tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        
        return cell!
     }
 
    
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
