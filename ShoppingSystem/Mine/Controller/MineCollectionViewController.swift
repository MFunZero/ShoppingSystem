//
//  MineCollectionViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/17.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

private let myOrderIdentifier = "MyOrders"

class MineCollectionViewController: UICollectionViewController ,StrechDelete{

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layoutNew = SuzeeStrechCollectionViewLayout()
        layoutNew.delegate = self
        self.collectionView!.collectionViewLayout = layoutNew
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        self.collectionView!.registerNib(UINib(nibName: "CustomCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView!.registerNib(UINib(nibName: "MyOrdersCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: myOrderIdentifier)
        
        
        self.collectionView!.registerNib(UINib(nibName: "SuzeeHeaderCollectionViewCell",bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
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
        return 3
    }
    
    func flowLayoutHeightForIndexPath(layout: SuzeeStrechCollectionViewLayout, atIndexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func flowLayoutAfterIsSeparatedForIndexPath(layout: SuzeeStrechCollectionViewLayout, atIndexPath: NSIndexPath) -> Bool {
        let row = atIndexPath.row
        switch row {
        case 0:
           return  false
            
        case 1:
            return true
        default:
           return  true
        }
    }

    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reusableView:UICollectionReusableView!
        
        
        reusableView = collectionView.dequeueReusableSupplementaryViewOfKind( kind, withReuseIdentifier: "headerView", forIndexPath: indexPath)
        reusableView.backgroundColor = UIColor.cyanColor()
        
        
        
       
        
        return reusableView
    }

    
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let row = indexPath.row
        
        switch row {
        case 1:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(myOrderIdentifier, forIndexPath: indexPath) as! MyOrdersCollectionViewCell
            
            
            cell.backgroundColor = UIColor.lightGrayColor()
            
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
            
            
            cell.backgroundColor = UIColor.brownColor()
            
            
            return cell
        }
    }

   
}
