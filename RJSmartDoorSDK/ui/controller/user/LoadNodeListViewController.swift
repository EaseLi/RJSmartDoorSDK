//
//  LoadNodeListViewController.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/1.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class LoadNodeListViewController: BaseView ,UITableViewDelegate, UITableViewDataSource{
    
    var nodeList:[NSDictionary] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "开通门禁"
        tableView.tableFooterView=UIView()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        
        tableView.delegate=self
        tableView.dataSource=self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return nodeList.count
    }
    
    
    /**
     构造cell
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     
     - returns: cell
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = self.nodeList[indexPath.row]["node_name"] as? String
        cell.textLabel?.textAlignment = .Center
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let node_id=self.nodeList[indexPath.row]["node_id"] as! Int
        let node_type = self.nodeList[indexPath.row]["have_sub_node"] as! String
        
        //选择结果入堆栈
        let nodeInfo = NodeInfo(node_id: self.nodeList[indexPath.row]["node_id"] as! Int,name: self.nodeList[indexPath.row]["node_name"] as! String)
        stack.push(nodeInfo)
        
        if node_type == "N"{
            let household_id=NSUserDefaultsUtils.getInt("household_id")
            let household_token=NSUserDefaultsUtils.getString("household_token")
            
            
            UserService.loadNodeList(household_id, household_token: household_token, node_id: node_id) { (response) in
                if !self.checkResponseStatus(response){
                    return
                }
                
                let nodeList = response["response"]!["content"]!!["list"] as! [NSDictionary]
                
                VCRedirect.USER_LOAD_NODE(self, nodeList: nodeList)
            }
        }else{
            VCRedirect.USER_BIND_ROOM(self)
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if didLoad{
            stack.pop()
        }else{
            didLoad=true
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
