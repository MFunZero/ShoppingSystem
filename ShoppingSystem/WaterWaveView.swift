//
//  WaterWaveView.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/14.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class WaterWaveView: UIView {

    var currentWaterColor:UIColor!
    var currentLinePointY:CGFloat = 0
    var a:CGFloat = 1.5
    var b:CGFloat = 0
    
    var addFlag:Bool = false
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
        
        currentWaterColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        
        currentLinePointY = 0
        
        
        

        self.backgroundColor = UIColor.clearColor()

        
        NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: #selector(animateWave), userInfo: nil, repeats: true)
    }
    
    func animateWave()
    {
        if (addFlag) {
            a += 0.01
        }else{
            a -= 0.01
        }
        
        
        if (a<=1) {
            addFlag = true
        }
        
        if (a>=1.5) {
            addFlag = false
        }
        
        
        b+=0.1
        
        self.setNeedsDisplay()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let context = UIGraphicsGetCurrentContext()
        
        let path = CGPathCreateMutable()
        
        CGContextSetLineWidth(context, 1)
        CGContextSetFillColorWithColor(context, currentWaterColor.CGColor)
        
        
        
        var y = currentLinePointY
        CGPathMoveToPoint(path, nil, 0, y)
        
        let end = Int(screenW/1)
        for i in 0..<end {
         
            let varia1 = Double(i+20)*M_PI/180+4*Double(b)/M_PI

           y = a * sin(CGFloat(varia1))*4 + currentLinePointY
            CGPathAddLineToPoint(path, nil, CGFloat(i), y)
        }
        CGPathAddLineToPoint(path, nil, CGFloat(end), rect.height)
        CGPathAddLineToPoint(path, nil, 0, rect.height)
        CGPathAddLineToPoint(path, nil, 0, currentLinePointY)

        
        CGContextAddPath(context, path)
        CGContextFillPath(context)
        CGContextDrawPath(context, .Stroke)
        
        
        
    
    }
 

}
