//
//  FaceList.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/29.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import SDWebImage

class FaceList: BaseView,UIScrollViewDelegate {
    
    let KScreenWidth = UIScreen.mainScreen().bounds.width
    let KScreenHeight = UIScreen.mainScreen().bounds.height
    
    @IBOutlet weak var listScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        self.automaticallyAdjustsScrollViewInsets = false
        initList()
        
    }
    
    func initList(){
        for view in listScrollView.subviews{
            view.removeFromSuperview()
        }
        
        //为了让内容横向滚动，设置横向内容宽度为页面的宽度总和
        listScrollView.layoutIfNeeded()
        listScrollView.contentSize.width =  KScreenWidth * 5
        listScrollView.pagingEnabled = true
        listScrollView.showsHorizontalScrollIndicator = false
        listScrollView.showsVerticalScrollIndicator = false
        listScrollView.scrollsToTop = false
        listScrollView.delegate=self
        listScrollView.backgroundColor = UIColor.fromRGB("EFEFF4")
        
        
        let height = listScrollView.frame.height
        let padding = (KScreenWidth - height)/2
        
        
        if let faceDic = CacheService.sharedInstance.get("face_list") as? [NSDictionary]  where faceDic.count>0{
            
            //满5张脸
            if faceDic.count>=5{
                for index in 0...4{
                    let facecard = faceCard()
                    facecard.face.sd_setImageWithURL(NSURL(string: faceDic[index]["image_url"] as! String), placeholderImage: UIImage(named: "img-loading"))
                    facecard.frame = CGRect(x: CGFloat(index)*KScreenWidth + padding,y: 0,width: height,height: height)
                    facecard.backgroundColor = ColorUtils.getColor(index)
                    facecard.layer.cornerRadius=10
                    facecard.layer.masksToBounds=true
                    facecard.face_id.text = faceDic[index]["face_id"] as? String
                    facecard.persion_id.text = faceDic[index]["person_id"] as? String
                    
                    let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(FaceList.deal(_:)))
                    facecard.userInteractionEnabled = true
                    facecard.addGestureRecognizer(tapGestureRecognizer)
                    
                    listScrollView.addSubview(facecard)
                }
                
            }else{
                //未满
                for index in 0...faceDic.count-1{
                    let facecard = faceCard()
                    facecard.face.sd_setImageWithURL(NSURL(string: faceDic[index]["image_url"] as! String), placeholderImage: UIImage(named: "img-loading"))
                    facecard.frame = CGRect(x: CGFloat(index)*KScreenWidth + padding,y: 0,width: height,height: height)
                    facecard.layer.cornerRadius=10
                    facecard.layer.masksToBounds=true
                    facecard.face_id.text = faceDic[index]["face_id"] as? String
                    facecard.persion_id.text = faceDic[index]["person_id"] as? String
                    
                    let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(FaceList.deal(_:)))
                    facecard.userInteractionEnabled = true
                    facecard.addGestureRecognizer(tapGestureRecognizer)
                    
                    listScrollView.addSubview(facecard)                }
                
                for index in faceDic.count...4{
                    let face = emptyFace()
                    
                    face.frame = CGRect(x: CGFloat(index)*KScreenWidth + padding,y: 0,width: height,height: height)
                    
                    face.layer.cornerRadius=10
                    face.layer.masksToBounds=true
                    
                    face.addOnClickListener(self, action: #selector(FaceList.addFace))
                    
                    listScrollView.addSubview(face)
                }
                
                
            }
            
        }
        
        
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
        var frame = listScrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        //展现当前页面内容
        listScrollView.setContentOffset(frame.origin, animated: true)
        
    }
    
    func deal(sender:UITapGestureRecognizer){
        log.debug("deal deal")
        let alertController = UIAlertController()
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "删除头像", style: UIAlertActionStyle.Destructive){
            (action: UIAlertAction!) -> Void in
            log.debug("删除头像")
            let face = sender.view as! faceCard
            let face_id = face.face_id.text!
            let persion_id = face.persion_id.text!
            
            FaceService.faceRemove(persion_id, face_id: face_id, completion: { (result) in
                if !self.checkResponseStatus(result){
                    return
                }
                Notify.toast("删除成功", type: AppContant.TOAST_SUCCESS)
                
                //reload data
                FaceService.faceList({ (result) in
                    if !self.checkResponseStatus(result){
                        return
                    }
                    
                    if let list = result["response"]!["content"]!!["list"]  as? [NSDictionary] where list.count>0{
                        CacheService.sharedInstance.set("face_list", value: list)
                        self.initList()
                    }else{
                        VCRedirect.GLOBAL_INFO_TIP(self,pageTitle: "人脸识别", title: "未启用", text: "你可以在此上传头像，验证后可在门禁机上使用人脸识别开门", icon: UIImage(named: "forbidden" )!, buttonTitle: "设置",type: AppContant.INFO_TIP_FACE_CONFIRM)
                    }
                })
                
            })
            
        }
        
        let archiveAction = UIAlertAction(title: "重新上传", style: UIAlertActionStyle.Default){
            (action: UIAlertAction!) -> Void in
            log.debug("重新上传")
            let face = sender.view as! faceCard
            let info = ["face_id": face.face_id.text!,"persion_id": face.persion_id.text!]
            CacheService.sharedInstance.set("PageValue.ModifyFace.info", value: info)
            
            VCRedirect.FACE_TAKE(self, title: "人脸识别", mode: 2)
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        alertController.addAction(archiveAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func addFace(){
        VCRedirect.FACE_TAKE(self, title: "人脸识别", mode: 0)
    }
    
    
}
