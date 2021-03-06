//
//  TweetsViewController.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/2.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MJRefresh



public enum TweetType: Int {
    case newTweet = 1
    case hotTweet = 2
    case myTweet = 3
}

class TweetsViewController: UITableViewController {
    
    let model = TweetsViewControllerModel()
    let dataSource = TweetsViewControllerDataSource()
    var tweetType: TweetType = TweetType.newTweet {
        didSet {
            model.tweetType = tweetType
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.dataSource = dataSource
        
        
        tableView.mj_header = MJRefreshNormalHeader {
            [unowned self] in
            self.model.requestNewTweets {[weak self] response in
                guard self != nil else {
                    return
                }
                
                switch response {
                case let .sucess(tweets):
                    self?.dataSource.models = tweets.tweetModels;
                    self?.tableView.reloadData()
                case let .failure(error):
                    print(error)
                }
                
                self?.tableView.mj_header.endRefreshing()
            }
            
            
        }
        
        
        tableView.mj_footer = MJRefreshBackNormalFooter {
            [weak self] in
            self?.model.addTweets { [weak self] response in
                guard self != nil else {
                    return
                }
                
                switch response {
                case let .sucess(tweets):
                    self?.dataSource.models = tweets.tweetModels;
                    self?.tableView.reloadData()
                case let .failure(error):
                    print(error)
                }
                
                self?.tableView.mj_footer.endRefreshing()
                
                
            }
            
            
        }
        
        tableView.mj_header.beginRefreshing()
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }

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
