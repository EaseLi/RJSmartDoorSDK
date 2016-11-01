//
//  EditNotifyPhone.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/12.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class EditNotifyPhone: BaseView {
    
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var tip: UILabel!
    @IBOutlet weak var text: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        icon.image=UIImage(named: "ok")
        tip.text="已启用"
        text.text="若门铃无人响应，将致电\(room.timeoutCallNumber)。"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func edit(sender: AnyObject) {
        VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.SET_NOTIFY_PHONE.STOTY_BOARD, identifier: VCIdentify.SET_NOTIFY_PHONE.IDENTIFIER,title: "电话通知")
    }
    
    @IBAction func disabled(sender: AnyObject) {
        
        let household_id = NSUserDefaultsUtils.getInt("household_id")
        let household_token = NSUserDefaultsUtils.getString("household_token")
        
        let node_id = room.roomNodeId!
        let timeout_call_number = ""
        
        UserService.setNotifyPhone(household_id, household_token: household_token, room_node_id: node_id, timeout_call_number: timeout_call_number) { (result) in
            if !self.checkResponseStatus(result){
                return
            }
            
            room.timeoutCallNumber=""
            NSUserDefaultsUtils.setObject("room", value: room.toDictionary())
            let gr = UITapGestureRecognizer(target: self, action: #selector(EditNotifyPhone.toSetNotifyPhone))
            gr.numberOfTapsRequired = 1
            
            VCRedirect.GLOBAL_INFO_TIP(self,pageTitle: self.title! , title: "未启用", text: "若门铃无人响应，将致电给业主。", icon: UIImage(named: "forbidden" )!, buttonTitle: "设置", type: AppContant.INFO_TIP_SETPHONE_CONFIRM)
        }
       
    }
    
    
    
    func toSetNotifyPhone()  {
        VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.SET_NOTIFY_PHONE.STOTY_BOARD, identifier: VCIdentify.SET_NOTIFY_PHONE.IDENTIFIER,title: VCIdentify.SET_NOTIFY_PHONE.TITLE)
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
