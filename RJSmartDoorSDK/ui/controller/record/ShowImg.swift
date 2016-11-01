//
//  ShowImg.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/21.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import SDWebImage

class ShowImg: BaseView,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var img: UIImageView!
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.img.sd_setImageWithURL(NSURL(string: imgUrl), placeholderImage: UIImage(named: "about"))
        img.image=image
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        view.opaque = false
        
        initDissMissEvent()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initDissMissEvent(){
        let gr = UITapGestureRecognizer(target: self, action: #selector(ShowImg.dissMiss))
        gr.numberOfTapsRequired = 1
        gr.delegate=self
        view.addGestureRecognizer(gr)
    }
    
    func dissMiss(){
        self.dismissViewControllerAnimated(false, completion: nil)
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
