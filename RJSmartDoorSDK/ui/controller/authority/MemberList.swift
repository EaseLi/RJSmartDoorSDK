//
//  MemberList.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/11.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import ENSwiftSideMenu
import MJRefresh
import SVProgressHUD

class MemberList: BaseTable ,UIActionSheetDelegate{
    
    var didLoad = false
    
    var memList = [Member]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(){}
        
        tableView.tableFooterView=UIView()
        let rightItem = UIBarButtonItem(barButtonSystemItem: .Add,target: self,action: #selector(MemberList.AddAction(_:)))
        self.navigationItem.rightBarButtonItem = rightItem
        
        // 定义所有子页面返回按钮的名称
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(MemberList.refrsh), name: AppContant.NOTIFY_AUTHORITY_AGREE, object: nil)
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self,refreshingAction: #selector(MemberList.headRefresh))
        
        
    }
    
    func refrsh(){
        loadData(){}
    }
    
    
    func headRefresh(){
        SVProgressHUD.showWithStatus("数据重新刷新中...")
        self.memList.removeAll()
        loadData() {
            self.tableView.mj_header.endRefreshing()
            SVProgressHUD.dismiss()
        }
        
        
    }
    
    
    func loadData(closure:()->())  {
        
        
        let household_id=NSUserDefaultsUtils.getInt("household_id")
        let household_token=NSUserDefaultsUtils.getString("household_token")
        let node_id = room.roomNodeId
        
        UserManagerService.memberList(household_id, household_token: household_token, node_id: node_id) { (response) in
            closure()
            if !self.checkResponseStatus(response){
                self.tableView.reloadData()
                return
            }
            
            self.memList.removeAll()
            if let memberArray = response["response"]!["content"]!!["list"]  as? [NSDictionary]{
                for dic in memberArray{
                    let value = Member(fromDictionary: dic)
                    self.memList.append(value)
                }
            }
            
            
            self.tableView.reloadData()
            
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
        return memList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemberListCell", forIndexPath: indexPath) as! MemberListCell
        cell.name.numberOfLines = 0
        cell.selectionStyle = .None
        let name = memList[indexPath.row].householdName
        let phone = memList[indexPath.row].phone
        var describe:String!
        
        let string = "\(name)\n\(phone)" as NSString
        let attributedString = NSMutableAttributedString(string: string as String)
        let phoneAttributes = [NSForegroundColorAttributeName: UIColor.grayColor(),NSFontAttributeName: UIFont.systemFontOfSize(cell.name.font.pointSize-2)]
        attributedString.addAttributes(phoneAttributes, range:string.rangeOfString(phone!))
        cell.name.attributedText = attributedString
        
        switch memList[indexPath.row].authorityStatus {
        case "3":
            describe = "审核中"
            
            
        default:
            switch memList[indexPath.row].householdType {
            case "1":
                describe="主帐号"
            case "2":
                describe="家庭成员"
            default:
                describe="租客"
            }
        }
        
        cell.describe.text = describe
        
        
        return cell
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
    }
    
    //删除开始===================
    //屏蔽主账号删除功能
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if memList[indexPath.row].householdType == "1"{
            return false
        }else{
            return true
        }
    }
    
    var member:Member!
    var index:NSIndexPath!
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
            index=indexPath
            member = self.memList[indexPath.row]
            
            let actionSheet = UIActionSheet(title: "\(member.phone)将他删除？", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "确定")
            actionSheet.actionSheetStyle = .Default
            actionSheet.showInView(self.view)
            
            
        }
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        switch buttonIndex {
        case 0:
            let household_id=NSUserDefaultsUtils.getInt("household_id")
            let household_token=NSUserDefaultsUtils.getString("household_token")
            let node_id = room.roomNodeId
            let member_household_type = member.householdType
            
            UserManagerService.memberRemove(household_id, household_token: household_token, member_household_id: member.householdId, member_node_id: node_id,member_household_type:member_household_type){ (result) in
                if !self.checkResponseStatus(result){
                    return
                }
                
                self.memList.removeAtIndex(self.index.row)
                self.tableView.deleteRowsAtIndexPaths([self.index], withRowAnimation: UITableViewRowAnimation.Fade)
                
                if let have_tenant = result["response"]!["content"]!!["have_tenant"] as? String where have_tenant == "0" {
                    room.roomModel = "1"
                    NSUserDefaultsUtils.setObject("room", value: room.toDictionary())
                }
                
            }
            
        default:
            print("cancel")
        }
        
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "确定删除"
    }
    //删除结束===================
    
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
    
//    //禁用右划菜单
//    func sideMenuShouldOpenSideMenu() -> Bool {
//        return false;
//    }
//    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden=false
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        self.sideMenuController()?.sideMenu?.delegate = self;
        if didLoad{
            loadData(){}
        }else{
            didLoad=true
        }
    }
    
   
    
}
