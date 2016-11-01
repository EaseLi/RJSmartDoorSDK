//
//  SetPasswd.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/21.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class SetPasswdViewController: BaseView,UITextFieldDelegate {
    
    @IBOutlet weak var passwd: UITextField!
    @IBOutlet weak var checkPasswd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "返回", style:.Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        passwd.delegate=self
        checkPasswd.delegate=self
        
        //手工清掉验证码页面
        self.navigationController?.viewControllers.removeAtIndex((self.navigationController?.viewControllers.count)!-2)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func setUserPasswd(sender: AnyObject) {
        textFieldShouldReturn(UITextField())
        
        if !passwd.validateLength(6,max: 16) {
            Notify.toast(MessageInfo.USER_PASSWD_TEXTFIELD, type: AppContant.TOAST_WARN)
            passwd.shake()
            return
        }
        
        let passwdText=passwd.text!
        let checkPasswdText=checkPasswd.text!
        
        if passwdText != checkPasswdText{
            Notify.toast(MessageInfo.USER_CHECK_PASSWD_TEXTFIELD, type: AppContant.TOAST_WARN)
            return
        }
        
        UserService.setPassWd(SecrecyUtils.sha256(passwdText)) { (response) in
            if !self.checkResponseStatus(response){
                return
            }
            
            
            VCRedirect.GLOBAL_INFO_TIP(self,pageTitle: self.title!, title: self.title!+"成功", text: "", icon: UIImage(named: "ok" )!, buttonTitle: "马上体验", type: AppContant.INFO_TIP_SETPASSWD_SUCCESS)
            
            
            
        }
        
        
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if !string.isEmpty{
            if textField.validateMaxLength(16){
                Notify.toast(MessageInfo.GLOBAL_UPPER_LIMIT, type: AppContant.TOAST_WARN)
                return false
            }        }
        
        
        return true
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
    
   
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        //手工清掉验证码页面
//        self.navigationController?.viewControllers.removeAtIndex((self.navigationController?.viewControllers.count)!-2)
//    }
    
    
}
