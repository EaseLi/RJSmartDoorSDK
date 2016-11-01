//
//  Record.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/18.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD
import SDWebImage

class Record: BaseView,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var recordList = [RecordModel]()
    
    var objectArray = [String]()
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="开门记录"
        
        segment.selectedSegmentIndex = 0
        currentSelectedSegmentIndex = segment.selectedSegmentIndex
        segment.addTarget(self, action: #selector(Record.segmentDidchange(_:)), forControlEvents: .ValueChanged)
        
        tableView.delegate=self
        tableView.dataSource = self
        tableView.tableFooterView=UIView()
        
        loadData(segment.selectedSegmentIndex) {
            
        }
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self,refreshingAction: #selector(Record.headRefresh))
        self.tableView.mj_footer = MJRefreshBackGifFooter(refreshingTarget: self,refreshingAction: #selector(Record.footRefresh))
        
        // Do any additional setup after loading the view.
    }
    
    func segmentDidchange(segmented:UISegmentedControl){
        //获得选项的索引
        print(segmented.selectedSegmentIndex)
        //获得选择的文字
        print(segmented.titleForSegmentAtIndex(segmented.selectedSegmentIndex))
        
        currentSelectedSegmentIndex = segmented.selectedSegmentIndex
        self.offset=0
        self.recordList.removeAll()
        loadData(currentSelectedSegmentIndex) {
            
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return recordList.count
    }
    
    /**
     构造cell
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     
     - returns: cell
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView .dequeueReusableCellWithIdentifier("RecordCell", forIndexPath: indexPath) as! RecordCell
        cell.selectionStyle = .None
        cell.record.numberOfLines=0
        let title = recordList[indexPath.row].title
        let content = recordList[indexPath.row].content
        let string = "\(title)\n\(content)" as NSString
        let attributedString = NSMutableAttributedString(string: string as String)
        let subTitleAttributes = [NSForegroundColorAttributeName: UIColor.grayColor(),NSFontAttributeName: UIFont.systemFontOfSize(cell.record.font.pointSize-2)]
        attributedString.addAttributes(subTitleAttributes, range:string.rangeOfString(content))
        
        cell.record.attributedText = attributedString
        cell.img.sd_setImageWithURL(NSURL(string: recordList[indexPath.row].imageUrl), placeholderImage: UIImage(named: "img-loading"))
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(Record.showImg(_:)))
        cell.img.userInteractionEnabled = true
        cell.img.addGestureRecognizer(tapGestureRecognizer)
        
        //        cell.img.addOnClickListener(self, action:#selector(Record.showImg(_:)))
        
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func headRefresh(){
        
        
        SVProgressHUD.showWithStatus("数据重新刷新中...")
        self.offset=0
        self.recordList.removeAll()
        loadData(currentSelectedSegmentIndex) {
            self.tableView.mj_header.endRefreshing()
            SVProgressHUD.dismiss()
        }
        
        
    }
    
    func footRefresh(){
        SVProgressHUD.showWithStatus("数据加载中...")
        loadData(currentSelectedSegmentIndex) {
            self.tableView.mj_footer.endRefreshing()
            SVProgressHUD.dismiss()
        }
    }
    
    
    
    var offset = 0
    var limit = 10
    var  currentSelectedSegmentIndex = 0
    
    func loadData(type:Int,closure:()->()) {
        
        let room_node_id = room.roomNodeId
        switch type {
        case 0:
            
            RecordService.loadCallList(room_node_id, offset: offset, limit: limit) { (result) in
                
                closure()
                if !self.checkResponseStatus(result){
                     self.tableView.reloadData()
                    return
                }
                
                if let memberArray = result["response"]!["content"]!!["list"]  as? [NSDictionary]{
                    for dic in memberArray{
                        let value = RecordModel(fromDictionary: dic)
                        self.recordList.append(value)
                    }
                }
                self.offset += self.limit
              
                if self.recordList.count > 0 {
                    self.tableView.tableHeaderView = nil
                    self.tableView.userInteractionEnabled = true
                   
                }else{
                    let emptyList = EmptyList()
                    emptyList.frame = self.tableView.frame
                    self.tableView.tableHeaderView = emptyList
                    self.tableView.userInteractionEnabled = false
                    
                }
                 self.tableView.reloadData()
            }
        default:
            RecordService.loadOpenLockList(room_node_id, offset: offset, limit: limit, completion: { (result) in
                closure()
                if !self.checkResponseStatus(result){
                     self.tableView.reloadData()
                    return
                }
                
                if let memberArray = result["response"]!["content"]!!["list"]  as? [NSDictionary]{
                    for dic in memberArray{
                        let value = RecordModel(fromDictionary: dic)
                        self.recordList.append(value)
                    }
                }
                self.offset += self.limit
                if self.recordList.count > 0 {
                    self.tableView.tableHeaderView = nil
                    self.tableView.userInteractionEnabled = true
                 
                }else{
                    let emptyList = EmptyList()
                    emptyList.frame = self.tableView.frame
                    self.tableView.tableHeaderView = emptyList
                    self.tableView.userInteractionEnabled = false
                    
                }
                self.tableView.reloadData()
            })
        }
        
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableView.mj_footer.endRefreshing()
        SVProgressHUD.dismiss()
    }
    
    
    func showImg(sender:UITapGestureRecognizer){
        
        let imgView = sender.view as! UIImageView
        VCRedirect.GLOBAL_SHOW_IMG(self, img: imgView.image!)
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
