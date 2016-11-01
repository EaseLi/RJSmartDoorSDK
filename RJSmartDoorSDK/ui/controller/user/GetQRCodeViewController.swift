//
//  RegisterViewController.swift
//  SmartDoor
//
//  Created by Ruijia on 16/5/30.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetQRCodeViewController: BaseView ,UITextFieldDelegate{
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var verificationCode: UITextField!
    
    @IBOutlet weak var verificationCodeBtn: CountdownButton!
    
    //0注册 1找回密码
    var mode:Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        let backButton = UIBarButtonItem(title: "返回", style:.Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
        username.delegate = self
        username.tag = 0
        verificationCode.delegate = self
        verificationCode.tag = 1
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func verificationCodeAct(sender: AnyObject) {
        
        textFieldShouldReturn(UITextField())
        
        if !RegexUtils.mobile(username.text!) {
            Notify.toast(MessageInfo.GLOBAL_MOBILE_TEXTFIELD, type: AppContant.TOAST_WARN)
            username.shake()
            return
        }
        
        
        
        verificationCodeBtn.enabled = false
        
        let url=AppContant.BASE_URL+AppContant.USER_VERIFYCODE
        
        let phone=username.text!
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+phone, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["phone":phone,"verify_type":mode,"apply_time":apply_time,"code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            self.verificationCodeBtn.enabled = true
            if !self.checkResponseStatus(response){
                return
            }
            
            self.verificationCodeBtn.maxSecond=60
            self.verificationCodeBtn.countdown = true
            
        })
        
    }
    
    
    @IBAction func next(sender: AnyObject) {
        
        textFieldShouldReturn(UITextField())
        
        if !RegexUtils.mobile(username.text!) {
            Notify.toast(MessageInfo.GLOBAL_MOBILE_TEXTFIELD, type: AppContant.TOAST_WARN)
            username.shake()
            return
        }
        
        if !RegexUtils.qrcode(verificationCode.text!){
            Notify.toast(MessageInfo.GLOBAL_QRCODE_TEXTFIELD, type: AppContant.TOAST_WARN)
            verificationCode.shake()
            return
        }
        
        
        switch mode {
        //注册
        case 0:
            let url=AppContant.BASE_URL+AppContant.USER_CHECK_VERIFYCODE
            let phone=username.text!
            let verify_code=verificationCode.text!
            let apply_time=DateUtils.getTimeStamp()
            let code = SecrecyUtils.sha256(apply_time+phone+verify_code, salt: AppContant.INTERFACE_SALT)
            let requestData:[String:AnyObject]=["phone":phone,"verify_code":verify_code,"apply_time":apply_time,"code":code]
            
            log.debug(requestData)
            HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
                log.debug("callback==>\(response)")
                
                if !self.checkResponseStatus(response){
                    return
                }
                
                let defaults = NSUserDefaults.standardUserDefaults()
                
                defaults.setValue(response["response"]!["content"]!!["household_id"], forKey: "household_id")
                
                VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.USER_SET_PASSWD.STOTY_BOARD, identifier: VCIdentify.USER_SET_PASSWD.IDENTIFIER, title: self.title!)
            })
            
        //找回密码
        default:
            let url=AppContant.BASE_URL+AppContant.USER_RESET_PASSWD
            let phone=username.text!
            let verify_code=verificationCode.text!
            let apply_time=DateUtils.getTimeStamp()
            let code = SecrecyUtils.sha256(apply_time+phone+verify_code, salt: AppContant.INTERFACE_SALT)
            let requestData:[String:AnyObject]=["phone":phone,"verify_code":verify_code,"apply_time":apply_time,"code":code]
            
            log.debug(requestData)
            HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
                log.debug("callback==>\(response)")
                
                if !self.checkResponseStatus(response){
                    return
                }
                
                let defaults = NSUserDefaults.standardUserDefaults()
                
                defaults.setValue(response["response"]!["content"]!!["household_id"], forKey: "household_id")
                
                VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.USER_SET_PASSWD.STOTY_BOARD, identifier: VCIdentify.USER_SET_PASSWD.IDENTIFIER, title: self.title!)
            })
        }
        
        
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
    /**
     文本框监听
     
     - parameter textField: <#textField description#>
     - parameter range:     <#range description#>
     - parameter string:    <#string description#>
     
     - returns: <#return value description#>
     */
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if !string.isEmpty{
            switch textField.tag {
            case 0:
                if textField.validateMaxLength(11){
                    Notify.toast(MessageInfo.GLOBAL_UPPER_LIMIT, type: AppContant.TOAST_WARN)
                    return false
                }
            default:
                if textField.validateMaxLength(6){
                    Notify.toast(MessageInfo.GLOBAL_UPPER_LIMIT, type: AppContant.TOAST_WARN)
                    return false
                }
            }
        }
        
        
        return true
    }
    
    
}
