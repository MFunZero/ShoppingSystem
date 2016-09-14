//
//  OrderItemsList.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/9/4.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class OrderItemsList: NSObject {

    var list:[OrderItem]?
    
    init(list:[OrderItem]) {
        self.list = list
    }
    
}