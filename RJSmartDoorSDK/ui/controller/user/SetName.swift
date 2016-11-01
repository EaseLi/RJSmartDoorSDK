//
//  SetName.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/12.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class SetName: BaseView,UITextFieldDelegate {
    
    
    @IBOutlet weak var nameLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.placeholder =  DataUtils.name
        nameLabel.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(sender: AnyObject) {
        
        if !nameLabel.validateLength(1, max: 30){
            Notify.toast(MessageInfo.USER_SET_NAME, type: AppContant.TOAST_WARN)
            nameLabel.shake()
            return
        }
        
        UserService.modifyName(nameLabel.text!) { (result) in
            if !self.checkResponseStatus(result){
                return
            }
             
            NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_CHANGE_NAME, object: ["oldName":DataUtils.name,"newName":self.nameLabel.text!])
            DataUtils.setName(self.nameLabel.text!)
            
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if !string.isEmpty{
            if textField.validateMaxLength(30){
                Notify.toast(MessageInfo.GLOBAL_UPPER_LIMIT, type: AppContant.TOAST_WARN)
                return false
            }
        }
        
        
        return true
    }
    
    //dimiss键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    
}
