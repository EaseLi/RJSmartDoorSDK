//
//  BindRoomViewController.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/1.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class BindRoomViewController: BaseView,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var household_name: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "开通门禁"
        checkStatusCodeService = BindRoomCheckStatusCodeService()
        
        tableView.delegate=self
        tableView.dataSource=self
        
        
        tableView.tableFooterView=UIView()
        
        //页面跳转
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BindRoomViewController.callView(_:)), name: AppContant.NOTIFY_BIND_ROOM_PAGE_REDIRECT, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkInformation(sender: AnyObject) {
        
        if !household_name.validateLength(1, max: 30){
            Notify.toast(MessageInfo.USER_SET_NAME, type: AppContant.TOAST_WARN)
            household_name.shake()
            return
        }
        
        let household_id = NSUserDefaultsUtils.getInt("household_id")
        let household_token = NSUserDefaultsUtils.getString("household_token")
        
        let property_id = stack.items[0].node_id
        
        
        let community_id = stack.items[1].node_id
        let node_id = stack.items.last?.node_id
        let household_nameText = household_name.text
        
        UserService.checkInfomation(household_id, household_token: household_token, property_id: property_id, community_id: community_id, node_id: node_id!, household_name: household_nameText!) { (response) in
            if !self.checkResponseStatus(response){
                return
            }
   
        }
        
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return stack.items.count
    }
    
    
    /**
     构造cell
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     
     - returns: cell
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("BindRoomTableViewCell", forIndexPath: indexPath) as! BindRoomTableViewCell
        // Configure the cell...
        cell.no.text = String(indexPath.row+1)
        cell.node.text = stack.items[indexPath.row].name
        cell.selectionStyle = .None
        
        
        return cell
    }
    
    /**
     适配行高
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     
     - returns: <#return value description#>
     */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select row: \(indexPath.row)")
        
        return
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //dimiss键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    func toLogin()  {
        VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.USER_LOGIN.STOTY_BOARD, identifier: VCIdentify.USER_LOGIN.IDENTIFIER, title: VCIdentify.USER_LOGIN.TITLE)
    }
    
    /**
     校验控制页面跳转（由于不在同一个navigation，无法控制跳转，故采用此方案）
     */
    func callView(notify: NSNotification){
        let identify = notify.object as! String
        let messages = SplitUtils.split(identify)
        let title =  messages[0]
        var text=""
        if messages.count>1{
            text = messages[1]
        }else{
            text =  messages[0]
        }
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(BindRoomViewController.toLogin))
        gr.numberOfTapsRequired = 1
        
        
        
        VCRedirect.GLOBAL_INFO_TIP(self, pageTitle: "", title: title, text: text, icon: UIImage(named: "ok")!, buttonTitle: "重试", type: AppContant.INFO_TIP_BINDROOM_FAIL)    }
    //========= 校验控制页面跳转结束 ==========
    
    
}
