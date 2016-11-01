//
//  LoginViewController.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/20.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

var room = Room()
class LoginViewController: BaseView,UITextFieldDelegate {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var passwd: UITextField!
    
    @IBOutlet weak var loginImage: UIImageView!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registBtn: UIButton!
    @IBOutlet weak var getPasswdBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkStatusCodeService = LoginCheckStatusCodeService(vc: self)
        
        let backButton = UIBarButtonItem(title: "返回", style:.Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
        username.delegate = self
        username.tag = 0
        let mobile = NSUserDefaultsUtils.getString("mobile")
        if(!mobile.isEmpty){
            username.text = mobile
        }
        
        passwd.delegate = self
        passwd.tag = 1
        
        
        setUI()
        // Do any additional setup after loading the view.
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func login(sender: AnyObject) {
        textFieldShouldReturn(UITextField())
        
        if !RegexUtils.mobile(username.text!) {
            Notify.toast(MessageInfo.GLOBAL_MOBILE_TEXTFIELD, type: AppContant.TOAST_WARN)
            username.shake()
            return
        }
        
        if !passwd.validateLength(6,max: 16) {
            Notify.toast(MessageInfo.USER_PASSWD_TEXTFIELD, type: AppContant.TOAST_WARN)
            passwd.shake()
            return
        }
        
        UserService.loadAccountLogin(username.text!, passwd: SecrecyUtils.sha256(passwd.text!)) { (response) in
            
            if !self.checkResponseStatus(response){
                return
            }
            
            NSUserDefaultsUtils.setBool("isLogin", value: true)
            NSUserDefaultsUtils.setValue("mobile", value: self.username.text!)
            NSUserDefaultsUtils.setValue("name", value: response["response"]!["content"]!!["household_name"] as! String)
            
            
            
            let household_id = response["response"]!["content"]!!["account_id"] as! Int
            let household_token = response["response"]!["content"]!!["account_token"] as! String
            let net_ease_account = response["response"]!["content"]!!["net_ease_account"] as! String
            let net_ease_token = response["response"]!["content"]!!["net_ease_token"] as! String
            
            NSUserDefaultsUtils.setInt("household_id", value: household_id)
            NSUserDefaultsUtils.setValue("household_token", value: household_token)
            NSUserDefaultsUtils.setValue("net_ease_account", value: net_ease_account)
            NSUserDefaultsUtils.setValue("net_ease_token", value: net_ease_token)
            
            NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_LOGIN_IN, object: nil)
            
            HomeService.loadDefaultHome(household_id, household_token: household_token, room_node_id: -1) { (response:NSMutableDictionary) in
                if !self.checkResponseStatus(response){
                    return
                }
                
                room = Room(fromDictionary:response["response"]!["content"] as! NSDictionary)
                //服务端bug
                NSUserDefaultsUtils.setObject("room", value: response["response"]!["content"] as! NSDictionary)
                
                VCRedirect.GLOBAL_MAIN(self, title: "睿家小区")
            }
            
        }
        
        
    }
    
    
    
    @IBAction func register(sender: AnyObject) {
        
        VCRedirect.USER_GET_QRCODE(self, mode: 0, title: "注册帐号")
        
    }
    
    
    @IBAction func resetPasswd(sender: AnyObject) {
        VCRedirect.USER_GET_QRCODE(self, mode: 1, title: "修改密码")
        
        
    }
    
    
    
    
    //dimiss键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    func passwdEditingDidBegin()  {
        loginImage.image=UIImage(named: "writing-passwd")
    }
    
    func passwdEditingDidEnd()  {
        loginImage.image=UIImage(named: "writing-username")
    }
    
    //    func textFieldTextDidChange(textField:UITextField){
    //        log.debug(textField.text)
    //        switch textField.tag {
    //        case 0:
    //            if let username = textField.text where username.characters.count > 11{
    //                Notify.toast("太长了", type: AppContant.TOAST_WARN)
    //                textField.text = textField.text!.substringToIndex(11)
    //            }
    //        default:
    //            log.debug("2")
    //        }
    //
    //    }
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var viewControllers = [UIViewController]()
        viewControllers.append((self.navigationController?.viewControllers[0])!)
        viewControllers.append((self.navigationController?.viewControllers.popLast())!)
        self.navigationController?.viewControllers = viewControllers
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.sharedManager().enable = false
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if !string.isEmpty{
            switch textField.tag {
            case 0:
                if textField.validateMaxLength(11){
                    Notify.toast(MessageInfo.GLOBAL_UPPER_LIMIT, type: AppContant.TOAST_WARN)
                    return false
                }else{
                    //                    if !RegexUtils.num(string){
                    //                        Notify.toast(MessageInfo.GLOBAL_MOBILE_TEXTFIELD, type: AppContant.TOAST_WARN)
                    //                        textField.shake()
                    //                        return false
                    //                    }
                    //
                    //                    if !RegexUtils.num(textField.text!){
                    //
                    //                    }
                }
            default:
                if textField.validateMaxLength(16){
                    Notify.toast(MessageInfo.GLOBAL_UPPER_LIMIT, type: AppContant.TOAST_WARN)
                    return false
                }
            }
        }
        
        
        return true
    }
    
    
    func setUI(){
        
        passwd.addTarget(self, action: #selector(LoginViewController.passwdEditingDidBegin), forControlEvents: .EditingDidBegin)
        passwd.addTarget(self, action: #selector(LoginViewController.passwdEditingDidEnd), forControlEvents: .EditingDidEnd)
        
    }
    
    
    
    
}
