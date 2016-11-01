//
//  ConfirmFace.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/4.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import Qiniu
import SwiftyJSON

class ConfirmFace: BaseView {
    
    var mode:Int!
    
    var confirmImg:UIImage?
    var rect:CGRect?
    var front = true
    var isSetSuccess = false
    
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var process: UIProgressView!
    
    var uploadStatus = false{
        didSet {
            if !uploadStatus{
                self.process.hidden = true
                self.uploadBtn.enabled = true
            }else{
                self.process.hidden = false
                self.uploadBtn.enabled = false
            }
        }
    }
    
    
    //    @IBOutlet weak var confirmImgView: UIImageView!
    var confirmImgView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode==1{
            uploadBtn.setTitle("开始验证", forState: .Normal)
            
        }
        
        uploadStatus=false
        
        let img = UIImage.aspectToFill(confirmImg!, newSize: UIScreen.mainScreen().bounds.size)
        
        let uploadImg =  cutImg(img,rect: rect!)
        confirmImgView = UIImageView(frame: rect!)
        confirmImgView.image = uploadImg
        confirmImgView.layer.cornerRadius = confirmImgView.frame.width/2
        confirmImgView.layer.masksToBounds = true
        confirmImgView.layer.borderWidth = 5
        confirmImgView.layer.borderColor = UIColor.whiteColor().CGColor
        self.view.addSubview(confirmImgView)
        if front{
            confirmImgView.transform =  CGAffineTransformMakeScale(-1, 1)
        }
        
        let transform = CGAffineTransformMakeScale(1.0, 3)
        process.transform = transform;
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func upload(sender: AnyObject) {
        beginUpload()
        
    }
    
    @IBAction func toTakeFace(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /**
     图片截取
     
     - parameter img:  <#img description#>
     - parameter rect: <#rect description#>
     
     - returns: <#return value description#>
     */
    func cutImg(img:UIImage,rect:CGRect)->UIImage{
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(img.CGImage!, rect)!
        return UIImage(CGImage: imageRef)
    }
    
    /**
     获取token
     
     - returns: <#return value description#>
     */
    
    func beginUpload() {
        switch mode {
        case 1:
            FaceService.faceRecognitionToken { (result) in
                if !self.checkResponseStatus(result){
                    return
                }
                if result["response"]!["content"]!!["token"] != nil{
                    let token = result["response"]!["content"]!!["token"]  as! String
                    self.sendToQN(token)
                }
            }
        case 2:
            
            let info = CacheService.sharedInstance.get("PageValue.ModifyFace.info") as! NSDictionary
            let persion_id = info["persion_id"] as! String
            let face_id = info["face_id"] as! String
            FaceService.faceModify(persion_id,face_id: face_id, completion: { (result) in
                if !self.checkResponseStatus(result){
                    return
                }
                
                if result["response"]!["content"]!!["token"] != nil{
                    let token = result["response"]!["content"]!!["token"]  as! String
                    self.sendToQN(token)
                }
            })
        default:
            FaceService.faceUploadToken { (result) in
                if !self.checkResponseStatus(result){
                    return
                }
                if result["response"]!["content"]!!["token"] != nil{
                    let token = result["response"]!["content"]!!["token"]  as! String
                    self.sendToQN(token)
                }
                
                
                
            }
        }
        
        
    }
    
    func sendToQN(token:String){
        
        
        //        let img = UIImage.aspectToFill(confirmImgView.image!, newSize: confirmImgView.frame.size)
        
        //        let uploadImg =  cutImg(confirmImg!,rect: rect!)
        let imageData: NSData? = UIImageJPEGRepresentation(confirmImgView.image!, 1);
        
        let upManager = QNUploadManager()
        
        let opt = QNUploadOption.init(mime: nil, progressHandler: { (key: String!, percent: Float) in
            print(percent)
            dispatch_async(dispatch_get_main_queue(), {
                self.process.progress = percent
            })
            
            }, params: nil, checkCrc: false, cancellationSignal: nil)
        
        uploadStatus = true
        upManager.putData(imageData, key:FileUtils.generateFileName(String(DataUtils.household_id)), token: token, complete: { (info: QNResponseInfo!, key: String!, resp: [NSObject : AnyObject]!) in
            print("info: \(info.description) resp: \(resp)")
            
            self.uploadStatus = false
            if info.statusCode == 200{
                let status = resp["status"] as! Int
                if status == 0{
                    self.isSetSuccess = true
                    
                    switch self.mode{
                    case 0,2:
                        
                        FaceService.faceList({ (result) in
                            if !self.checkResponseStatus(result){
                                return
                            }
                            
                            if let list = result["response"]!["content"]!!["list"]  as? [NSDictionary] where list.count>0{
                                CacheService.sharedInstance.set("face_list", value: list)
                            }
                            
                        })
                        VCRedirect.GLOBAL_INFO_TIP(self,pageTitle: "人脸识别", title: "上传成功", text: "现在开始，点击门禁机的识别按钮，进入人脸识别开门模式，验证成功即可开门", icon: UIImage(named: "ok" )!, buttonTitle: "好的",type: AppContant.INFO_TIP_FACE_SUCCESS)
                    default:
                        VCRedirect.GLOBAL_INFO_TIP(self,pageTitle: "人脸识别", title: "验证成功", text: "现在开始，点击门禁机的识别按钮，进入人脸识别开门模式，验证成功即可开门", icon: UIImage(named: "ok" )!, buttonTitle: "好的",type: AppContant.INFO_TIP_FACE_SUCCESS)
                        
                    }
                    
                    
                }else{
                    switch self.mode{
                    case 1:
                        CacheService.sharedInstance.set("PageValue.ConfirmFace.error_msg", value: resp["message"] as! String)
                        VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.FACE_CHECK_FAIL.STOTY_BOARD, identifier: VCIdentify.FACE_CHECK_FAIL.IDENTIFIER, title: VCIdentify.FACE_CHECK_FAIL.TITLE)
                    default:
                        Notify.toast(resp["message"] as! String, type: AppContant.TOAST_WARN)
                        
                    }
                    
                    
                }
            }else{
                Notify.toast("上传失败\(info.statusCode)", type: AppContant.TOAST_WARN)
            }
            }, option: opt!)
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        if self.isSetSuccess{
            var viewControllers = [UIViewController]()
            viewControllers.append((self.navigationController?.viewControllers[0])!)
            viewControllers.append((self.navigationController?.viewControllers.popLast())!)
            self.navigationController?.viewControllers = viewControllers
        }
    }
    
    //
    //    // MARK: Rect
    //    func makeFocusWindowRect() -> CGRect {
    //        let focusSize = (min(screenWidth, screenHeight) * 64) / 73
    //        var focusRect = CGRectMake(0, 0, focusSize, focusSize)
    //
    //        focusRect.origin.x += (screenWidth / 2) - (focusRect.size.width / 2)
    //        focusRect.origin.y += (screenHeight / 2) - (focusRect.size.height / 2)-10
    //
    //        return focusRect
    //    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
