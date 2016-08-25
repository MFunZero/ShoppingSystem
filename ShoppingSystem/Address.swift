//
//  Address.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/19.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class Address: NSObject {
    
    var id:NSNumber?
    
    var province:String?
    
    
    var  city:String?
    
    var  county:String?
    
    var  detail:String?
    
    var  recevier:String?
    
    var  recevierPhoneNum:String?
    
    var  postCode:String?
    
    var  userId:String?
    
    override  var description: String{
        return "\(province!) \(city!)"
    }
}
