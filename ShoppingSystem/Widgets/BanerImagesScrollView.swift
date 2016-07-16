//
//  BanerImagesScrollView.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/11.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit
import SDWebImage


class BanerImagesScrollView: UIScrollView,UIScrollViewDelegate {

    
    var imgViews:[UIImageView] = [UIImageView(),UIImageView(),UIImageView()]
    var imgsURL:[String]?

    var height:CGFloat = 120
    var originY:CGFloat = 0
    
    var timer:NSTimer?
    var currentImageIndex = 0
    var currentImageView:UIImageView?
    var leftImageView:UIImageView?
    var rightImageView:UIImageView?
    
    private var pageControll:UIPageControl?
    
    
    
    
    override func drawRect(rect: CGRect) {
        
        let width = screenW
        height = rect.height
        
        leftImageView = UIImageView(frame:  CGRect(x:0, y:0, width: width, height: height))
        currentImageView = UIImageView(frame:  CGRect(x:screenW, y:0, width: width, height: height))
        rightImageView = UIImageView(frame:  CGRect(x:screenW*2, y:0, width: width, height: height))

        self.addSubview(leftImageView!)
        self.addSubview(currentImageView!)
        self.addSubview(rightImageView!)
        
        leftImageView!.sd_setImageWithURL(NSURL(string: imgsURL![imgsURL!.count-1]))
        currentImageView!.sd_setImageWithURL(NSURL(string: imgsURL![0]))
        rightImageView!.sd_setImageWithURL(NSURL(string: imgsURL![1]))


        pageControll = UIPageControl(frame: CGRect(x: width/2-15, y: self.frame.origin.y+height - 30, width: 30, height: 20))
        self.superview!.addSubview(pageControll!)
        
        pageControll!.pageIndicatorTintColor = UIColor.whiteColor()
        pageControll!.currentPageIndicatorTintColor = UIColor.redColor()
        pageControll!.numberOfPages = imgsURL!.count;

        pageControll!.currentPage = 0
        
        self.pagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.contentSize = CGSizeMake(CGFloat(3)*width, 0.0)
      
        self.setContentOffset(CGPoint(x: screenW, y: 0), animated: false)
        
        
        self.delegate = self
        
        
        addTimer()
        
    }
    
    func reloadImage()
    {
        var leftImageIndex = currentImageIndex-1
        var rightImageIndex = currentImageIndex+1
        
        let offset = self.contentOffset
        
        if offset.x == 2*screenW {
            currentImageIndex = (currentImageIndex+1)%imgsURL!.count
            if currentImageIndex == 0 {
                leftImageIndex = imgsURL!.count-1
            }
            else {
                leftImageIndex = (currentImageIndex-1)%imgsURL!.count
            }
            self.pageControll?.currentPage = (self.pageControll!.currentPage+1)%imgsURL!.count
            
        }else if offset.x == 0 {
            
            if currentImageIndex == 0 {
                currentImageIndex = imgsURL!.count-1
                leftImageIndex = currentImageIndex-1

            }else{
                currentImageIndex = (currentImageIndex-1)%imgsURL!.count
                if currentImageIndex == 0 {
                    leftImageIndex = imgsURL!.count-1
                }else{
                    leftImageIndex = currentImageIndex-1
                }
                
            
            }
            self.pageControll?.currentPage = (currentImageIndex)%imgsURL!.count
        }else{
            currentImageIndex = (currentImageIndex+1)%imgsURL!.count
            
            if currentImageIndex == 0 {
                leftImageIndex = imgsURL!.count-1
            }
            else {
                leftImageIndex = (currentImageIndex-1)%imgsURL!.count
            }
            self.pageControll?.currentPage = (currentImageIndex)%imgsURL!.count
            
            rightImageIndex = (currentImageIndex+1)%imgsURL!.count
            
            
            leftImageView!.sd_setImageWithURL(NSURL(string: imgsURL![leftImageIndex]))
            rightImageView!.sd_setImageWithURL(NSURL(string: imgsURL![rightImageIndex]))
            currentImageView!.sd_setImageWithURL(NSURL(string: imgsURL![currentImageIndex]))
            
            self.setContentOffset(CGPointMake(screenW, 0), animated: false)

            return

        }
        
        rightImageIndex = (currentImageIndex+1)%imgsURL!.count

    
        leftImageView!.sd_setImageWithURL(NSURL(string: imgsURL![leftImageIndex]))
        rightImageView!.sd_setImageWithURL(NSURL(string: imgsURL![rightImageIndex]))
        currentImageView!.sd_setImageWithURL(NSURL(string: imgsURL![currentImageIndex]))
        
        self.setContentOffset(CGPointMake(screenW, 0), animated: false)

    }
 
  
    
    func addTimer()
    {
        self.setContentOffset(CGPointMake(screenW*2, 0), animated: true)

        self.timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(scrollViewDidEndDecelerating(_:)), userInfo: nil, repeats: true)
    }
    
    func removeTimer()
    {
        timer!.invalidate()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.reloadImage()

    
    }
    
    
 

}
