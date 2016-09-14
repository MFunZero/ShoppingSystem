//
//  CartItem.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/31.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class CartItem: NSObject {
    
    var id:NSNumber?
    var goods:GoodsModelItem?
    var num:NSNumber?
    var spec:Specification?
    var totalPrice:String?
    
    var goodsId:NSNumber?
    var specId:NSNumber?
    var saller:String?
    
    override var description:String{
        return "\(goodsId!) \(specId!) \(num!) \(totalPrice!)"
    }
    
    override init() {
        super.init()
    }
    
    init(num:NSNumber,id:NSNumber,specId:NSNumber,goodsId:NSNumber,totalPrice:String) {
        
        super.init()

        self.num = num
        self.specId = specId
        self.goodsId = goodsId
        self.totalPrice = totalPrice
        self.id = id
        
    }
    
}
