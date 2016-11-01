//
//  UserInfo.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/12.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class UserInfo: BaseView,UIActionSheetDelegate {
    
    
    @IBOutlet weak var avatar: UIView!
    @IBOutlet weak var name: UIView!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passwd: UIView!
    @IBOutlet weak var logout: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mobileLabel.text = NSUserDefaultsUtils.getString("mobile")
        
        
        logout.addOnClickListener(self, action: #selector(UserInfo.logoutEvent))
        name.addOnClickListener(self, action: #selector(UserInfo.toSetName))
        avatar.addOnClickListener(self, action: #selector(UserInfo.toAvatar))
        passwd.addOnClickListener(self, action: #selector(UserInfo.toSetPasswd))
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logoutEvent(){
        
        
        self.sideMenuController()?.sideMenu?.hideSideMenu()
        
        let actionSheet = UIActionSheet(title: "退出后不会删除任何数据，下次登录依然能正常使用", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "退出登录")
        actionSheet.actionSheetStyle = .Default
        actionSheet.showInView(self.view)
        actionSheet.tag=1
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        switch buttonIndex {
        case 0:
            
            AccountService.logout()
            
        default:
            print("cancel")
        }
        
        
        
    }
    
    func toAvatar(){
       
        VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.USER_SET_AVATAR.STOTY_BOARD, identifier: VCIdentify.USER_SET_AVATAR.IDENTIFIER, title: VCIdentify.USER_SET_AVATAR.TITLE)
    }
    
    

    
    func toSetPasswd(){
        VCRedirect.USER_GET_QRCODE(self, mode: 1, title: "修改密码")
    }
    
    func toSetName(){
        VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.USER_SET_NAME.STOTY_BOARD, identifier: VCIdentify.USER_SET_NAME.IDENTIFIER, title: VCIdentify.USER_SET_NAME.TITLE)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nameLabel.text = DataUtils.name
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
