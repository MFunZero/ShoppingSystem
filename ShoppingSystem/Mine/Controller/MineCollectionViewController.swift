//
//  MineCollectionViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/17.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

protocol MineControllePushDelegate {
    func settingButtonClicked()
}

private let reuseIdentifier = "Cell"

private let myOrderIdentifier = "MyOrders"

class MineCollectionViewController: UICollectionViewController ,StrechDelete,SettingProtocol{

    var delegate:MineControllePushDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layoutNew = SuzeeStrechCollectionViewLayout()
        layoutNew.delegate = self
        self.collectionView!.collectionViewLayout = layoutNew
        
        self.collectionView?.backgroundColor = UIColor(rgb: 0xCBCBCB)
        
        self.collectionView!.registerNib(UINib(nibName: "CustomCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView!.registerNib(UINib(nibName: "MyOrdersCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: myOrderIdentifier)
        
        
        self.collectionView!.registerNib(UINib(nibName: "HeaderCollectionReusableView",bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 8
    }
    
    func flowLayoutHeightForIndexPath(layout: SuzeeStrechCollectionViewLayout, atIndexPath: NSIndexPath) -> CGFloat {
        if atIndexPath.row == 1{
        return 55
        }else{
            return 50
        }
    }
    
    func flowLayoutAfterIsSeparatedForIndexPath(layout: SuzeeStrechCollectionViewLayout, atIndexPath: NSIndexPath) -> Bool {
        let row = atIndexPath.row
        switch row {
        case 0:
           return  false
        case 1:
            return true
        case 2:
            return  false
        case 3:
            return  false
        case 4:
            return  false
        case 5:
            return  false
        case 6:
            return  false
        default:
           return  true
        }
    }

    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reusableView:HeaderCollectionReusableView!
        
        
        reusableView = collectionView.dequeueReusableSupplementaryViewOfKind( kind, withReuseIdentifier: "headerView", forIndexPath: indexPath)
        as? HeaderCollectionReusableView
            
        reusableView.backgroundColor = UIColor.cyanColor()
        reusableView.delegate = self
        
        return reusableView
    }

    
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let row = indexPath.row
        
        switch row {
        case 1:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(myOrderIdentifier, forIndexPath: indexPath) as! MyOrdersCollectionViewCell
 
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
            
            cell.titleLabel.text = "我的优惠券"
            cell.tagImageView.image = UIImage(named: "icon_default_coupon")
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
            
            cell.titleLabel.text = "我的购物车"
            cell.tagImageView.image = UIImage(named: "share_platform_evernote")
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
            
            cell.titleLabel.text = "历史记录"

            cell.tagImageView.image = UIImage(named: "tmall_trade_courier_depraise_selected")
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
            
            cell.titleLabel.text = "我的评论"
            cell.tagImageView.image = UIImage(named: "share_platform_ynote")
            return cell
        case 6:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
            
            cell.titleLabel.text = "我的消息"
            cell.tagImageView.image = UIImage(named: "share_platform_email")
            return cell
        case 7:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
            
            cell.titleLabel.text = "我的地址库"
            cell.tagImageView.image = UIImage(named: "icon_tabbar_nearby_selected")
            return cell
        default:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
            
            
            cell.tagImageView.image = UIImage(named: "pluginboard_icon_invite")
         
            cell.titleLabel.text = "我的订单"
            return cell
        }
    }

   
}
extension MineCollectionViewController{
    func careButtonClicked() {
        
    }
    func collectionButtonClicked() {
        
    }
    
    func upvoteButtonClicked() {
        
    }
    
    func settingButtonClicked() {
        self.delegate?.settingButtonClicked()
    }
}
