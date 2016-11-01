//
//  ChangeRoom.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/13.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class ChangeRoom: BaseView ,UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var roomList:[NSDictionary]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDissMissEvent()
        
        tableView.tableFooterView=UIView()
        tableView.delegate=self
        tableView.dataSource=self
        
        for index in 0...roomList.count-1{
            if room.roomNodeId == roomList[index]["room_node_id"] as! Int{
            tableView.selectRowAtIndexPath(NSIndexPath(forRow: index,inSection: 0), animated: true, scrollPosition: .Top)
            }
        }
        
        
        
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        view.opaque = false
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return roomList.count
    }
    
    
    /**
     构造cell
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     
     - returns: cell
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView .dequeueReusableCellWithIdentifier("ChangeRoomCell", forIndexPath: indexPath) as! ChangeRoomCell
        cell.room.text = self.roomList[indexPath.row]["full_node_name"] as? String
        
        cell.item.backgroundColor = ColorUtils.getColor(indexPath.row)
     
        //选中背景修改成绿色
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.fromRGB("EDEDED")
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        log.debug(indexPath.row)
        
        let household_id=NSUserDefaultsUtils.getInt("household_id")
        let household_token=NSUserDefaultsUtils.getString("household_token")
        let room_node_id = self.roomList[indexPath.row]["room_node_id"] as! Int
        
        HomeService.loadDefaultHome(household_id, household_token: household_token, room_node_id: room_node_id) { (response:NSMutableDictionary) in
            if !self.checkResponseStatus(response){
                return
            }
            room = Room(fromDictionary:response["response"]!["content"] as! NSDictionary)
                NSUserDefaultsUtils.setObject("room", value: response["response"]!["content"] as! NSDictionary)
            log.debug("room change==>\(room)")
            
            self.dissMiss()
            NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_PAGE_REDIRECT, object: VCIdentify.GLOBAL_MAIN.IDENTIFIER)
        }
        
        
    }
    
    
    @IBAction func addRoom(sender: AnyObject) {
        log.debug(" addRoom addRoom addRoom")
        self.dissMiss()
        NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_PAGE_REDIRECT, object: VCIdentify.USER_LOAD_PROPERTY.IDENTIFIER)
        
    }
    
    func dissMiss(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        if NSStringFromClass(touch.view!.classForCoder) == "UITableViewCellContentView"{
            return false
        }
        return true
    }
    
    func initDissMissEvent(){
        let gr = UITapGestureRecognizer(target: self, action: #selector(ChangeRoom.dissMiss))
        gr.numberOfTapsRequired = 1
        gr.delegate=self
        view.addGestureRecognizer(gr)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
           UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
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
