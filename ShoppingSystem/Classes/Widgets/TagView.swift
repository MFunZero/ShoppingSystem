//
//  TagView.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/13.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

private let labelHeight:CGFloat = 35
private let speratorDistance:CGFloat  = 10
private let topMargin:CGFloat  = 10
private let contentExpand:CGFloat = 10




class TagView:UIView{
    
    var delegate:TagViewDelegate?

    var tags:NSArray?
    private var labels:[UILabel] = [UILabel]()
    
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)
        
        var originX:CGFloat = 0
        var originY:CGFloat = 0
        let width:CGFloat = 100
        var lineCount = 0
        
        print("count:\(tags!.count)")
        
        for i in 0 ..< tags!.count {
            let descriptionLabel = UILabel(frame: CGRectMake(originX,originY,width,labelHeight))
            
            descriptionLabel.numberOfLines = 1
            descriptionLabel.font = UIFont.systemFontOfSize(14)
            //根据detailText文字长度调节topView高度
            let constraint = CGSize(width: self.frame.size.width/2-10,height: labelHeight)
            let content = tags![i] as! NSString
            
            let size = content.boundingRectWithSize(constraint, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: NSDictionary(object:UIFont.systemFontOfSize(14), forKey: NSFontAttributeName) as? [String : AnyObject] ,context: nil)
            
      
            let endX = originX+size.width+contentExpand
            var targetX = originX
            if size.width  > self.frame.width && i > 0 {
                lineCount += 1
                originX = size.width+speratorDistance+contentExpand
                originY = (labelHeight+topMargin) * CGFloat(lineCount)
                targetX = 0
                
            }else if endX > self.frame.width{
                lineCount += 1
                originX = size.width+speratorDistance+contentExpand
                originY = (labelHeight+topMargin) * CGFloat(lineCount)
                targetX = 0
            }else{
                originX = endX+speratorDistance
                
            }
            descriptionLabel.frame = CGRectMake(targetX, originY,size.width+contentExpand, labelHeight);//保持原来Label的位置和宽度，只是改变高度。
            descriptionLabel.text = content as String
            descriptionLabel.textColor = UIColor.lightGrayColor()
            descriptionLabel.textAlignment = .Center
            descriptionLabel.lineBreakMode = .ByTruncatingTail //末尾省略号

            
            descriptionLabel.layer.borderColor = UIColor(rgb: 0xCBCBCB).CGColor
            descriptionLabel.layer.borderWidth = 1
            descriptionLabel.layer.cornerRadius = 5
            
            
            self.addSubview(descriptionLabel)
            
        }
        
        print("lineC:\(originY)")
        self.returnHeight(originY+labelHeight+topMargin)
        
        
    }
    
    func updateLayout()
    {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        self.drawRect(self.bounds)
    }
    
    func returnHeight(height: CGFloat) {
        
        self.delegate?.getHeight(height)
    }

    
  
}

