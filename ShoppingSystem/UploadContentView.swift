//
//  UploadContentView.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/20.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class UploadContentView: UIView {

   @IBOutlet weak var contentView:UIView!
    
 
    
    func setframe(rect:CGRect) {
        var newFrame = frame
        super.frame = frame
        newFrame.origin.x = 0
        newFrame.origin.y = 0
        self.contentView.frame = newFrame
    }
    
//    override func drawRect(rect: CGRect) {
//        // Drawing code
//    }
 

    override func awakeFromNib() {
        NSBundle.mainBundle().loadNibNamed("UploadContentView", owner: self, options: nil)
        
        self.addSubview(contentView)
    }
    
   
}
