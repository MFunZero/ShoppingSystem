//
//  Orders.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/31.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class Orders: NSObject {

    var id:String?
    var sumMoney:String?
    var userCouponsId:NSNumber?
    var orderStatus:NSNumber?
    var purchaseId:String?
    var isExpress:NSNumber?
    var expressId:String?
    var expressName:String?
    var createAt:String?
    var payAt:String?
    var addressId:NSNumber?
    
    
    var address:Address?
    
    
    init(sumMoney:String,orderStatus:NSNumber, purchaseId:String, createAt:String){
        
        super.init()

        self.sumMoney = sumMoney
        self.orderStatus = orderStatus
        self.purchaseId = purchaseId
        self.createAt = createAt
    }
    
    override init () {
        super.init()
        
       
    }
    
 
}


