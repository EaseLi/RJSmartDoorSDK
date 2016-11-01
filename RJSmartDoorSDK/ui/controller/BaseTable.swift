//
//  BaseTable.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/8.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import ENSwiftSideMenu

class BaseTable: UITableViewController,ENSideMenuDelegate {
    
    var checkStatusCodeService = CheckStatusCodeService.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        self.navigationController?.navigationBarHidden=false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //禁用右划菜单
    func sideMenuShouldOpenSideMenu() -> Bool {
        return false;
    }
    
    func checkResponseStatus(response:NSMutableDictionary) -> Bool {
        return checkStatusCodeService.checkResponseStatus(response)
    }
    
    
}
