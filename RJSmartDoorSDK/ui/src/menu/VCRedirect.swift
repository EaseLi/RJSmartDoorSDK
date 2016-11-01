//
//  VCRedirectController.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/28.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
import UIKit

public class VCRedirect:MenuBase{
    
    /**
     默认跳转，不带个性化参数
     - parameter vc: <#vc description#>
     */
    public static func COMMOM_REDIRECT(vc:UIViewController,identifier:String){
        super.push2View(vc, identifier: identifier)
    }
    
    //首页
    public static func GLOBAL_MAIN(vc:UIViewController,title:String){
        
        vc.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    //页面复用待重构
    public static func GLOBAL_INFO_TIP(vc:UIViewController,pageTitle:String,title:String,text:String,icon:UIImage,buttonTitle:String,type:String){
        // mainStoryboard
        let storyboard = UIStoryboard(name: AppContant.STORY_BOARD_MAIN, bundle: nil)
        
        let viewController =  storyboard.instantiateViewControllerWithIdentifier(VCIdentify.GLOBAL_INFO_TIP.IDENTIFIER) as! InfoTipViewController
        var dict=Dictionary<String,AnyObject>()
        
        dict["pageTitle"]=pageTitle
        dict["title"]=title
        dict["text"]=text
        dict["icon"]=icon
        dict["buttonTitle"]=buttonTitle
        dict["type"]=type
        
        viewController.dict = dict
        
        vc.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    
    //开通－选择物业
    public static func USER_LOAD_PROPERTY(vc:UIViewController){
        // mainStoryboard
        let storyboard = UIStoryboard(name: AppContant.STORY_BOARD_MAIN, bundle: nil)
        let viewController =  storyboard.instantiateViewControllerWithIdentifier(VCIdentify.USER_LOAD_PROPERTY.IDENTIFIER)
        vc.navigationController?.pushViewController(viewController, animated: false)
    }
    //开通－选择小区
    public static func USER_LOAD_COMMUNITY(vc:UIViewController,communityList:[NSDictionary]){
        let storyboard = UIStoryboard(name: AppContant.STORY_BOARD_MAIN, bundle: nil)
        let viewController =  storyboard.instantiateViewControllerWithIdentifier(VCIdentify.USER_LOAD_COMMUNITY.IDENTIFIER) as! LoadCommunityListViewController
        viewController.communityList = communityList
        vc.navigationController?.pushViewController(viewController, animated: false)
    }
    //开通－选择节点
    public static func USER_LOAD_NODE(vc:UIViewController,nodeList:[NSDictionary]){
        let storyboard = UIStoryboard(name: AppContant.STORY_BOARD_MAIN, bundle: nil)
        let viewController =  storyboard.instantiateViewControllerWithIdentifier(VCIdentify.USER_LOAD_NODE.IDENTIFIER) as! LoadNodeListViewController
        viewController.nodeList = nodeList
        vc.navigationController?.pushViewController(viewController, animated: false)
    }
    //绑定房间
    public static func USER_BIND_ROOM(vc:UIViewController){
        let storyboard = UIStoryboard(name: AppContant.STORY_BOARD_MAIN, bundle: nil)
        let viewController =  storyboard.instantiateViewControllerWithIdentifier(VCIdentify.USER_BIND_ROOM.IDENTIFIER)
        vc.navigationController?.pushViewController(viewController, animated: false)
    }
    
    public static func GLOBAL_CHANGE_ROOM(vc:UIViewController,roomList:[NSDictionary]){
        let viewController =  vc.storyboard!.instantiateViewControllerWithIdentifier(VCIdentify.GLOBAL_CHANGE_ROOM.IDENTIFIER) as! ChangeRoom
        viewController.roomList = roomList
        viewController.modalPresentationStyle = .OverCurrentContext
        
        vc.presentViewController(viewController, animated: true, completion: nil)
        
    }
    
    /**
     图片详情
     
     - parameter vc:  <#vc description#>
     - parameter img: <#img description#>
     */
    public static func GLOBAL_SHOW_IMG(vc:UIViewController,img:UIImage){
        let viewController =  vc.storyboard!.instantiateViewControllerWithIdentifier(VCIdentify.GLOBAL_SHOW_IMG.IDENTIFIER) as! ShowImg
        viewController.image=img
        viewController.modalPresentationStyle = .OverCurrentContext
        
        vc.presentViewController(viewController, animated: false, completion: nil)
        
    }
    
    
    public static func GLOBAL_RING(vc:UIViewController,dict:NSDictionary){
        let viewController =  vc.storyboard!.instantiateViewControllerWithIdentifier(VCIdentify.GLOBAL_RING.IDENTIFIER) as! Ring
        viewController.dict = dict
        
        vc.navigationController?.pushViewController(viewController, animated: true)
//        vc.presentViewController(viewController, animated: false, completion: nil)
    }
    
    /**
     默认跳转，不带个性化参数
     
     - parameter vc:
     */
    public static func COMMOM_REDIRECT(vc:UIViewController,storyboardId:String,identifier:String,title:String){
        super.push2View(vc, storyboardId:storyboardId,identifier: identifier,title:title)
    }
    
    
    /// 获取人脸
    ///
    /// - parameter vc:    <#vc description#>
    /// - parameter title: <#title description#>
    /// - parameter mode:  <#mode description#>
    public static func FACE_TAKE(vc:UIViewController,title:String,mode:Int){
        let storyboard = UIStoryboard(name: VCIdentify.FACE_TAKE.STOTY_BOARD, bundle: nil)
        let viewController =  storyboard.instantiateViewControllerWithIdentifier(VCIdentify.FACE_TAKE.IDENTIFIER) as! TakeFace
        viewController.title = title
        viewController.mode = mode
        vc.navigationController?.pushViewController(viewController, animated: false)
        
    }
    
    /**
     人脸采集确认
     
     - parameter vc:   <#vc description#>
     - parameter face: <#face description#>
     - parameter rect: <#rect description#>
     */
    public static func FACE_CONFIRM(vc:UIViewController,face:UIImage,rect:CGRect,front:Bool,mode:Int){
        let viewController =  vc.storyboard!.instantiateViewControllerWithIdentifier(VCIdentify.FACE_CONFIRM.IDENTIFIER) as! ConfirmFace
        viewController.confirmImg = face
        viewController.rect=rect
        viewController.front = front
        viewController.title = VCIdentify.FACE_CONFIRM.TITLE
        viewController.mode = mode
        vc.navigationController?.pushViewController(viewController, animated: false)
        
    }
    
    //    public static func FACE_CHECK(vc:UIViewController,face:UIImage,rect:CGRect,front:Bool){
    //        let viewController =  vc.storyboard!.instantiateViewControllerWithIdentifier(VCIdentify.FACE_CHECK.IDENTIFIER) as! CheckFace
    //        viewController.confirmImg = face
    //        viewController.rect=rect
    //        viewController.front = front
    //        viewController.title = VCIdentify.FACE_CHECK.TITLE
    //        vc.navigationController?.pushViewController(viewController, animated: false)
    //
    //    }
    
    /**
     公告详情
     
     - parameter vc:   <#vc description#>
     - parameter type: <#type description#>
     - parameter dict: <#dict description#>
     */
    public static func CIRCULAR_DETAIL(vc:UIViewController,type:String,dict:NSDictionary){
        
        switch type {
        case "1":
            let viewController  =  vc.storyboard!.instantiateViewControllerWithIdentifier(VCIdentify.CIRCULAR_DETAIL_TEXT.IDENTIFIER) as! TextCircular
            viewController.dict = dict
            viewController.title = VCIdentify.CIRCULAR_DETAIL_TEXT.TITLE
            vc.navigationController?.pushViewController(viewController, animated: false)
        default:
            let viewController  =  vc.storyboard!.instantiateViewControllerWithIdentifier(VCIdentify.CIRCULAR_DETAIL_IMG.IDENTIFIER) as! ImgCircular
            viewController.dict = dict
            
            viewController.title = VCIdentify.CIRCULAR_DETAIL_TEXT.TITLE
            vc.navigationController?.pushViewController(viewController, animated: false)
        }
        
    }
    
    /**
     验证码
     
     - parameter vc:    <#vc description#>
     - parameter mode:  <#mode description#>
     - parameter title: <#title description#>
     */
    public static func USER_GET_QRCODE(vc:UIViewController,mode:Int,title:String){
        let storyboard = UIStoryboard(name: AppContant.STORY_BOARD_USER, bundle: nil)
        let viewController =  storyboard.instantiateViewControllerWithIdentifier(VCIdentify.USER_GET_QRCODE.IDENTIFIER) as! GetQRCodeViewController
        viewController.title = title
        viewController.mode = mode
        
        vc.navigationController?.pushViewController(viewController, animated: false)
    }
    
    
    public static func CIRCULARL_AD_DETAIL(vc:UIViewController, storyboardId:String,url:String){
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        let viewController =  storyboard.instantiateViewControllerWithIdentifier(VCIdentify.CIRCULAR_AD_DETAIL.IDENTIFIER) as! ADDetail
        viewController.title = VCIdentify.CIRCULAR_AD_DETAIL.TITLE
        viewController.urlString = url
        
        vc.navigationController?.pushViewController(viewController, animated: false)
    }
}
