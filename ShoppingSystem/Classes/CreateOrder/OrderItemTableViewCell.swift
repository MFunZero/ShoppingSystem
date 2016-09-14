//
//  OrderItemTableViewCell.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/9/1.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class OrderItemTableViewCell: UITableViewCell {
    
    private var itemModel:CartItem?
    
    @IBOutlet weak var imgView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var specification: UILabel!
    
    
    @IBOutlet weak var num: UILabel!
    
    func setItemModel(item:CartItem){
        itemModel = item
        
        titleLabel.text = item.goods?.title
        specification.text = item.spec?.descriptionTitle
        
        let strs = item.goods?.mainPicture?.componentsSeparatedByString(",")
        let url = BaseImgURL.stringByAppendingString(strs![0])
        let imgUrl = NSURL(string: url)
        imgView?.contentMode = .ScaleAspectFill
        
        imgView?.sd_setImageWithURL(imgUrl)
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
