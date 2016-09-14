//
//  UploadContentView.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/20.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit
import SVProgressHUD


private let cellIdentifier = "CollectionViewCell"

protocol CollectionViewCellDelegate {
    func addCellButtonClicked()
    
    func subImageButtonCliked(imgs:[UIImage])
    
    
    func textViewDidEdit(text:String)
}

class UploadContentView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var delegate:CollectionViewCellDelegate?
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var imgs:[UIImage] = [UIImage]()
    
    @IBOutlet weak var collectionView: UICollectionView!

   @IBOutlet weak var contentView:UIView!
    
    var cellCount = 1

    
    func setframe(rect:CGRect) {
        var newFrame = frame
        super.frame = frame
        newFrame.origin.x = 0
        newFrame.origin.y = 0
        self.contentView.frame = newFrame
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        
        collectionView.registerNib(UINib(nibName: "ImgCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didChange(_:)), name: UITextViewTextDidChangeNotification, object: nil)
    }
    
    func didChange(notification:NSNotification){
        self.delegate?.textViewDidEdit(self.descriptionTextView.text)
    }

    override func awakeFromNib() {
        NSBundle.mainBundle().loadNibNamed("UploadContentView", owner: self, options: nil)
        
        self.addSubview(contentView)
    }
    
   
}
extension UploadContentView {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if imgs.count < 6 {
            return imgs.count
        }else{
            return 5
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let row = indexPath.row
    
        if imgs.count < 6{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as? ImgCollectionViewCell
            cell?.backgroundColor = UIColor(rgb: seperatorRGB)
            cell?.imgView.image = imgs[row]
//            if row > 0 {
//            addCancelButton(cell!,row: row)
//            }
            return cell!
        }else if imgs.count == 6{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as? ImgCollectionViewCell
            cell?.backgroundColor = UIColor(rgb: seperatorRGB)
            cell?.imgView.image = imgs[row+1]
//            addCancelButton(cell!,row: row)
            return cell!
        }else{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as? ImgCollectionViewCell
            cell?.backgroundColor = UIColor(rgb: seperatorRGB)
            cell?.imgView.image = imgs[row-1]
            
//            addCancelButton(cell!,row: row)
            return cell!
        }
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 && imgs.count < 6{

            self.delegate?.addCellButtonClicked()
//            for i in 0..<imgs.count {
//                let cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: i, inSection: 0))
//                for subview in (cell?.contentView.subviews)!{
//                   if subview.superclass == UIButton.self {
//                    subview.removeFromSuperview()
//                    }
//                }
//            }
            
//            let cell = collectionView.cellForItemAtIndexPath(indexPath)
//            for subview in (cell?.contentView.subviews)!{
//                
//                if subview.superclass == UIButton.self {
//                subview.removeFromSuperview()
//            }
//            }
        }
    }
    
    
    func addCancelButton(cell:UICollectionViewCell,row:Int)
    {
       
     
        if row == 0 {
            return
        }
        
        let rect = cell.frame
        
        let button = UIButton(frame: CGRectMake(rect.width-25,0,25,25))
        
        button.setImage(UIImage(named: "btn_cancel"), forState: .Normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.borderWidth = 1
        
        button.tag = row
        button.addTarget(self, action: #selector(deleteCell(_:)), forControlEvents: .TouchUpInside)
        
        cell.contentView.addSubview(button)
        
        
    }
    
    func deleteCell(sender:AnyObject)
    {
        var indexPath = NSIndexPath()
        if imgs.count == 6 {
             indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        imgs.removeAtIndex(sender.tag)
        }else{
            imgs.removeAtIndex(sender.tag-1)
             indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        }
        
        self.collectionView.deleteItemsAtIndexPaths([indexPath])

        print("tag:\(sender.tag)")
//        let button = self.collectionView.viewWithTag(sender.tag) as! UIButton
//        button.removeFromSuperview()
//        self.collectionView.willRemoveSubview(button)
        self.delegate?.subImageButtonCliked(imgs)
    }
    
}
