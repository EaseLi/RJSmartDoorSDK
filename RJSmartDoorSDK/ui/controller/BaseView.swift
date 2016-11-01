//
//  BaseView.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/21.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import ENSwiftSideMenu

class BaseView: UIViewController,ENSideMenuDelegate {
    
    var checkStatusCodeService = CheckStatusCodeService.getInstance()
    
    var didLoad:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // 定义所有子页面返回按钮的名称
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        self.navigationController?.navigationBarHidden=false
        self.sideMenuController()?.sideMenu?.delegate = self
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func checkResponseStatus(response:NSMutableDictionary) -> Bool {
        
       return checkStatusCodeService.checkResponseStatus(response)

    }
    
    //禁用右划菜单
    func sideMenuShouldOpenSideMenu() -> Bool {
        return false;
    }
    
    func clearViewStack(){
        var viewControllers = [UIViewController]()
        viewControllers.append((self.navigationController?.viewControllers[0])!)
        viewControllers.append((self.navigationController?.viewControllers.popLast())!)
        self.navigationController?.viewControllers = viewControllers
    }
    
    
}
