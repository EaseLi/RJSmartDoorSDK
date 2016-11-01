//
//  ConfirmSetPhone.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/11.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class ConfirmSetPhone: InfoTipViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func BtnClick(sender: AnyObject) {
        VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.SET_NOTIFY_PHONE.STOTY_BOARD, identifier: VCIdentify.SET_NOTIFY_PHONE.IDENTIFIER, title: VCIdentify.SET_NOTIFY_PHONE.TITLE)
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
