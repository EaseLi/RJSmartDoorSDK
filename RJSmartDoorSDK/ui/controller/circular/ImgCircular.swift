//
//  ImgCircular.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/11.
//  Copyright © 2016年 Ruijia. All rights reserved.
//



import UIKit

import SDWebImage



class ImgCircular: BaseView {

    @IBOutlet weak var circularTitle: UILabel!
    @IBOutlet weak var circularImgView: UIImageView!
    @IBOutlet weak var inscribe: UILabel!
    
     var dict =  NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circularTitle.text = dict["title"] as? String

        
        let publishers = dict["publishers"] as! String
        let up_time = dict["up_time"] as! String
        
        let string = "\(publishers)\n\(up_time)" as NSString
        let attributedString = NSMutableAttributedString(string: string as String)
        let subTitleAttributes = [NSForegroundColorAttributeName: UIColor.grayColor(),NSFontAttributeName: UIFont.systemFontOfSize(inscribe.font.pointSize-2)]
        attributedString.addAttributes(subTitleAttributes, range:string.rangeOfString(up_time))
        
        inscribe.numberOfLines = 0
        inscribe.attributedText = attributedString

        
        circularImgView.sd_setImageWithURL(NSURL(string: dict["context"] as! String), placeholderImage: UIImage(named: "img-loading"))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
