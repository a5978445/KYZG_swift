//
//  MyTableViewController.swift
//  KYZG_swift
//
//  Created by LiTengFang on 17/2/22.
//  Copyright © 2017 LiTengFang. All rights reserved.
//

import UIKit

struct cellModel {
    var title:String?
    var imageName:String?
    var reponse:()->Void
    
    
    public init(title:String,imageName:String?,reponse:@escaping ()->Void) {
        self.title = title;
        self.imageName = imageName;
        self.reponse = reponse
    }
}


class MyTableViewController: UITableViewController {

    var headerView:MyTableHeaderView?
    
    let model = [cellModel(title:"我的消息",imageName:"ic_my_messege",reponse:{()->Void in }),
                 cellModel(title:"我的博客",imageName:"ic_my_blog",reponse:{()->Void in }),
                 cellModel(title:"我的活动",imageName:"ic_my_event",reponse:{()->Void in }),
                 cellModel(title:"我的团队",imageName:"ic_my_team",reponse:{()->Void in })]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        headerView = MyTableHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 280 + 64))
        headerView?.showLogin = {[unowned self] ()->() in self.navigationController?.pushViewController(LoginViewController(), animated: true) }
        headerView?.showSet = {[unowned self] ()->() in self.navigationController?.pushViewController(SettingViewController(), animated: true) }
        
        
        tableView.tableHeaderView = headerView
        self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 44, 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
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
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
