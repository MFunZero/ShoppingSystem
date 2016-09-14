//
//  GoodsModelItem.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/12.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class GoodsModelItem: NSObject {

    var id:NSNumber?
    var title:String?
    var titleDescription:String?
    
    var mainPicture:String?
    var detailDescription:String?
    var isFreePostage:NSNumber?
    
    var timeOfDeliveryId:NSNumber?
    var post_saleService:String?
    var specifications:String?
    var price:String?
    var stockCount:NSNumber?
    var deliveryAddressId:NSNumber?
    var userId:String?
    var createdAt:NSDate?
    var categoryId:NSNumber?
    
    
    var collectionStatus:Bool?
    var voteStatus:Bool?
    var voteId:NSNumber?
    var collectionId:NSNumber?
}
