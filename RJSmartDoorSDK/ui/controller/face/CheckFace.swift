//
//  CheckFace.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/28.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import Qiniu
import SwiftyJSON

class CheckFace: BaseView {
    var confirmImg:UIImage?
    var rect:CGRect?
    var front = true
    var isSetSuccess = false
    
    @IBOutlet weak var process: UIProgressView!
    
    var uploadStatus = false{
        didSet {
            if !uploadStatus{
                self.process.hidden = true
            }else{
                self.process.hidden = false
            }
        }
    }
    
    
    //    @IBOutlet weak var confirmImgView: UIImageView!
    var confirmImgView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CacheService.sharedInstance.set("ViewController.CheckFace", value: self)
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
        
        FaceService.faceRecognitionToken { (result) in
            if !self.checkResponseStatus(result){
                return
            }
            if result["response"]!["content"]!!["token"] != nil{
                let token = result["response"]!["content"]!!["token"]  as! String
                self.sendToQN(token)
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
                    VCRedirect.GLOBAL_INFO_TIP(self,pageTitle: "人脸识别", title: "验证成功", text: "现在开始，点击门禁机的识别按钮，进入人脸识别开门模式，验证成功即可开门", icon: UIImage(named: "ok" )!, buttonTitle: "好的",type: AppContant.INFO_TIP_FACE_SUCCESS)
                }else{
                    CacheService.sharedInstance.set("PageValue.CheckFace.failmessage", value: resp["message"] as! String)
                    VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.FACE_CHECK_FAIL.STOTY_BOARD, identifier: VCIdentify.FACE_CHECK_FAIL.IDENTIFIER, title: VCIdentify.FACE_CHECK_FAIL.TITLE)
                }
                
            }else{
                CacheService.sharedInstance.set("PageValue.CheckFace.failmessage", value: "上传验证失败\(info.statusCode)")
                VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.FACE_CHECK_FAIL.STOTY_BOARD, identifier: VCIdentify.FACE_CHECK_FAIL.IDENTIFIER, title: VCIdentify.FACE_CHECK_FAIL.TITLE)
            }
            }, option: opt!)
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //        if self.isSetSuccess{
        //            var viewControllers = [UIViewController]()
        //            viewControllers.append((self.navigationController?.viewControllers[0])!)
        //            viewControllers.append((self.navigationController?.viewControllers.popLast())!)
        //            self.navigationController?.viewControllers = viewControllers
        //        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        beginUpload()
    }
}
