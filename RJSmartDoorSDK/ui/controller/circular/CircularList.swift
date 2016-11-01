//
//  Circular.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/8.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

class CircularList: BaseTable {
    
    var didLoad = false
    
    var circularList = [Circular]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(){}
        
        tableView.tableFooterView=UIView()
        
        
        // 定义所有子页面返回按钮的名称
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self,refreshingAction: #selector(Record.headRefresh))
        self.tableView.mj_footer = MJRefreshBackGifFooter(refreshingTarget: self,refreshingAction: #selector(Record.footRefresh))
        
        
    }
    
    
    func headRefresh(){
        
        
        SVProgressHUD.showWithStatus("数据重新刷新中...")
        self.offset=0
        self.circularList.removeAll()
        loadData() {
            self.tableView.mj_header.endRefreshing()
            SVProgressHUD.dismiss()
        }
        
        
    }
    
    func footRefresh(){
        SVProgressHUD.showWithStatus("数据加载中...")
        loadData() {
            self.tableView.mj_footer.endRefreshing()
            SVProgressHUD.dismiss()
        }
    }
    
    var offset = 0
    var limit = 10
    func loadData(closure:()->()) {
        
        CircularService.loadList(offset, limit: limit) { (result) in
            closure()
            if !self.checkResponseStatus(result){
                return
            }
            
            if let circularArray = result["response"]!["content"]!!["list"]  as? [NSDictionary]{
                if circularArray.count==0{
                }
                for dic in circularArray{
                    let value = Circular(fromDictionary: dic)
                    self.circularList.append(value)
                }
            }
            
            self.offset += self.limit
            if self.circularList.count > 0 {
                self.tableView.tableHeaderView = nil
                self.tableView.userInteractionEnabled = true
                self.tableView.reloadData()
            }else{
                let emptyList = EmptyList()
                emptyList.frame = self.tableView.frame
                self.tableView.tableHeaderView = emptyList
                self.tableView.userInteractionEnabled = false
                
            }
            
        }
        
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
        return circularList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CircularCell", forIndexPath: indexPath) as! CircularCell
        
        let title = circularList[indexPath.row].title
        let up_time = circularList[indexPath.row].upTime
        
        let string = "\(title)\n\(up_time)" as NSString
        let attributedString = NSMutableAttributedString(string: string as String)
        let subTitleAttributes = [NSForegroundColorAttributeName: UIColor.grayColor(),NSFontAttributeName: UIFont.systemFontOfSize(cell.circularText.font.pointSize-2)]
        attributedString.addAttributes(subTitleAttributes, range:string.rangeOfString(up_time!))
        
        cell.circularText.numberOfLines = 0
        cell.circularText.attributedText = attributedString
        if circularList[indexPath.row].readStatus=="0"{
            cell.news.hidden = false
        }
        cell.selectionStyle = .None
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let circular = circularList[indexPath.row]
        
        if circular.readStatus=="0"{
            CircularService.read(String(circular.circularId)) { (result) in
                if !self.checkResponseStatus(result){
                    return
                }
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: indexPath.row,inSection: 0)) as! CircularCell
                cell.news.hidden = true
                self.circularList[indexPath.row].readStatus="1"
                
            }
        }
        
        CircularService.detail(String(circular.circularId)) { (result) in
            
            if !self.checkResponseStatus(result){
                return
            }
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: indexPath.row,inSection: 0)) as! CircularCell
            cell.news.hidden = true
            self.circularList[indexPath.row].readStatus="1"
            let  circularDetail = result["response"]!["content"] as! NSDictionary
            
            VCRedirect.CIRCULAR_DETAIL(self, type: circular.contextType, dict: circularDetail)
            
        }
        
    }
    
    //    override func setEditing(editing: Bool, animated: Bool) {
    //        super.setEditing(editing, animated: true)
    //        tableView.setEditing(editing, animated: true)
    //    }
    
    //    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    //        if editingStyle == UITableViewCellEditingStyle.Delete{
    //            let member = self.circularList[indexPath.row]
    //
    //            let household_id=NSUserDefaultsUtils.getInt("household_id")!
    //            let household_token=NSUserDefaultsUtils.getString("household_token")
    //            let node_id = room.roomNodeId
    //
    //            UserManagerService.memberRemove(household_id, household_token: household_token, member_household_id: member.householdId, member_node_id: node_id){ (result) in
    //                if !self.checkResponseStatus(result){
    //                    return
    //                }
    //
    //                self.tableView.reloadData()
    //
    //            }
    //
    //
    //
    //            self.circularList.removeAtIndex(indexPath.row)
    //            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    //        }
    //    }
    
    //    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
    //        return "删除"
    //    }
    
    //添加成员
    func AddAction(barButtonItem:UIBarButtonItem ){
        
        VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.MEMBER_ADD.STOTY_BOARD, identifier: VCIdentify.MEMBER_ADD.IDENTIFIER,title: VCIdentify.MEMBER_ADD.TITLE)
        
    }
    
    /**
     适配行高
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     
     - returns: <#return value description#>
     */
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden=false
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        if didLoad{
            loadData(){
            }
        }else{
            didLoad=true
        }
    }
    
    
    
    
}
