//
//  SetAvatar.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/12.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import SDWebImage

class SetAvatar: BaseView ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var photo: UIView!
    @IBOutlet weak var camera: UIView!
    
    let imagePickerController: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarView.layoutIfNeeded()
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = avatarView.bounds.width/2
        let imgurl = DataUtils.avatar
        if imgurl.isEmpty{
            avatarView.image = UIImage(named: "user-default-avatar")
        }else{
            avatarView.sd_setImageWithURL(NSURL(string: imgurl), placeholderImage:  UIImage(named: "user-default-avatar"))
        }
        
        
        // 设置代理
        self.imagePickerController.delegate = self
        // 设置是否可以管理已经存在的图片或者视频
        self.imagePickerController.allowsEditing = true
        
        photo.addOnClickListener(self, action: #selector(SetAvatar.fromPhoto))
        camera.addOnClickListener(self, action: #selector(SetAvatar.fromCamera))
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        
        UserService.uploadAvatar(FileUtils.generateFileName(String(DataUtils.household_id)), image: image) { (result) in
            log.debug(result)
            if !self.checkResponseStatus(result){
                return
            }
            
            DataUtils.setAvatar(result["response"]!["content"]!!["avatar_url"] as! String)
            NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_CHANGE_AVATAR, object: VCIdentify.GLOBAL_ABOUT.IDENTIFIER)
            self.avatarView.image = image
        }
        
        //        FileUtils.generateFileName(String(DataUtils.household_id))
        imagePickerController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fromPhoto(){
        self.imagePickerController.sourceType = .PhotoLibrary
        self.presentViewController(self.imagePickerController, animated: true, completion: nil)
    }
    
    
    func fromCamera(){
        if(!DeviceUtils.cameraPermissions()){
            let alertView = UIAlertView()
            alertView.title="系统提示"
            alertView.message="请先开启摄像头权限"
            alertView.addButtonWithTitle("确定")
            alertView.delegate =  self
            alertView.cancelButtonIndex=0
            alertView.show()
        }else{
            self.imagePickerController.sourceType = .Camera
            self.presentViewController(self.imagePickerController, animated: true, completion: nil)
        }
        
    }
    
    func alertView(alertView:UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        let settingUrl = NSURL(string: UIApplicationOpenSettingsURLString)!
        if UIApplication.sharedApplication().canOpenURL(settingUrl)
        {
            UIApplication.sharedApplication().openURL(settingUrl)
        }
    }
    
    
    
}
