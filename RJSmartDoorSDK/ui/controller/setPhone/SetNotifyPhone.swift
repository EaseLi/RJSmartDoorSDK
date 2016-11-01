//
//  SetNotifyPhone.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/12.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class SetNotifyPhone: BaseView ,UITextFieldDelegate{
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var mobileCheckBox: UIButton!
    @IBOutlet weak var telCheckBox: UIButton!
    
    var isSetSuccess = false
    
    var mobileCheckBoxValue = true{
        didSet{
            if mobileCheckBoxValue{
                mobileCheckBox.setImage(UIImage(named: "checkbox-on"), forState: .Normal)
                phone.placeholder="中国大陆手机号"
                phone.text=""
            }else{
                mobileCheckBox.setImage(UIImage(named: "checkbox-off"), forState: .Normal)
            }
        }
    }
    
    var telCheckBoxValue = false{
        didSet{
            if telCheckBoxValue{
                telCheckBox.setImage(UIImage(named: "checkbox-on"), forState: .Normal)
                phone.placeholder="区号－固话"
                phone.text=""
            }else{
                telCheckBox.setImage(UIImage(named: "checkbox-off"), forState: .Normal)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phone.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mCheckBoxAction(sender: AnyObject) {
        mobileCheckBoxValue = true
        telCheckBoxValue = false
    }
    
    @IBAction func tCheckBoxAction(sender: AnyObject) {
        mobileCheckBoxValue = false
        telCheckBoxValue = true
    }
    
    
    @IBAction func submit(sender: AnyObject) {
        
        
        if mobileCheckBoxValue{
            if !RegexUtils.mobile(phone.text!) {
                Notify.toast(MessageInfo.GLOBAL_MOBILE_TEXTFIELD, type: AppContant.TOAST_WARN)
                phone.shake()
                return
            }
            
        }else{
            if !RegexUtils.phone(phone.text!) {
                Notify.toast(MessageInfo.GLOBAL_MOBILE_TEXTFIELD, type: AppContant.TOAST_WARN)
                phone.shake()
                return
            }
        }
        
        
        let household_id = NSUserDefaultsUtils.getInt("household_id")
        let household_token = NSUserDefaultsUtils.getString("household_token")
        
        let node_id = room.roomNodeId!
        let timeout_call_number = phone.text!
        
        UserService.setNotifyPhone(household_id, household_token: household_token, room_node_id: node_id, timeout_call_number: timeout_call_number) { (result) in
            if !self.checkResponseStatus(result){
                return
            }
            self.isSetSuccess = true
            
            room.timeoutCallNumber = timeout_call_number
            NSUserDefaultsUtils.setObject("room", value: room.toDictionary())
            
            
            VCRedirect.GLOBAL_INFO_TIP(self,pageTitle: self.title!, title: "设置成功", text: "若门铃无人响应，将致电\(timeout_call_number)。", icon: UIImage(named: "ok" )!, buttonTitle: "确定",type: AppContant.INFO_TIP_SETPHONE_SUCCESS)
            
        }
        
        
        
        
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        if !string.isEmpty{
            if mobileCheckBoxValue{
                if textField.validateMaxLength(11){
                    Notify.toast(MessageInfo.GLOBAL_UPPER_LIMIT, type: AppContant.TOAST_WARN)
                    return false
                }
            }else{
                if textField.validateMaxLength(12){
                    Notify.toast(MessageInfo.GLOBAL_UPPER_LIMIT, type: AppContant.TOAST_WARN)
                    return false
                }
            }
            
            
        }
        
        
        return true
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.isSetSuccess{
            var viewControllers = [UIViewController]()
            viewControllers.append((self.navigationController?.viewControllers[0])!)
            viewControllers.append((self.navigationController?.viewControllers.popLast())!)
            self.navigationController?.viewControllers = viewControllers
        }
        
    }
    
}
