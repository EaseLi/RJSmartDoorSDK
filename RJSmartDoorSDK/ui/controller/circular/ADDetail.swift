//
//  ADDetail.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/15.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class ADDetail: BaseView {
    
    var urlString:String!
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)

    }
    

}
