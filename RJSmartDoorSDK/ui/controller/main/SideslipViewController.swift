//
//  SideslipViewController.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/16.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import SDWebImage

class SideslipViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate{
    
    @IBOutlet weak var tableview: UITableView!
    
    
    
    var vc:UIViewController?
    
    
    let list = ["请先登录","切换小区","意见反馈","关于睿视"]
    
    let icon = ["user-default-avatar","change-community","feedback","about"]
    
    var selectedMenuItem : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate=self
        tableview.dataSource=self
        
        tableview.scrollEnabled=false
        tableview.tableFooterView=UIView()
        
        //        //奇怪的bug 怀疑是第三发库引起的，日后再查
        //        changeLogin()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SideslipViewController.changeLogin), name: AppContant.NOTIFY_LOGIN_IN, object: nil)
        //        退出登录监听
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SideslipViewController.changeLogin), name: AppContant.NOTIFY_LOGIN_OUT, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SideslipViewController.changeAvatar), name: AppContant.NOTIFY_CHANGE_AVATAR, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SideslipViewController.changeName(_:)), name: AppContant.NOTIFY_CHANGE_NAME, object: nil)
        
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
        
        return list.count
    }
    
    
    /**
     构造cell
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     
     - returns: cell
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SideslipTableViewCell", forIndexPath: indexPath) as! SideslipTableViewCell
        
        switch indexPath.row {
        case 0:
            
            if NSUserDefaultsUtils.getBool("isLogin"){
                
                let name=NSUserDefaultsUtils.getString("name")
                let mobile=NSUserDefaultsUtils.getString("mobile")
                let string = "\(name)\n\(mobile)" as NSString
                let attributedString = NSMutableAttributedString(string: string as String)
                let subTitleAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(cell.title.font.pointSize-2)]
                attributedString.addAttributes(subTitleAttributes, range:string.rangeOfString(mobile))
                let imgurl = DataUtils.avatar
                if imgurl.isEmpty{
                    cell.icon.image = UIImage(named: "user-default-avatar")
                }else{
                    cell.icon.sd_setImageWithURL(NSURL(string: imgurl), placeholderImage:  UIImage(named: "user-default-avatar"))
                }
                
                
                cell.title.attributedText = attributedString
            }else{
                
                cell.icon.image=UIImage(named: icon[indexPath.row])
                cell.title.text=list[indexPath.row]
                
            }
            cell.addOnClickListener(self, action: #selector(SideslipViewController.loginEvent))
        default:
            cell.icon.image=UIImage(named: icon[indexPath.row])
            cell.title.text=list[indexPath.row]
            
        }
        
        
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
        return 96
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select row: \(indexPath.row)")
        switch indexPath.row {
        case 1:
            self.sideMenuController()?.sideMenu?.hideSideMenu()
            NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_PAGE_REDIRECT, object: VCIdentify.GLOBAL_CHANGE_ROOM.IDENTIFIER)
        case 2:
            self.sideMenuController()?.sideMenu?.hideSideMenu()
            NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_PAGE_REDIRECT, object: VCIdentify.GLOBAL_FEEDBACK.IDENTIFIER)
        case 3:
            self.sideMenuController()?.sideMenu?.hideSideMenu()
            NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_PAGE_REDIRECT, object: VCIdentify.GLOBAL_ABOUT.IDENTIFIER)
        default:
            return
        }
        
        return
        
    }
    
    func changeLogin()  {
        
        if NSUserDefaultsUtils.getBool("isLogin"){
            let cell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: 0,inSection: 0)) as! SideslipTableViewCell
            cell.title.numberOfLines = 0
            let name = NSUserDefaultsUtils.getString("name")
            let mobile = NSUserDefaultsUtils.getString("mobile")
            let string = "\(name)\n\(mobile)" as NSString
            let attributedString = NSMutableAttributedString(string: string as String)
            let subTitleAttributes = [NSForegroundColorAttributeName: UIColor.grayColor(),NSFontAttributeName: UIFont.systemFontOfSize(cell.title.font.pointSize-2)]
            attributedString.addAttributes(subTitleAttributes, range:string.rangeOfString(mobile))
            
            cell.title.attributedText = attributedString
            cell.icon.sd_setImageWithURL(NSURL(string: DataUtils.avatar), placeholderImage:  UIImage(named: "user-default-avatar"))
        }else{
            tableview.reloadData()
        }
        
    }
    
    func changeAvatar(){
        let cell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: 0,inSection: 0)) as! SideslipTableViewCell
        cell.icon.sd_setImageWithURL(NSURL(string: DataUtils.avatar), placeholderImage:  UIImage(named: "user-default-avatar"))
    }
    
    
    
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        switch actionSheet.tag {
        //登录
        case 0:
            switch buttonIndex {
            case 0:
                NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_PAGE_REDIRECT, object: VCIdentify.USER_LOGIN.IDENTIFIER)
                
            default:
                print("cancel")
            }
        //退出
        default:
            switch buttonIndex {
            case 0:
                NSUserDefaultsUtils.remove("isLogin")
                NSUserDefaultsUtils.remove("room")
                room = Room()
                
                log.debug("room <<<< \(room)")
                tableview.reloadData()
                
                
                
                NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_LOGIN_OUT, object: nil)
                
                NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_PAGE_REDIRECT, object: VCIdentify.USER_LOGIN.IDENTIFIER)
                
            default:
                print("cancel")
            }
        }
        
        
    }
    
    
    
    func loginEvent(){
        
        if !(NSUserDefaultsUtils.getBool("isLogin")){
            self.sideMenuController()?.sideMenu?.hideSideMenu()
            
            let actionSheet = UIActionSheet(title: "请先登录，更好地使用此功能", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "前往登录")
            actionSheet.actionSheetStyle = .Default
            actionSheet.showInView(self.view)
            actionSheet.tag=0
            
        }else{
            self.sideMenuController()?.sideMenu?.hideSideMenu()
            NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_PAGE_REDIRECT, object: VCIdentify.USER_SETTING.IDENTIFIER)
            
        }
        
        
    }
    
    func changeName(notify: NSNotification){
        let data = notify.object as! NSDictionary
        let cell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: 0,inSection: 0)) as! SideslipTableViewCell
        cell.title.text = cell.title.text?.stringByReplacingOccurrencesOfString(data["oldName"] as! String , withString: data["newName"]  as! String )
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //        changeLogin()
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
