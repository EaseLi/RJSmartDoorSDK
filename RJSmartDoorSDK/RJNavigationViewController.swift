//
//  naViewController.swift
//  RJSmartDoorSDK
//
//  Created by Ruijia on 2016/11/2.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import ENSwiftSideMenu

class RJNavigationViewController: ENSideMenuNavigationController, ENSideMenuDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let sideslipViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SideslipViewController") as! SideslipViewController
        sideslipViewController.vc = self
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: sideslipViewController, menuPosition:.Left)
        sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = 240.0 // optional, default is 160
        sideMenu?.bouncingEnabled=false
        
        sideMenu?.bouncingEnabled = false
        sideMenu?.allowPanGesture = false
        
        // make navigation bar showing over side menu
        view.bringSubviewToFront(navigationBar)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
