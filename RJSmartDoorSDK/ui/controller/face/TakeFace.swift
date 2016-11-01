//
//  TakeFace.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/3.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import AVFoundation


class TakeFace: BaseView {
    
    var mode:Int!
    
    @IBOutlet weak var previewView: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var switchBtn: UIButton!
    @IBOutlet weak var tip: UILabel!
    
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    let screenSize = UIScreen.mainScreen().bounds.size
    
    
    //前后摄像头--true前 false后
    var front =  true
    var shadowView:UIView! = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if mode==1{
            button.setTitle("验证", forState: .Normal)
            CacheService.sharedInstance.set("ViewController.CheckFace", value: self)
        }else{
            CacheService.sharedInstance.set("ViewController.TakeFace", value: self)
        }
        
        setUI()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillEnterForeground(_:)), name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func applicationWillEnterForeground(notification: NSNotification) {
        print("did enter foreground")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCamera()
        if(!DeviceUtils.cameraPermissions()){
            let alertView = UIAlertView()
            alertView.title="系统提示"
            alertView.message="请先开启摄像头权限"
            alertView.addButtonWithTitle("确定")
            alertView.delegate =  self
            alertView.cancelButtonIndex=0
            alertView.show()
        }
        
    }
    
    func alertView(alertView:UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        let settingUrl = NSURL(string: UIApplicationOpenSettingsURLString)!
        if UIApplication.sharedApplication().canOpenURL(settingUrl)
        {
            UIApplication.sharedApplication().openURL(settingUrl)
        }
    }
    
    @IBAction func didTakePhoto(sender: AnyObject) {
        if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo) {
            // ...
            // Code for photo capture goes here...
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (sampleBuffer, error) -> Void in
                // ...
                // Process the image data (sampleBuffer) here to get an image file we can put in our captureImageView
                if sampleBuffer != nil {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider!, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    // ...
                    // Add the image to captureImageView here...
                    //                    self.captureImageView.image = image
                    
                    //                    image = UIImage.resizeImage(image, newSize: self.previewView.frame.size)
                    VCRedirect.FACE_CONFIRM(self, face: image, rect: self.makeFocusWindowRect(),front:self.front,mode: self.mode)
                    
                }
            })
        }
        
    }
    
    
    @IBAction func changeCamera(sender: AnyObject) {
        
        front = !front
        loadCamera()
    }
    
    
    func loadCamera(){
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSessionPresetPhoto
        
        //        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var captureDevice:AVCaptureDevice! = nil
        if front {
            let videoDevices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
            
            
            for device in videoDevices{
                let device = device as! AVCaptureDevice
                if device.position == AVCaptureDevicePosition.Front {
                    captureDevice = device
                    break
                }
            }
        } else {
            captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        }
        
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: captureDevice)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        
        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            // ...
            // The remainder of the session setup will go here...
        }
        
        
        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        if session!.canAddOutput(stillImageOutput) {
            session!.addOutput(stillImageOutput)
            // ...
            // Configure the Live Preview here...
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
            videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
            
            
            
            if shadowView != nil{
                shadowView.removeFromSuperview()
                videoPreviewLayer?.removeFromSuperlayer()
            }
            
            shadowView = makeShadowView(makeFocusWindowRect())
            self.view.layer.insertSublayer(videoPreviewLayer!, atIndex: 0)
            self.view.addSubview(shadowView)
            
            previewView.layer.addSublayer(videoPreviewLayer!)
            session!.startRunning()
        }
        
        videoPreviewLayer!.frame = previewView.bounds
        self.view.bringSubviewToFront(button)
        self.view.bringSubviewToFront(tip)
        self.view.bringSubviewToFront(switchBtn)
        
    }
    
    func setUI(){
        self.view.layoutIfNeeded()
        let rect = makeFocusWindowRect()
        
        let smallCircleSize = rect.size.width
        let smallCircleX = rect.origin.x
        let smallCircleY = rect.origin.y
        
        let smallCircle = UIImageView(frame: CGRectMake(smallCircleX , smallCircleY , smallCircleSize, smallCircleSize))
        smallCircle.image = UIImage(named: "face-small-circle")
        self.view.addSubview(smallCircle)
        
        
    }
    
    
    func makeShadowView(innerRect: CGRect) -> UIView {
        let referenceImage = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        
        UIGraphicsBeginImageContext(referenceImage.frame.size)
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetRGBFillColor(ctx!, 0, 0, 0, 0.5)
        let drawRect = CGRectMake(0, 0, screenWidth, screenHeight)
        CGContextFillRect(ctx!, drawRect)
        
        let clearRect = CGRectMake(innerRect.origin.x - referenceImage.frame.origin.x, innerRect.origin.y - referenceImage.frame.origin.y, innerRect.size.width, innerRect.size.height)
        CGContextAddEllipseInRect(ctx!, clearRect);
        CGContextClip(ctx!)
        CGContextClearRect(ctx!, clearRect)
        CGContextDrawPath(ctx!, .Stroke)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        referenceImage.image = image
        
        
        return referenceImage
    }
    
    // MARK: Rect
    func makeFocusWindowRect() -> CGRect {
        let focusSize = (min(screenWidth, screenHeight) * 64) / 73
        var focusRect = CGRectMake(0, 0, focusSize, focusSize)
        
        focusRect.origin.x += (screenWidth / 2) - (focusRect.size.width / 2)
        focusRect.origin.y += (screenHeight / 2) - (focusRect.size.height / 2)-10
        
        return focusRect
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
