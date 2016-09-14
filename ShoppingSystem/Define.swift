//
//  Define.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/11.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD


let screenW = UIScreen.mainScreen().bounds.width
let screenH = UIScreen.mainScreen().bounds.height

let CHINESE = "zh-Hans"
let ENGILISH = "en"


let currentUserId="111111"
var currentUserName = ""

let BaseURL = "http://allensu.ngrok.cc/ssm/"

let BaseImgURL = "http://allensu.ngrok.cc/ssm/upload/"


 var imgURLS = ["http://i0.hdslb.com/bfs/bangumi/a32e30108af7cd7349201f0b7664392b5b7a3646.jpg","http://i0.hdslb.com/bfs/bangumi/1cc08a1f81b6241b31afa90b8ebd62c5b3c75e09.jpg","http://i0.hdslb.com/bfs/bangumi/9ff5679d5bb95750802ec98796fde26b16740f10.jpg"]

//service dataSource
let service:[String] = ["七天无理由退换货","退换货运费卖家承担","退换货运费买家承担","特殊用品不可退换"]



//MARK -- Color RGB
let seperatorRGB:UInt = 0xCBCBCB
let mainRBG:UInt = 0x3EDBB8


extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}



func shadowAsInverse(rect:CGRect)->CAGradientLayer{
    let layer = CAGradientLayer()
    layer.frame = rect
    let colors = [UIColor.blackColor().colorWithAlphaComponent(0).CGColor,UIColor.blackColor().colorWithAlphaComponent(0.1).CGColor,UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor,UIColor.blackColor().colorWithAlphaComponent(0.3).CGColor,UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor,UIColor.blackColor().colorWithAlphaComponent(0.5).CGColor]
    layer.colors =  colors
    return layer
}


func shakeAnimationForView(view:UIView){
    let viewLayer = view.layer
    let position = viewLayer.position
    let x = CGPointMake(position.x+20, position.y)
    let y = CGPointMake(position.x-20, position.y)
    
    
    let animation = CABasicAnimation(keyPath: "position")
    
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
    
    animation.fromValue = NSValue(CGPoint: x)
    animation.toValue = NSValue(CGPoint: y)
    
    
    animation.autoreverses = true
    
    animation.duration = 0.05
    
    animation.repeatCount = 3
    
    viewLayer.addAnimation(animation, forKey: "shake")
    
}



func addWaterAnimationForView(view:UIView){
    let viewLayer = view.layer
    
    let transition = CATransition()
    
    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    transition.duration = 1.5
    transition.type = "rippleEffect"
    
    viewLayer.addAnimation(transition, forKey: "rippleEffect")
    
}

func toastErrorMessage(view:UIView,title:String,hideAfterDelay time:NSTimeInterval){
    let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
    hud.mode = .Text
    hud.labelText = title
    hud.yOffset = 150.0
    
    hud.show(true)
    
    hud.hide(true, afterDelay: time)
}


func sizeForText(constraintSize:CGSize,str:NSString)->CGSize{
    
    let attr = [NSFontAttributeName:UIFont.systemFontOfSize(20)]
    let rect = str.boundingRectWithSize(constraintSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr, context: nil)
    let size = CGSizeMake(rect.width, rect.height)
    
    return size
}



extension NSDate {
    func format()->String{
        let formatter = "yyyy-mm-dd hh:MM:ss"
        let format = NSDateFormatter()
        format.dateFormat = formatter
        return format.stringFromDate(self)
    }
}
func timeStampToString(timeStamp:NSString)->String {
    
    let str = timeStamp.substringToIndex(timeStamp.length-3)
    
    let string = NSString(string: str)
    
    let timeSta:NSTimeInterval = string.doubleValue
    let dfmatter = NSDateFormatter()
    let formatter = "yyyy-mm-dd hh:MM:ss"

    dfmatter.dateFormat = formatter
    
    let date = NSDate(timeIntervalSince1970: timeSta)
    
    print(dfmatter.stringFromDate(date))
    return dfmatter.stringFromDate(date)
}












/*
 
 
 @IBAction func confirmButtonClicked(sender: AnyObject) {
 
 guard order.addressId != nil else{
 
 toastErrorMessage(self.view, title: "请选择收货地址", hideAfterDelay: 2)
 return
 }
 
 guard self.order.id != "" else {
 toastErrorMessage(self.view, title: "订单已经创建成功，可移步到‘我的订单’进行查看", hideAfterDelay: 2)
 return
 }
 
 
 order.purchaseId = currentUserId
 
 let url = BaseURL.stringByAppendingString("orders/addOne")
 let para = Orders.mj_keyValuesArrayWithObjectArray([order])
 //        para.addObject(<#T##anObject: AnyObject##AnyObject#>)
 SuzeeRequest.shareInstance.request("orders", url: url, param: para[0] as? [String : AnyObject]) { (falg, value) in
 
 switch (falg) {
 
 case false:
 
 print("Error to AddOrders")
 
 case true:
 print("Success to AddOrders:\(value)")
 if let dict = value as? NSDictionary {
 
 print("items:\(dict)")
 
 let orders:Orders = Orders.mj_objectWithKeyValues(dict)
 orders.address = self.order.address
 
 var items:[OrderItem] = [OrderItem]()
 
 for item in self.cartItem {
 
 let oi:OrderItem = OrderItem(goodsId: item.goodsId!, count: item.num!, specificationId: item.specId!, totalPrice: item.totalPrice!, orderId: orders.id!)
 
 
 items.append(oi)
 
 
 }
 
 
 let url1 = BaseURL.stringByAppendingString("orderItem/addList")
 let para1 = OrderItemsList(list: items)
 let param = ["items":para1.mj_JSONString()]
 SuzeeRequest.shareInstance.request("orders", url: url1, param: param) { (falg, value) in
 
 guard value != nil else{
 toastErrorMessage(self.view, title: "生成订单出错，请稍后重试", hideAfterDelay: 2)
 return
 }
 toastErrorMessage(self.view, title: "订单创建成功", hideAfterDelay: 2)
 self.order.id = orders.id
 
 let mainStoryBoard = UIStoryboard(name: "PayOrderController", bundle: nil)
 let vc = mainStoryBoard.instantiateInitialViewController() as? PayOrderController
 vc?.cartItem = self.cartItem
 vc?.orders = orders
 
 self.navigationController?.pushViewController(vc!, animated: true)
 
 }
 }
 }
 
 
 
 
 
 }
 }
 }
 
 

 
 */