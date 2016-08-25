//
//  Specification.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/17.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class Specification: NSObject {

    var id:NSNumber?
    var descriptionTitle: String?
    var stockCount:Int?
    var price:Double?
    init(descriptionTitle:String,stockCount:Int,price:Double) {
        super.init()
        self.descriptionTitle = descriptionTitle
        self.stockCount = stockCount
        self.price = price
    }
    
}
