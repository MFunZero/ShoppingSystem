//
//  DealWithData.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/24.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

enum RequestType{
    case Add,Delete,Update,Select
}
struct BaseUrlRequset {
    let goods:String = BaseURL.stringByAppendingString("goods/")
    let vote:String = BaseURL.stringByAppendingString("vote/")
    let collection:String = BaseURL.stringByAppendingString("collection/")
    
}






public class DealWithData: NSObject {

    static func request(type:RequestType,Url:String,callback:(Bool,AnyObject?)->()){
       
    }
    
    
    
    
}
