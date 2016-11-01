//
//  HttpService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/21.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
import Alamofire

public class HttpService {
    
    static var alamofireManager : Manager {
        
        //设置超时
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 10// seconds
        configuration.timeoutIntervalForResource = 10
        
        //设置请求编码
        var defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        defaultHeaders["Accept-Language"] = "zh-CN"
        configuration.HTTPAdditionalHeaders = defaultHeaders
        
        let alamofireManager = Alamofire.Manager(configuration: configuration)
        
        //Almofire进行自签名https请求之前的配置
        alamofireManager.delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: NSURLSessionAuthChallengeDisposition = .PerformDefaultHandling
            var credential: NSURLCredential?
            
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = NSURLSessionAuthChallengeDisposition.UseCredential
                credential = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .CancelAuthenticationChallenge
                } else {
                    credential = alamofireManager.session.configuration.URLCredentialStorage?.defaultCredentialForProtectionSpace(challenge.protectionSpace)
                    
                    if credential != nil {
                        disposition = .UseCredential
                    }
                }
            }
            return (disposition, credential)
        }
        return alamofireManager
    }
    
    
    
    public class func post(url:String,requestData:[String:AnyObject], callback:(response:NSMutableDictionary) -> Void) -> Void {
        log.debug("url==>\(url) requestData==>\(requestData)")
        self.alamofireManager.request(.POST, url, parameters: requestData)
            .validate()
            .responseJSON {  response in
                
                
                let res:NSMutableDictionary = NSMutableDictionary()
                switch response.result {
                case .Success:
                    res.setValue(response.response?.statusCode, forKey: "httpStatus")
                    if let JSON = response.result.value {
                        res.setValue(JSON, forKey: "response")
                    }
                case .Failure(let error):
                    res.setValue(error.code, forKey: "httpStatus")
                    log.warning("HttpServer error==>\(error)")
                }
                
                log.debug("callback==>\(res)")
                callback(response: res)
                
        }
        
    }
    
    public class func multipartUpload(url:String,requestData:[String:AnyObject], file:UIImage, callback:(response:NSMutableDictionary) -> Void){
        
        log.debug("url==>\(url) requestData==>\(requestData)")
        var image:UIImage?
        image = file
        
        self.alamofireManager.upload(.POST, url, multipartFormData: { (multipartFormData) in
            if let _file = image {
                if let fileData = UIImageJPEGRepresentation(_file, 0.5) {
                    multipartFormData.appendBodyPart(data: fileData, name: "files", fileName: "123.jpg", mimeType: "image/jpeg")
                }
            }
            
            for (key, value) in requestData {
                multipartFormData.appendBodyPart(data: String(value).dataUsingEncoding(NSUTF8StringEncoding)!, name: String(key))
            }
            
        }) { (encodingResult) in
            let res:NSMutableDictionary = NSMutableDictionary()
            switch encodingResult {
            case .Success(let upload, _, _):
                upload.responseJSON { response in
                    
                    log.debug(response)
                    switch response.result{
                    case .Success:
                        res.setValue(response.response?.statusCode, forKey: "httpStatus")
                        if let JSON = response.result.value {
                            res.setValue(JSON, forKey: "response")
                        }
                    case .Failure(let error):
                        res.setValue(error.code, forKey: "httpStatus")
                        log.warning("HttpServer error==>\(error)")
                        
                    }
                    
                    callback(response: res)
                    
                }
                
            case .Failure(let encodingError):
                print(encodingError)
                res.setValue("500", forKey: "httpStatus")
                callback(response: res)
                
            }
            
        }
        
        
    }
    
}
