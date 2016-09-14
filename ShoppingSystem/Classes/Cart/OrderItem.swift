//
//  OrderItem.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/31.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class OrderItem: NSObject {

    var id:NSNumber?
    var goodsId:NSNumber?
    var count:NSNumber?
    var specificationId:NSNumber?
    var totalPrice:String?
    var orderId:String?
    
    
    init(goodsId:NSNumber, count:NSNumber, specificationId:NSNumber, totalPrice:String){
        super.init()
        
           self.goodsId = goodsId
           self.count = count
           self.specificationId = specificationId
           self.totalPrice = totalPrice
     }
    
    
    override init(){
        super.init()

    }
    
}
