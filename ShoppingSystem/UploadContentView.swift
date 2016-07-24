//
//  UploadContentView.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/20.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

private let cellIdentifier = "CollectionViewCell"

protocol CollectionViewCellDelegate {
    func addCellButtonClicked()
    
    func subImageButtonCliked(imgs:[UIImage])
}

class UploadContentView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var delegate:CollectionViewCellDelegate?
    
    
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
    }
 

    override func awakeFromNib() {
        NSBundle.mainBundle().loadNibNamed("UploadContentView", owner: self, options: nil)
        
        self.addSubview(contentView)
    }
    
   
}
extension UploadContentView {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imgs.count < 5 {
        return (imgs.count) + 1
        }else {
            return imgs.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let row = indexPath.row
        if row == 0 && imgs.count < 5{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as? ImgCollectionViewCell
        cell?.backgroundColor = UIColor(rgb: seperatorRGB)
        cell?.imgView.image = UIImage(named:"Artboard 1")
        
        return cell!
        }else if imgs.count == 5{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as? ImgCollectionViewCell
            cell?.backgroundColor = UIColor(rgb: seperatorRGB)
            cell?.imgView.image = imgs[row]
            addCancelButton(cell!,row: row)
            return cell!
        }else{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as? ImgCollectionViewCell
            cell?.backgroundColor = UIColor(rgb: seperatorRGB)
            cell?.imgView.image = imgs[row-1]
            addCancelButton(cell!,row: row)
            return cell!
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 && imgs.count < 5{
            self.delegate?.addCellButtonClicked()
        }
    }
    
    
    func addCancelButton(cell:UICollectionViewCell,row:Int)
    {
       
        
        
        let rect = cell.frame
        
        let button = UIButton(frame: CGRectMake(rect.width-25,0,25,25))
        
        button.setImage(UIImage(named: "btn_cancel"), forState: .Normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.borderWidth = 1
        
        button.tag = row
        button.addTarget(self, action: #selector(deleteCell(_:)), forControlEvents: .TouchUpInside)
        
        cell.addSubview(button)
        
        
    }
    
    func deleteCell(sender:AnyObject)
    {
        var indexPath = NSIndexPath()
        if imgs.count == 5 {
             indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        imgs.removeAtIndex(sender.tag)
        }else{
            imgs.removeAtIndex(sender.tag-1)
             indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        }
        
        self.collectionView.deleteItemsAtIndexPaths([indexPath])

        self.delegate?.subImageButtonCliked(imgs)
    }
    
}
