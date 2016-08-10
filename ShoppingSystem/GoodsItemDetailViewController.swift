//
//  GoodsItemDetailViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/6.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit




class GoodsItemDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentcountLabel: UILabel!
    @IBOutlet weak var descritionLabel: UILabel!
    @IBOutlet weak var bannerView: BanerImagesScrollView!
    
    @IBOutlet weak var titleTableview: UITableView!
    
    @IBOutlet weak var commentTableView: UITableView!
    
    var comment:NSMutableDictionary = NSMutableDictionary()
    var cellHeight:[CGFloat]=[44]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        configView()
        
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
                cell.titleLabel.text = "产地直销皇家贡米，水电费卢卡斯的浪费拉伸的"
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
                cell.leftLabel.text = "七天无理由退换货"
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
