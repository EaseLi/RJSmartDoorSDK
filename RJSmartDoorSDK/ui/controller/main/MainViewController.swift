//
//  MainViewController.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/1.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
//import ENSwiftSideMenu
import JDStatusBarNotification
import SDWebImage
import SwiftyBeaver

let log = SwiftyBeaver.self
var adlist = [ADModel]()
class MainViewController: BaseView,UIScrollViewDelegate ,UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate{
    
    let KScreenWidth = UIScreen.mainScreen().bounds.width
    let KScreenHeight = UIScreen.mainScreen().bounds.height
    
    var pageTitle="请登录"
    
    @IBOutlet weak var community: UILabel!
    
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var adContainView: UIView!
    @IBOutlet weak var adContain: UIScrollView!
    
    
    //侧滑遮罩层
    var maskView : UIView?
    //上滑菜单遮罩层
    var bottomMaskView : UIView?
    // Adds 下滑上拉菜单
    @IBOutlet weak var slideMenu: UIView!
    var isSlideMenuOpen:Bool=false
    var slideMenuFrameY:CGFloat=0.0
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //是否第一次加载
    var isLoad:Bool=false
    
    var master:Bool=false //是否主账号，默认（未登录）不是
    
    var menuList:[MainMenu] = MainMenu.menuList
    
    var adTimer = NSTimer()
    
    
    override func viewDidLoad() {
        
        log.debug("viewDidLoad viewDidLoad viewDidLoad")
        
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        initEvent()
        initObserver()
        // 定义所有子页面返回按钮的名称
        //        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
    }
    
    func initEvent(){
        //初始化菜单控件
        initMenuTable()
        //设置页控件点击事件
        initPageControl()
        //初始化上拉菜单
        initSlideMenu()
        //初始化遮罩层
        initMaskView()
        //添加广告
        loadAd()
    }
    
    func initObserver(){
        //页面跳转
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.menuCallView(_:)), name: AppContant.NOTIFY_PAGE_REDIRECT, object: nil)
        //退出登录监听
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.checkLoginInfo), name: AppContant.NOTIFY_LOGIN_OUT, object: nil)
        //广告刷新监听
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.loadAd), name: AppContant.NOTIFY_AD_UPDATE, object: nil)
        //登录超时
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.loginOutTime), name: AppContant.NOTIFY_LOGIN_OUTTIME, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.ring(_:)), name: AppContant.NOTIFY_RING, object: nil)
        
        //        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.loginOutTime), name: AppContant.NOTIFY_AUTHORITY_REFUSE, object: nil)
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return menuList.count
    }
    
    
    /**
     构造cell
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     
     - returns: cell
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if menuList[indexPath.row].type==1{
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtomMenuCell", forIndexPath: indexPath) as! ButtomMenuCell
            cell.icon.image=UIImage(named: menuList[indexPath.row].icon)
            cell.title.numberOfLines=0
            cell.title.lineBreakMode = NSLineBreakMode.ByWordWrapping
            let string = "\(menuList[indexPath.row].title)\n\(menuList[indexPath.row].subTitle)" as NSString
            let attributedString = NSMutableAttributedString(string: string as String)
            let subTitleAttributes = [NSForegroundColorAttributeName: UIColor.grayColor(),NSFontAttributeName: UIFont.systemFontOfSize(cell.title.font.pointSize-2)]
            attributedString.addAttributes(subTitleAttributes, range:string.rangeOfString(menuList[indexPath.row].subTitle))
            cell.title.attributedText = attributedString
            cell.selectionStyle = .None
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtomMenuWithSwitchCell", forIndexPath: indexPath) as! ButtomMenuWithSwitchCell
            cell.icon.image=UIImage(named: menuList[indexPath.row].icon)
            cell.title.numberOfLines=0
            cell.title.lineBreakMode = NSLineBreakMode.ByWordWrapping
            let string = "\(menuList[indexPath.row].title)\n\(menuList[indexPath.row].subTitle)" as NSString
            let attributedString = NSMutableAttributedString(string: string as String)
            let subTitleAttributes = [NSForegroundColorAttributeName: UIColor.grayColor(),NSFontAttributeName: UIFont.systemFontOfSize(cell.title.font.pointSize-2)]
            attributedString.addAttributes(subTitleAttributes, range:string.rangeOfString(menuList[indexPath.row].subTitle))
            cell.title.attributedText = attributedString
            cell.selectionStyle = .None
            cell.power.addTarget(self, action: #selector(MainViewController.switchDidChange(_:)), forControlEvents: .ValueChanged)
            if menuList[indexPath.row].menuId=="not-disturb"{
                //免扰
                cell.power.tag = 0
            }else{
                cell.power.tag = 1
            }
            
            return cell
        }
        
        
        
        
    }
    
    /**
     适配行高
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     
     - returns: <#return value description#>
     */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if menuList.count<5{
            let fixHeight:CGFloat=(KScreenHeight-slideMenu.frame.origin.y)/CGFloat(menuList.count)
            return fixHeight
        }else{
            let fixHeight:CGFloat=(tableView.bounds.height)/CGFloat(menuList.count)
            return fixHeight
        }
        
    }
    
    //点击菜单
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !(NSUserDefaultsUtils.getBool("isLogin") as Bool){
            self.bottomMaskView!.removeFromSuperview()
            self.toLogin()
            return
        }
        print("did select row: \(indexPath.row)")
        switch menuList[indexPath.row].menuId {
        case "log":
            self.bottomMaskView!.removeFromSuperview()
            VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.GLOBAL_RECORD.STOTY_BOARD, identifier: VCIdentify.GLOBAL_RECORD.IDENTIFIER, title: VCIdentify.GLOBAL_RECORD.TITLE)
        case "tel":
            self.bottomMaskView!.removeFromSuperview()
            
            if room.timeoutCallNumber.isEmpty{
                
                VCRedirect.GLOBAL_INFO_TIP(self,pageTitle: "电话通知", title: "未启用", text: "若门铃无人响应，将致电给业主。", icon: UIImage(named: "forbidden" )!, buttonTitle: "设置",type: AppContant.INFO_TIP_SETPHONE_CONFIRM)
                
            }else{
                
                VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.EDIT_NOTIFY_PHONE.STOTY_BOARD, identifier: VCIdentify.EDIT_NOTIFY_PHONE.IDENTIFIER, title: VCIdentify.EDIT_NOTIFY_PHONE.TITLE)
            }
            
        case "face":
            
            self.bottomMaskView!.removeFromSuperview()
            FaceService.faceList({ (result) in
                if !self.checkResponseStatus(result){
                    return
                }
                
                if let list = result["response"]!["content"]!!["list"]  as? [NSDictionary] where list.count>0{
                    CacheService.sharedInstance.set("face_list", value: list)
                    VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.FACE_MANAGER.STOTY_BOARD, identifier: VCIdentify.FACE_MANAGER.IDENTIFIER, title: VCIdentify.FACE_MANAGER.TITLE)
                }else{
                    VCRedirect.GLOBAL_INFO_TIP(self,pageTitle: "人脸识别", title: "未启用", text: "你可以在此上传头像，验证后可在门禁机上使用人脸识别开门", icon: UIImage(named: "forbidden" )!, buttonTitle: "开启功能",type: AppContant.INFO_TIP_FACE_CONFIRM)
                }
                
            })
            
            
            
        case "authorization":
            self.bottomMaskView!.removeFromSuperview()
            VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.MEMBER_LIST.STOTY_BOARD, identifier: VCIdentify.MEMBER_LIST.IDENTIFIER, title: VCIdentify.MEMBER_LIST.TITLE)
            
        case "notice":
            self.bottomMaskView!.removeFromSuperview()
            VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.CIRCULAR_LIST.STOTY_BOARD, identifier: VCIdentify.CIRCULAR_LIST.IDENTIFIER, title: VCIdentify.CIRCULAR_LIST.TITLE)
        default:
            log.debug("选择错误")
        }
        return
        
    }
    
    
    //设置人脸照片
    func toSetFaceImg(){
        log.debug("hehehe")
    }
    
    
    
    
    //=============开门卡片==============
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //通过scrollView内容的偏移计算当前显示的是第几页
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        //设置pageController的当前页
        pageControl.currentPage = page
        
    }
    
    //点击页控件时事件处理
    func pageChanged(sender:UIPageControl) {
        
        //根据点击的页数，计算scrollView需要显示的偏移量
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        //展现当前页面内容
        scrollView.setContentOffset(frame.origin, animated: true)
        
    }
    //=============开门卡片==============
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        
        print("sideMenuWillOpen ")
        
        self.view.addSubview(self.maskView!)
        self.bottomMaskView!.removeFromSuperview()
        
    }
    
    func sideMenuWillClose() {
        self.maskView!.removeFromSuperview()
        self.bottomMaskView!.removeFromSuperview()
        print("sideMenuWillClose ")
        
        
        
    }
    
    override func sideMenuShouldOpenSideMenu() -> Bool {
        //        print("sideMenuShouldOpenSideMenu")
        //        print(scrollView.contentOffset)
        return true
    }
    
    func sideMenuDidClose() {
        
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }
    
    //打开侧滑菜单
    @IBAction func toggleMenu(sender: AnyObject) {
        
        self.sideMenuController()?.sideMenu?.toggleMenu()
    }
    //切换房间
    @IBAction func changeCommunity(sender: AnyObject) {
        if !(NSUserDefaultsUtils.getBool("isLogin") as Bool){
            self.toLogin()
            return
        }
        
        let household_id=NSUserDefaultsUtils.getInt("household_id")
        let household_token=NSUserDefaultsUtils.getString("household_token")
        
        UserService.loadRoomList(household_id, household_token: household_token) { (result) in
            if !self.checkResponseStatus(result){
                return
            }
            
            let roomList:[NSDictionary]=result["response"]!["content"]!!["list"]  as! [NSDictionary]
            if roomList.count==0{
                Notify.toast("请先绑定房间", type: AppContant.TOAST_WARN)
            }else{
                VCRedirect.GLOBAL_CHANGE_ROOM(self,roomList: roomList)
            }
            
        }
        
    }
    
    
    func hideSideMenu() {
        print("tap working")
        self.sideMenuController()?.sideMenu?.hideSideMenu()
        if(isSlideMenuOpen){
            slideDown()
        }
    }
    
    //=========初始化界面或事件=========
    func initSlideMenu() {
        slideMenuFrameY=slideMenu.frame.origin.y
        if menuList.count>5{
            up(slideMenu)
            down(slideMenu)
        }else{
            slideMenu.gestureRecognizers?.removeAll()
        }
        
        self.view.addSubview(slideMenu)
    }
    
    
    
    func initMaskView() {
        maskView=UIView()
        maskView!.frame=CGRect(x: 0,y: 0,width: KScreenWidth,height: KScreenHeight)
        maskView!.backgroundColor=UIColor.blackColor()
        maskView!.alpha=0.3
        maskView?.addOnClickListener(self, action: #selector(MainViewController.hideSideMenu))
        
        bottomMaskView=UIView()
        bottomMaskView!.frame=CGRect(x: 0,y: 0,width: KScreenWidth,height: 52)
        
        bottomMaskView!.backgroundColor=UIColor.blackColor()
        bottomMaskView!.alpha=0.3
        bottomMaskView?.addOnClickListener(self, action: #selector(MainViewController.hideSideMenu))
    }
    
    func initMenuTable(){
        tableView.delegate=self
        tableView.dataSource = self
        tableView.scrollEnabled=false
        tableView.reloadData()
    }
    
    func initPageControl(){
        pageControl.addTarget(self, action: #selector(pageChanged(_:)),
                              forControlEvents: UIControlEvents.ValueChanged)
    }
    //=========初始化界面或事件=========
    
    
    //=======================================
    //底部菜单划动动画begin
    func up(view:UIView)  {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(MainViewController.slideUp))
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Up
        view.addGestureRecognizer(swipeLeftGesture)
        
    }
    
    func down(view:UIView)  {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(MainViewController.slideDown))
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(swipeLeftGesture)
        
    }
    
    
    func slideUp() {
        
        
        self.view.bringSubviewToFront(self.slideMenu)
        UIView.animateWithDuration(0.3, animations: {
            self.isSlideMenuOpen=true
            self.slideMenu.frame.origin.y = 52
            
            }, completion: {
                (complete: Bool) in
                UIApplication.sharedApplication().keyWindow?.addSubview(self.bottomMaskView!)
                
                
        })
        
        
    }
    
    func slideDown() {
        
        self.bottomMaskView!.removeFromSuperview()
        self.isSlideMenuOpen=false
        UIView.animateWithDuration(0.2, animations: {
            
            self.slideMenu.frame.origin.y = self.slideMenuFrameY
            
            }, completion: {
                (complete: Bool) in
                print(complete)
        })
        
    }
    //底部菜单划动动画end
    //=======================================
    
    
    //检查登录
    func checkLoginInfo(){
        
        if NSUserDefaultsUtils.getBool("isLogin"){
            
            if !self.isLoad{
                NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_LOGIN_IN, object: nil)
            }
            
            //请求卡片书军
            initCard(true)
            
        }else{
            initCard(false)
            
        }
        
        community.text = pageTitle
        
    }
    
    
    func initCard(isLogin:Bool)  {
        for view in scrollView.subviews{
            view.removeFromSuperview()
        }
        if isLogin{
            if room.householdType == "1"{
                self.master = true
                self.menuList = MainMenu.menuList
            }else{
                self.master = false
                self.menuList = MainMenu.commonMenuList
            }
            self.tableView.reloadData()
            //判断是否绑定房间
            if room.list.count>0{
                pageTitle=room.communityName
                //为了让内容横向滚动，设置横向内容宽度为页面的宽度总和
                scrollView.contentSize.width =  KScreenWidth * CGFloat(room.list.count)
                initPageControl(room.list.count)
                
                for index in 0...room.list.count-1{
                    let card = Card()
                    card.frame = CGRect(x: CGFloat(index)*KScreenWidth+20,y: 0,width: KScreenWidth-40,height: scrollView.frame.height)
                    card.subviews[0].backgroundColor = ColorUtils.getColor(index)
                    card.layer.cornerRadius=10
                    card.layer.masksToBounds=true
                    card.community.text=room.communityName
                    card.doorName.text=room.list[index].doorName
                    card.tag = room.list[index].doorId
                    
                    card.addOnClickListener(self, action: #selector(MainViewController.openDoor(_:)))
                    scrollView.addSubview(card)
                    
                }
                
                log.debug("room ===>\(room)")
                let shieldingVisitorsIndex = MainMenu.getMenuIndexById(self.menuList, menuId: "not-disturb")
                let shieldingVisitors = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: shieldingVisitorsIndex,inSection: 0)) as! ButtomMenuWithSwitchCell
                //免扰模式开关
                if room.shieldingVisitors == "1"{
                    shieldingVisitors.power.on = true
                }else{
                    shieldingVisitors.power.on = false
                }
                
                //主账号
                if master{
                    
                    let index = MainMenu.getMenuIndexById(self.menuList, menuId: "tenant")
                    let roomModel = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index,inSection: 0)) as! ButtomMenuWithSwitchCell
                    if room.roomModel == "2"{
                        roomModel.power.on = true
                    }else{
                        roomModel.power.on = false
                    }
                }
                
                
                
                
                
            }else{
                pageTitle="请绑定"
                scrollView.contentSize.width =  self.view.bounds.width
                initPageControl(1)
                let noLoginCard = Unnormal()
                noLoginCard.cartoonImage.image=UIImage(named: "notBinding")
                noLoginCard.frame = CGRect(x: 20,y: 0,width: KScreenWidth-40,height: scrollView.frame.height)
                noLoginCard.layer.cornerRadius=10
                noLoginCard.layer.masksToBounds=true
                noLoginCard.addOnClickListener(self, action: #selector(MainViewController.toLoadPropertyList))
                scrollView.addSubview(noLoginCard)
                
            }
            
            
            
        }else{
            pageTitle="请登录"
            scrollView.contentSize.width =  self.view.bounds.width
            initPageControl(1)
            let noLoginCard = Unnormal()
            
            noLoginCard.frame = CGRect(x: 20,y: 0,width: KScreenWidth-40,height: scrollView.frame.height)
            
            noLoginCard.layer.cornerRadius=10
            noLoginCard.layer.masksToBounds=true
            noLoginCard.addOnClickListener(self, action: #selector(MainViewController.toLogin))
            scrollView.addSubview(noLoginCard)
            
            
            self.master = false
            self.menuList = MainMenu.menuList
            self.tableView.reloadData()
        }
        
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.delegate=self
        scrollView.backgroundColor=UIColor.blackColor()
        
    }
    
    func initPageControl(num:Int)  {
        self.pageControl.numberOfPages=num
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        AccountService.logout()
        
    }
    
    
    var openDoorResultService = OpenDoorResultService()
    /**
     主动开门
     
     - parameter doorId: <#doorId description#>
     */
    func openDoor(sender: UITapGestureRecognizer){
        
        log.debug("openDoor ===>\(sender.view!.tag)")
        
        let household_id=NSUserDefaultsUtils.getInt("household_id")
        let household_token=NSUserDefaultsUtils.getString("household_token")
        
        let transaction_no = TransactionNoUtils.generate(String(household_id))
        
        
        HomeService.openDoor(household_id, household_token: household_token, transaction_no: transaction_no, door_id: sender.view!.tag) { (response) in
            if !self.checkResponseStatus(response){
                return
            }
            self.openDoorResultService.run(transaction_no)
            Notify.toast("开门指令发送成功",type: AppContant.TOAST_SUCCESS)
        }
        
        
        
    }
    
    //＝＝＝＝＝首页状态变更＝＝＝＝＝
    /**
     进入绑定房间流程
     */
    func toLoadPropertyList()  {
        let actionSheet = UIActionSheet(title: "请先绑定房间，更好地使用此功能", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "前往绑定")
        actionSheet.actionSheetStyle = .Default
        actionSheet.showInView(self.view)
        actionSheet.tag=1
        
    }
    
    func toLogin() {
        let actionSheet = UIActionSheet(title: "请先登录，更好地使用此功能", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "前往登录")
        actionSheet.actionSheetStyle = .Default
        actionSheet.showInView(self.view)
        actionSheet.tag=0
        
        // MARK: UIActionSheetDelegate
        
        
    }
    
    func loginOutTime(){
        let alertView = UIAlertView()
        alertView.title="系统提示"
        alertView.message="已在其他设备登录"
        alertView.addButtonWithTitle("确定")
        alertView.delegate =  self
        alertView.cancelButtonIndex=0
        alertView.show()
    }
    //＝＝＝＝＝首页状态变更结束＝＝＝＝＝
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        switch actionSheet.tag {
        //登录
        case 0:
            switch buttonIndex {
            case 0:
                VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.USER_LOGIN.STOTY_BOARD, identifier: VCIdentify.USER_LOGIN.IDENTIFIER, title: VCIdentify.USER_LOGIN.TITLE)
                
            default:
                print("cancel")
            }
        //绑定
        default:
            switch buttonIndex {
            case 0:
                VCRedirect.COMMOM_REDIRECT(self, storyboardId:  VCIdentify.USER_LOAD_PROPERTY.STOTY_BOARD, identifier:  VCIdentify.USER_LOAD_PROPERTY.IDENTIFIER, title: "开通门禁")
            default:
                print("cancel")
            }
            
        }
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        community.text=pageTitle
        self.navigationController?.navigationBarHidden=true
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        checkLoginInfo()
        self.isLoad = true
        //        if isLoad{
        //            checkLoginInfo()
        //        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.sideMenuController()?.sideMenu?.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        hideSideMenu()
    }
    
    
    /**
     侧边栏控制页面跳转（由于不在同一个navigation，无法控制跳转，故采用此方案）
     */
    func menuCallView(notify: NSNotification){
        let identify = notify.object as! String
        log.debug("menuCallView＝＝》\(identify)")
        switch identify {
        case VCIdentify.USER_LOGIN.IDENTIFIER:
            VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.USER_LOGIN.STOTY_BOARD, identifier: VCIdentify.USER_LOGIN.IDENTIFIER, title: VCIdentify.USER_LOGIN.TITLE)
        case VCIdentify.GLOBAL_CHANGE_ROOM.IDENTIFIER:
            let household_id=NSUserDefaultsUtils.getInt("household_id")
            let household_token=NSUserDefaultsUtils.getString("household_token")
            
            UserService.loadRoomList(household_id, household_token: household_token) { (result) in
                if !self.checkResponseStatus(result){
                    return
                }
                
                let roomList:[NSDictionary]=result["response"]!["content"]!!["list"]  as! [NSDictionary]
                VCRedirect.GLOBAL_CHANGE_ROOM(self,roomList: roomList)
                
            }
            
        case VCIdentify.USER_LOAD_PROPERTY.IDENTIFIER:
            VCRedirect.COMMOM_REDIRECT(self, identifier: VCIdentify.USER_LOAD_PROPERTY.IDENTIFIER)
        case VCIdentify.GLOBAL_MAIN.IDENTIFIER:
            checkLoginInfo();
        case VCIdentify.GLOBAL_ABOUT.IDENTIFIER:
            VCRedirect.COMMOM_REDIRECT(self, identifier: VCIdentify.GLOBAL_ABOUT.IDENTIFIER)
        case VCIdentify.GLOBAL_FEEDBACK.IDENTIFIER:
            VCRedirect.COMMOM_REDIRECT(self, identifier: VCIdentify.GLOBAL_FEEDBACK.IDENTIFIER)
        case VCIdentify.USER_SETTING.IDENTIFIER:
            VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.USER_SETTING.STOTY_BOARD, identifier: VCIdentify.USER_SETTING.IDENTIFIER, title: VCIdentify.USER_SETTING.TITLE)
        default:
            log.debug("未配置页面")
        }
    }
    //========= 侧边栏控制页面跳转结束 ==========
    
    func switchDidChange(sender:UISwitch)  {
        print("\(sender.tag )==>\(sender.on)")
        if !(NSUserDefaultsUtils.getBool("isLogin") as Bool){
            sender.on = !sender.on
            self.toLogin()
            return
        }
        
        switch sender.tag {
        case 0:
            sender.enabled=false
            //免扰模式
            let room_node_id = room.roomNodeId
            var shielding_visitors = "0"
            if sender.on{
                shielding_visitors = "1"
            }
            
            
            HomeService.setupShielding(room_node_id, shielding_visitors: shielding_visitors, completion: { (result) in
                sender.enabled=true
                if !self.checkResponseStatus(result){
                    sender.on = !sender.on
                    return
                }
                if sender.on{
                    room.shieldingVisitors = "1"
                }else{
                    room.shieldingVisitors = "0"
                }
                NSUserDefaultsUtils.setObject("room", value: room.toDictionary())
                
            })
            
        default:
            sender.enabled=false
            //免扰模式
            let node_id = room.roomNodeId
            var room_model = "1"
            if sender.on{
                room_model = "2"
            }
            
            
            HomeService.authorizationRoomModel(node_id, room_model: room_model, completion: { (result) in
                sender.enabled=true
                if !self.checkResponseStatus(result){
                    sender.on = !sender.on
                    return
                }
                if sender.on{
                    room.roomModel = "2"
                }else{
                    room.roomModel = "1"
                }
                
                NSUserDefaultsUtils.setObject("room", value: room.toDictionary())
            })
            
        }
        
    }
    
    
    //==================================
    //广告
    var userfulADList = [ADModel]()
    func loadAd(){
        
        for ad in adlist{
            if ad.isShow{
                userfulADList.append(ad)
            }
        }
        
        initAd(adContain, adList: userfulADList)
        
    }
    
    var page = 0
    var maxPage = 0
    
    func initAd(adContain:UIScrollView,adList:[ADModel]) -> UIScrollView{
        
        for view in adContain.subviews{
            view.removeFromSuperview()
        }
        
        
        if !adList.isEmpty{
            adContain.contentSize.width =  KScreenWidth * CGFloat(adList.count)
            adTimerCount = (String(adList[0].playTime) as NSString).doubleValue
            maxPage = userfulADList.count
            
            for index in 0...adList.count-1{
                
                let view = UIImageView()
                view.frame = CGRect(x: CGFloat(index)*KScreenWidth,y: 0,width: KScreenWidth,height: adContain.frame.height)
                view.sd_setImageWithURL(NSURL(string: adList[index].context), placeholderImage: UIImage(named: "default-ad"))
                view.tag = adList[index].advertId
                view.userInteractionEnabled = true
                view.addOnClickListener(self, action: #selector(MainViewController.shwoAD(_:)))
                adContain.addSubview(view)
                
            }
            addTimer()
        }else{
            adContain.contentSize.width =  KScreenWidth
            let view = UIImageView()
            view.frame = CGRect(x: 0,y: 0,width: KScreenWidth,height: adContain.frame.height)
            view.image = UIImage(named: "default-ad")
            adContain.addSubview(view)
        }
        
        
        return adContain
    }
    
    var adTimerCount = 3.0
    //开启定时器
    func addTimer(){
        adTimer.invalidate()
        if userfulADList.count>1{
            log.debug(" adTimerCount \(adTimerCount)")
            adTimer = NSTimer.scheduledTimerWithTimeInterval(adTimerCount, target: self, selector: #selector(MainViewController.nextImage), userInfo: nil, repeats: true)
            
        }
        
    }
    //关闭定时器
    func removeTimer(timer:NSTimer){
        timer.invalidate()
    }
    func nextImage(){
        
        
        if (page == self.maxPage-1){
            page = 0
        }else{
            page = page+1
        }
        
        self.adContain.setContentOffset(CGPointMake(CGFloat(page)*adContain.frame.size.width, 0), animated: true)
        
    }
    
    func shwoAD(sender: UITapGestureRecognizer){
        let advertId = sender.view!.tag
        
        for ad in userfulADList{
            
            if ad.advertId == advertId{
                
                if !ad.backLinks.isEmpty{
                    VCRedirect.CIRCULARL_AD_DETAIL(self, storyboardId: VCIdentify.CIRCULAR_AD_DETAIL.STOTY_BOARD, url: ad.backLinks)
                    break
                }
                
            }
        }
    }
    
    //广告结束
    //===================================
    
    
    /// 访客来访门铃
    ///
    /// - parameter notify: <#notify description#>
    func ring(notify: NSNotification){
        let dict = notify.object as! NSDictionary
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        VCRedirect.GLOBAL_RING(self, dict: dict)
    }
    
}


