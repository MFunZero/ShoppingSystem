//
//  IndexCustomCollectionViewCell.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/9.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit
import SDWebImage


class IndexCustomCollectionViewCell: UICollectionViewCell {

    private var goodsModel:GoodsModelItem?
    
    
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var saledLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func setGoodModel(goods:GoodsModelItem)
    {
        self.goodsModel = goods
        
        titleLabel.text = goods.title
        
        priceLabel.text = "\(goods.price)"
        
        
        let strs = goods.mainPicture?.componentsSeparatedByString(",")
        let strURL = BaseImgURL.stringByAppendingString(strs![0])
        print("url:\(strURL)")
        let url = NSURL(string: strURL)
        
        imgView.sd_setImageWithURL(url)
        
//        let data = NSData(contentsOfURL: url!)
//        let img = UIImage(data: data!)
//        
//        imgView.image = img
        
        
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
