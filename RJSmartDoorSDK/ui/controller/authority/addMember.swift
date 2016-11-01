//
//  addMember.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/11.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class addMember: BaseView,UIActionSheetDelegate ,UITextFieldDelegate{
    
    @IBOutlet weak var mobile: UITextField!
    
    @IBOutlet weak var radio: UIButton!
    
    var radioValue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobile.delegate = self
        self.navigationItem.rightBarButtonItem = nil
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeRadio(sender: AnyObject) {
        
        radioValue = !radioValue
        if radioValue{
            radio.setBackgroundImage(UIImage(named: "radio-check"), forState: .Normal)
        }else{
            radio.setBackgroundImage(UIImage(named: "radio-uncheck"), forState: .Normal)
        }
    }
    
    
    @IBAction func submit(sender: AnyObject) {
        textFieldShouldReturn(UITextField())
        
        if !RegexUtils.mobile(mobile.text!) {
            Notify.toast(MessageInfo.GLOBAL_MOBILE_TEXTFIELD, type: AppContant.TOAST_WARN)
            mobile.shake()
            return
        }
        
        let actionSheet = UIActionSheet(title: "授权\(mobile.text!)使用门禁吗？", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "确定")
        actionSheet.actionSheetStyle = .Default
        actionSheet.showInView(self.view)
        
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        switch buttonIndex {
        case 0:
            let household_id=NSUserDefaultsUtils.getInt("household_id")
            let household_token=NSUserDefaultsUtils.getString("household_token")
            let node_id = room.roomNodeId
            var member_household_type = ""
            if radioValue {
                member_household_type="3"
            }else{
                member_household_type="2"
            }
            UserManagerService.memberAdd(household_id, household_token: household_token, node_id: node_id, member_phone: mobile.text!, member_household_type: member_household_type, completion: { (result) in
                if !self.checkResponseStatus(result){
                    return
                }
                VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.MEMBER_LIST.STOTY_BOARD, identifier: VCIdentify.MEMBER_LIST.IDENTIFIER, title: VCIdentify.MEMBER_LIST.TITLE)
                
            })
            
            
        default:
            print("cancel")
        }
        
    }
    
    
    
    //dimiss键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if !string.isEmpty{
            if textField.validateMaxLength(11){
                Notify.toast(MessageInfo.GLOBAL_UPPER_LIMIT, type: AppContant.TOAST_WARN)
                return false
            }
        }
        
        
        return true
    }

    
}
