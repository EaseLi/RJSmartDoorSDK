//
//  LoadPropertyListViewController.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/1.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit



var stack = Stack<NodeInfo>()//选择列表
class LoadPropertyListViewController: BaseView,UITableViewDelegate, UITableViewDataSource {
    
    var propertyList:[NSDictionary] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "开通门禁"
        
        
        
        
        tableView.tableFooterView=UIView()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let household_id=NSUserDefaultsUtils.getInt("household_id")
        let household_token=NSUserDefaultsUtils.getString("household_token")
        
        UserService.loadPropertyList(household_id, household_token: household_token) { (response) in
            if !self.checkResponseStatus(response){
                return
            }
            
            self.propertyList = response["response"]!["content"]!!["list"] as! [NSDictionary]
            
            self.tableView.reloadData()
        }
        
        
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
        
        return propertyList.count
    }
    
    
    /**
     构造cell
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     
     - returns: cell
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = self.propertyList[indexPath.row]["property_name"] as? String
        cell.textLabel?.textAlignment = .Center
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let household_id=NSUserDefaultsUtils.getInt("household_id")
        let household_token=NSUserDefaultsUtils.getString("household_token")
        let property_id=self.propertyList[indexPath.row]["property_id"] as! Int
        
        UserService.loadCommunityList(household_id, household_token: household_token, property_id: property_id) { (response) in
            if !self.checkResponseStatus(response){
                return
            }
            
            let communityList = response["response"]!["content"]!!["list"] as! [NSDictionary]
            let nodeInfo = NodeInfo(node_id: self.propertyList[indexPath.row]["property_id"] as! Int,name: self.propertyList[indexPath.row]["property_name"] as! String)
            
            
            stack.push(nodeInfo)
            VCRedirect.USER_LOAD_COMMUNITY(self,communityList: communityList)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        stack.clear()
        
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
