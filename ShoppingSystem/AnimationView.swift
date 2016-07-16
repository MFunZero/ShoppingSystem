//
//  AnimationView.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/14.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class AnimationView: UIView {
    var colorSpaceRef:CGColorSpace?
    var beginColor:CGColor?
    var endColor:CGColor?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
   
//                NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func animate()
    {
        
        colorSpaceRef = CGColorSpaceCreateDeviceRGB()
        let temp:CGFloat = CGFloat(arc4random()%10)+1
        beginColor = UIColor.whiteColor().colorWithAlphaComponent(temp/10).CGColor
        let tem:CGFloat = CGFloat(arc4random()%100)+1
        endColor = UIColor.brownColor().colorWithAlphaComponent(tem/100).CGColor
        self.setNeedsDisplay()
        
    }
    override func drawRect(rect: CGRect) {
   
                colorSpaceRef = CGColorSpaceCreateDeviceRGB()
        
                beginColor = CGColorCreate(colorSpaceRef, [0.2,1,0.1,0.6])!
        
                endColor = CGColorCreate(colorSpaceRef, [0,0,1,0,])!
        
        
        let values = UnsafeMutablePointer<UnsafePointer<Void>> ([beginColor,endColor])
        
        let colorArray:CFArrayRef = CFArrayCreate(kCFAllocatorDefault,values, 2, nil)
        
        let gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorArray, [0,1])
        
        
        let startPoint = CGPoint(x:  0, y: 0) // 代替 Make 系列函数
        let endPoint = CGPoint(x: rect.width, y: rect.height)
        let context = UIGraphicsGetCurrentContext()
        CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, .DrawsAfterEndLocation)
    }
    
    
}
