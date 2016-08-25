//
//  GoodsItemDetailViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/6.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit
import Alamofire



class GoodsItemDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentcountLabel: UILabel!
    @IBOutlet weak var descritionLabel: UILabel!
    @IBOutlet weak var bannerView: BanerImagesScrollView!
    
    @IBOutlet weak var titleTableview: UITableView!
    
    @IBOutlet weak var commentTableView: UITableView!
    
    @IBOutlet weak var collectButton: UIButton!
    
    @IBOutlet weak var voteButton: UIButton!
    
    
    var comment:NSMutableDictionary = NSMutableDictionary()
    var cellHeight:[CGFloat]=[44]
    
    var goods:GoodsModelItem?
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configView()
        queryIsVoted()
        queryIsCollectioned()
        // Do any additional setup after loading the view.
    }
    
    func configView()
    {
        
        bannerView.imgsURL = imgURLS
        
        titleTableview.delegate = self
        titleTableview.dataSource = self
        titleTableview.scrollEnabled = false
        
        titleTableview.registerNib(UINib(nibName: "DetailTitleTableViewCell",bundle: nil), forCellReuseIdentifier: "title")
        titleTableview.registerNib(UINib(nibName: "CustomTableViewCell",bundle: nil), forCellReuseIdentifier: "titleT")
        
        titleTableview.separatorStyle = .None
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.scrollEnabled = false
        commentTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "comment")
        commentTableView.registerNib(UINib(nibName: "CommentTableViewCell",bundle: nil), forCellReuseIdentifier: "commentCustom")
        commentTableView.separatorStyle = .None
        
        
        descritionLabel.text = goods?.titleDescription
        
        
    }
    func updateFrame(){
        
        var height:CGFloat = 0
        for ch in cellHeight {
            height += ch
        }
        commentView.frame = CGRectMake(commentView.frame.origin.x, commentView.frame.origin.y, commentView.frame.width, height)
        
        commentTableView.frame = CGRectMake(commentTableView.frame.origin.x, commentTableView.frame.origin.y, commentTableView.frame.width, height-44)
        let constraints = commentView.constraints
        for constraint in constraints {
            if constraint.firstAttribute == NSLayoutAttribute.Height {
                constraint.constant = height
            }
        }
        let constraintsComment = commentView.constraints
        for constraint in constraintsComment {
            if constraint.firstAttribute == NSLayoutAttribute.Height {
                constraint.constant = height
            }
        }
        
        
        commentTableView.setNeedsDisplay()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK -- tableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1001{
            return 3
        }
        else{
            return 4
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let row = indexPath.row
        
        print("tag:\(tableView.tag),row:\(row)")
        if tableView.tag == 1001{
            
            
            if row == 0 {
                return 80
            }
            return 44
            
        }else{
            updateFrame()
            
            
            print("ch:\(cellHeight[row])")
            return cellHeight[row]
            
        }
        
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if tableView.tag == 1001{
            
            switch row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("title", forIndexPath: indexPath) as! DetailTitleTableViewCell
                cell.titleLabel.text = goods!.title
                cell.selectionStyle = .None
                return cell
                
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("titleT", forIndexPath: indexPath) as! CustomTableViewCell
                cell.leftLabel.text = "已售46件"
                cell.rightLabel.text = "四川"
                cell.selectionStyle = .None
                
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("titleT", forIndexPath: indexPath) as! CustomTableViewCell
                cell.leftLabel.text = goods?.post_saleService
                cell.selectionStyle = .None
                
                return cell
            }
            
        }else{
            switch row {
            case 3:
                let cell = tableView.dequeueReusableCellWithIdentifier("comment", forIndexPath: indexPath)
                let button = UIButton(frame: CGRectMake(0,0,cell.frame.width,cell.frame.height))
                cell.addSubview(button)
                cellHeight.insert(44, atIndex:cellHeight.count)
                
                button.setTitle("查看更多", forState: .Normal)
                button.setTitleColor(UIColor(rgb: seperatorRGB), forState: .Normal)
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("commentCustom", forIndexPath: indexPath) as! CommentTableViewCell
                cell.selectionStyle = .None
                cell.comment = comment
                
                cellHeight.insert(cell.cellHeight(indexPath), atIndex:row)
                
                return cell
            }
            
            
        }
    }
    
}

extension GoodsItemDetailViewController{
    
    @IBAction func voteButtonClicked(sender: UIButton) {
        
        let goodsId = goods!.id
        let prefix = BaseUrlRequset()
        if goods?.voteStatus != true {
            let url = prefix.vote.stringByAppendingString("addOne?userId=\(currentUserId)&&voteGoodsId=\(goodsId!)")
            SuzeeRequest.shareInstance.request("vote",url:url) { (flag, value) in
                print("value:\(value)")
                if flag{
                    self.goods?.voteStatus = true
                    self.goods?.voteId = value as? NSNumber
                    sender.setImage(UIImage(named:"icon_tabbar_discovery_selected" ), forState: .Normal)
                }}
        }else{
            let id = goods?.voteId
            let url = prefix.vote.stringByAppendingString("delete?id=\(id!)")
            SuzeeRequest.shareInstance.request("vote",url:url) { (flag, value) in
                print("vote::::\(value)")

                if 1 == value as? NSNumber{
                    self.goods?.voteStatus = false
                    self.goods?.voteId = nil
                    sender.setImage(UIImage(named:"icon_tabbar_discovery" ), forState: .Normal)
                }}
            
        }

        
        
        
    }
    @IBAction func collectionButtonClicked(sender: AnyObject) {
        
        let goodsId = goods!.id
        let prefix = BaseUrlRequset()
        if goods?.collectionStatus != true {
            let url = prefix.collection.stringByAppendingString("addOne?userId=\(currentUserId)&&goodsId=\(goodsId!)")
            print("url::::\(url)")
            SuzeeRequest.shareInstance.request("collection",url:url) { (flag, value) in
                print("value:\(value)")
                if value != nil{
                    self.goods?.collectionStatus = true
                    self.goods?.collectionId = value as? NSNumber
                     sender.setImage(UIImage(named:"item_del_collect_02" ), forState: .Normal)
                }}
        }else{
            let id = goods?.collectionId
            let url = prefix.collection.stringByAppendingString("deleteOne?id=\(id!)")
            print("url::::\(url)")
            SuzeeRequest.shareInstance.request("collection",url:url) { (flag, value) in
                print("vote::::\(value)")
                
                if 1 == value as? NSNumber{
                    self.goods?.collectionStatus = false
                    self.goods?.collectionId = nil
                    sender.setImage(UIImage(named:"item_collect_02" ), forState: .Normal)
                }}
            
        }
        
        
        
     
        
    }
    
    @IBAction func messageButtonClicked(sender: AnyObject) {
    }
    
    @IBAction func addToCart(sender: AnyObject) {
        
        let mainStoryboard = UIStoryboard(name: "CartViewController", bundle: nil)
        let vc = mainStoryboard.instantiateInitialViewController() as! CartViewController
      
        
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    
    @IBAction func buyButtonClicked(sender: AnyObject) {
    }
    
    func queryIsVoted(){
        
        let goodsId = goods!.id
        
        let url = BaseURL.stringByAppendingString("vote/isVoted?userId=\(currentUserId)&&voteGoodsId=\(goodsId!)")
        
        SuzeeRequest.shareInstance.request("vote",url: url) { (flag, value) in
            if let id = value?.objectForKey("id") as? NSNumber{
                self.goods?.voteId = id
                self.goods?.voteStatus = true
                self.voteButton.setImage(UIImage(named:"icon_tabbar_discovery_selected" ), forState: .Normal)
            }
        }
        
        
    }
    
    func queryIsCollectioned(){
        let goodsId = goods!.id
        
        let url = BaseURL.stringByAppendingString("collection/isCollectioned?userId=\(currentUserId)&&goodsId=\(goodsId!)")
        print("url::::\(url)")
        
        SuzeeRequest.shareInstance.request("collection",url: url) { (flag, value) in
          print("val:\(value)")
            if let id = value?.objectForKey("id") as? NSNumber{
                self.goods?.collectionId = id
                self.goods?.collectionStatus = true
                    
                    self.collectButton.setImage(UIImage(named:"item_del_collect_02" ), forState: .Normal)
                }}

    }
    
}
