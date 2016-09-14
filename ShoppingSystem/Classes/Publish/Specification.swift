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
    var stockCount:NSNumber?
    var price:String?
    init(descriptionTitle:String,stockCount:NSNumber,price:String) {
        super.init()
        self.descriptionTitle = descriptionTitle
        self.stockCount = stockCount
        self.price = price
    }
    override init() {
        
    }
    
    override var description: String {
        return "\(descriptionTitle) \(price)"
    }
    
}
