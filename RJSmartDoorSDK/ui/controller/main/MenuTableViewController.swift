//
//  MenuTableViewController.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/6.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    let list = ["请先登录","切换小区","意见反馈","关于睿视"]
    
    let icon = ["default-avatar","change-community","feedback","about"]
    
    var selectedMenuItem : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.scrollEnabled=false
        tableView.tableFooterView=UIView()
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
        
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuTableViewCell", forIndexPath: indexPath) as! MenuTableViewCell
        print(indexPath.row)
        if(indexPath.row==0){
            if NSUserDefaultsUtils.getBool("isLogin") as Bool{
                
                let name=NSUserDefaultsUtils.getString("name")
                let mobile=NSUserDefaultsUtils.getString("mobile")
                let string = "\(name)\n\(mobile)" as NSString
                let attributedString = NSMutableAttributedString(string: string as String)
                let subTitleAttributes = [NSForegroundColorAttributeName: UIColor.grayColor(),NSFontAttributeName: UIFont.systemFontOfSize(cell.title.font.pointSize-2)]
                attributedString.addAttributes(subTitleAttributes, range:string.rangeOfString(name))
                cell.icon.image=UIImage(named: icon[indexPath.row])
                cell.title.text=list[indexPath.row]
            }else{
                cell.icon.image=UIImage(named: icon[indexPath.row])
                cell.title.text=list[indexPath.row]
            }
            
            
            
        }else{
            // Configure the cell...
            cell.icon.image=UIImage(named: icon[indexPath.row])
            cell.title.text=list[indexPath.row]
            
        }
        cell.selectionStyle = .None
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
    }
    
    
}
