//
//  Ring.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/15.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import SDWebImage
//import NIMSDK

class Ring: BaseView,NIMNetCallManagerDelegate {
    
    var dict =  NSDictionary()
    
    @IBOutlet weak var showWindow: UIImageView!
    
    @IBOutlet weak var answerBtn: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var receiver: UIImageView!
    var receiverStatus:Bool = false{
        didSet{
            if receiverStatus{
                receiver.image = UIImage(named: "receiver-on")
                NIMSDK.sharedSDK().netCallManager.setSpeaker(false)
            }else{
                receiver.image = UIImage(named: "receiver-off")
                NIMSDK.sharedSDK().netCallManager.setSpeaker(true)
            }
        }
    }
    
    @IBOutlet weak var errorTip: UILabel!
    var answerBtnStatus:Int = 0{
        didSet{
            switch answerBtnStatus {
            case 1:
                answerBtn.setImage(UIImage(named: "video"), forState: .Normal)
            case 2:
                answerBtn.setImage(UIImage(named: "video-on"), forState: .Normal)
            default:
                answerBtn.setImage(UIImage(named: "error"), forState: .Normal)
                errorTip.hidden = false
            }
        }
    }
    
    
    
    @IBOutlet weak var process: UIProgressView!
    var callID:UInt64?
    
    private var second = 0
    private var timer: NSTimer?
    
    var maxSecond = 30
    
    var countdown:Bool = false {
        didSet {
            countdown ? startCountdown() : stopCountdown()
        }
    }
    
    //是否已挂断
    var handUp = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        RingService.playSound() //震动响铃
        countdown = true
        showWindow.sd_setImageWithURL(NSURL(string: dict["image_url"] as! String), placeholderImage: UIImage(named: "img-loading"))
        
        //呼叫中断
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Ring.apnsListner(_:)), name: AppContant.NOTIFY_OPEN_DOOR, object: nil)
        //其他用户已操作
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Ring.dismiss), name: AppContant.NOTIFY_OTHER_OPEN_DOOR_RESPONSE, object: nil)
        //令牌超时
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Ring.dismiss), name: AppContant.NOTIFY_LOGIN_OUTTIME, object: nil)
        
        receiver.userInteractionEnabled = true
        receiver.addOnClickListener(self, action: #selector(Ring.switchReceiver))
        
        let transform = CGAffineTransformMakeScale(1.0, 3)
        process.transform = transform
        
        //忽略导航栏高度
        self.navigationController!.navigationBar.translucent = false
        self.title = "访客门铃"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private
    
    private func startCountdown() {
        second = maxSecond
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(Ring.updateCountdown), userInfo: nil, repeats: true)
    }
    
    private func stopCountdown() {
        timer?.invalidate()
        timer = nil
        
    }
    
    
    
    @objc private func updateCountdown() {
        second -= 1
        if second <= 0 {
            self.countdown = false
            dismiss()
            
        }else{
            process.progress=1.0 - Float(Double(second)/Double(maxSecond))
        }
        
    }
    
    
    //免提按钮切换
    func switchReceiver(){
        log.debug("免提按钮切换\(self.receiverStatus)")
        self.receiverStatus = !self.receiverStatus
        
    }
    
    
    /**
     拒绝开门
     
     - parameter sender: <#sender description#>
     */
    @IBAction func refuse(sender: AnyObject) {
        RingService.stopSound()
        
        let transaction_no = dict["transaction_no"] as! String
        let door_id = dict["door_id"] as! Int
        let call_info = dict["call_info"] as! String
        let result="2"
        let open_type="2"
        HomeService.respondVisit(transaction_no, door_id: door_id, result: result, open_type: open_type, call_info: call_info) { (result) in
            if !self.checkResponseStatus(result){
                return
            }
            self.dismiss()
        }
        
    }
    
    /**
     忽略开门
     
     - parameter sender: <#sender description#>
     */
    @IBAction func ignore(sender: AnyObject) {
        
        let transaction_no = dict["transaction_no"] as! String
        let door_id = dict["door_id"] as! Int
        let call_info = dict["call_info"] as! String
        let result="3"
        let open_type="2"
        HomeService.respondVisit(transaction_no, door_id: door_id, result: result, open_type: open_type, call_info: call_info) { (result) in
            if !self.checkResponseStatus(result){
                return
            }
            
            self.dismiss()
        }
    }
    
    /**
     开门
     
     - parameter sender: <#sender description#>
     */
    @IBAction func open(sender: AnyObject) {
        RingService.stopSound()
        
        let transaction_no = dict["transaction_no"] as! String
        let door_id = dict["door_id"] as! Int
        let call_info = dict["call_info"] as! String
        let result="1"
        let open_type="2"
        HomeService.respondVisit(transaction_no, door_id: door_id, result: result, open_type: open_type, call_info: call_info) { (result) in
            if !self.checkResponseStatus(result){
                return
            }
            Notify.toast("开门指令已发送", type: AppContant.TOAST_SUCCESS)
            self.dismiss()
        }
    }
    
    
    @IBAction func answer(sender: AnyObject) {
        RingService.stopSound()
        
        if answerBtnStatus<2 {
            switch answerBtnStatus {
            case 0:
                self.answerBtn.enabled = false
                
                let transaction_no = dict["transaction_no"] as! String
                let door_id = dict["door_id"] as! Int
                let call_info = dict["call_info"] as! String
                let result="4"
                let open_type="2"
                HomeService.respondVisit(transaction_no, door_id: door_id, result: result, open_type: open_type, call_info: call_info) { (result) in
                    if !self.checkResponseStatus(result){
                        self.answerBtn.enabled = true
                        return
                    }
                    self.audioConnect()
                }
                
                
                
            case 1:
                self.answerBtn.enabled = false
                changeVideo()
            default:
                log.debug("no more")
            }
            
            
        }
        
        
        
        
        
    }
    
    func onCall(callID: UInt64, netStatus status: NIMNetCallNetStatus) {
        log.debug("[云信 当前通话网络状态] NIMNetCallNetStatus:\(status.rawValue)")
    }
    
    func onCall(callID: UInt64, status: NIMNetCallStatus) {
        log.debug("[云信 当前通话状态] NIMNetCallNetStatus:\(status)")
        if(status == NIMNetCallStatus.Connect){
            log.debug("音视频已建立")
            NIMSDK.sharedSDK().netCallManager.setSpeaker(true)
            self.answerBtn.enabled=true
            maxSecond = 45
            second = 0
            countdown = false
            countdown = true
            
            answerBtnStatus+=1
            
            
            
        }else{
            self.answerBtnStatus-=999
            log.debug("音视频已断开")
        }
        
    }
    
    func onUserJoined(uid: String, meeting: NIMNetCallMeeting) {
        log.debug("[云信 用户加入了多人会议] uid:\(uid)")
    }
    
    func onUserLeft(uid: String, meeting: NIMNetCallMeeting) {
        log.debug("[云信 用户退出了多人会议] uid:\(uid)")
    }
    
    
    func onResponse(callID: UInt64, from callee: String, accepted: Bool) {
        log.debug("[云信 主叫收到被叫响应] callee:\(callee) callID:\(callID) 响应:\(accepted)")
        
        
        
    }
    
    func onHangup(callID: UInt64, by user: String) {
        log.debug("[云信  对方挂断电话] by user:\(user) ")
        handUp = true
        Notify.toast("通话已结束", type: AppContant.TOAST_WARN)
        dismiss()
    }
    
    
    func onControl(callID: UInt64, from user: String, type control: NIMNetCallControlType) {
        log.debug("[云信  收到对方网络通话控制信息，用于方便通话双方沟通信息] from user:\(user)  control:\(control.hashValue)")
        switch control {
        case NIMNetCallControlType.ToVideo:
            NIMSDK.sharedSDK().netCallManager.switchType(NIMNetCallType.Video)
            
        case NIMNetCallControlType.RejectToVideo:
            self.answerBtnStatus-=999
        default:
            log.debug("异常控制")
        }
        
        
    }
    
    func onRemoteImageReady(image: CGImage) {
        //        log.debug("[云信  远程视频画面就绪] 开始播放视频 ")
        
        if !self.answerBtn.enabled{
            self.answerBtn.enabled=true
            answerBtnStatus+=1
            //听筒
            receiver.hidden = true
            receiverStatus = false
            self.title = "视频通话中"
        }
        self.showWindow.image = UIImage(CGImage: image)
        
    }
    
    //    func onRemoteYUVReady(yuvData: NSData!, width: UInt, height: UInt) {
    //        if(yuvData != nil){
    //
    //            self.showWindow.image = UIImage(data: yuvData)
    //        }
    //    }
    
    func audioConnect(){
        let account = dict["door_net_ease_account"]
        let callees :NSArray = [account!]
        let currentCallID = NIMSDK.sharedSDK().netCallManager.currentCallID()
        if(currentCallID != 0){
            NIMSDK.sharedSDK().netCallManager.hangup(currentCallID)
        }
        NIMSDK.sharedSDK().netCallManager.addDelegate(self)
        
        let option:NIMNetCallOption = NIMNetCallOption()
        option.preferredVideoQuality = .QualityDefault
        
        log.debug("[云信 audioConnect]")
        NIMSDK.sharedSDK().netCallManager.start(callees as! [String], type: .Audio, option: option) { (error, callID) in
            if(error != nil){
                log.debug("[云信audioConnect error] callID:\(callID):::error==>\(error)-->\(error?.code)")
                self.answerBtnStatus-=999
                self.answerBtn.enabled = true
                
                switch error!.code as Int{
                case 16:
                    NetEaseService.login()
                default:
                    log.debug("类型未匹配")
                }
                
            }else{
                log.debug("[云信audioConnect] 呼叫成功")
                self.callID = callID
                self.answerLabel.text = "视频通话"
                self.receiver.hidden = false
                self.title = "音频通话中"
                
            }
        }
        
        
    }
    
    
    func changeVideo() {
        if self.callID != nil{
            Notify.toast("切换到视频", type: AppContant.TOAST_SUCCESS)
            
            //            NIMSDK.sharedSDK().netCallManager.switchType(NIMNetCallType.Video)
            NIMSDK.sharedSDK().netCallManager.control(self.callID!, type: NIMNetCallControlType.ToVideo)
        }else{
            self.answerBtnStatus-=999
            self.answerBtn.enabled=true
        }
        
    }
    
    
    func handup() {
        if self.callID != nil{
            NIMSDK.sharedSDK().netCallManager.hangup(callID!)
        }
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        countdown = false
        handup()
    }
    
    func apnsListner(notify: NSNotification){
        let dict = notify.object as! NSDictionary
        switch dict["action"] as! String {
        case AppContant.APNS_NOTIFY_OPEN_DOOR_INTERUPT:
            Notify.toast(dict["msg"] as! String, type: AppContant.TOAST_WARN)
            dismiss();
        default:
            log.debug("类型未匹配")
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func dismiss(){
        if !handUp{
            let currentCallID = NIMSDK.sharedSDK().netCallManager.currentCallID()
            if(currentCallID != 0){
                NIMSDK.sharedSDK().netCallManager.hangup(currentCallID)
            }
        }
        NIMSDK.sharedSDK().netCallManager.removeDelegate(self)
        self.navigationController?.popViewControllerAnimated(true)
        RingService.stopSound()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss()
    }
    
}
