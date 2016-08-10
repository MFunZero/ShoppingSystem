//
//  Define.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/11.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import Foundation
import UIKit

let screenW = UIScreen.mainScreen().bounds.width
let screenH = UIScreen.mainScreen().bounds.height

let CHINESE = "zh-Hans"
let ENGILISH = "en"

let BaseURL = "http://allensu.ngrok.cc/ssm/"

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



