//
//  SpecificationsList.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/18.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class SpecificationsList: NSObject {

    var list:[Specification]?
    
    init(list:[Specification]){
        super.init()
        self.list = list
    }
}
