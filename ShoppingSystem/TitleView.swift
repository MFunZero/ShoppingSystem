//
//  TitleView.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/20.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit


protocol TitleViewDelegate {
    func categoryButtonClicked()
    func textFieldDidEndEdit(text:String)
}

class TitleView: UIView ,ServiceConfirmViewDelegate{
    @IBOutlet weak var titleTextField: UITextField!

    var delegate:TitleViewDelegate?
    var grayView:UIView = UIView()
    var confirmView:ServiceConfimView = ServiceConfimView()
    
    @IBOutlet weak var contentView:UIView!
    
   
    
    func setframe(rect:CGRect) {
        var newFrame = frame
        super.frame = frame
        newFrame.origin.x = 0
        newFrame.origin.y = 0
        self.contentView.frame = newFrame
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didChange(_:)), name: UITextFieldTextDidChangeNotification, object: nil)
    }

    func didChange(notification:NSNotification){
        self.delegate?.textFieldDidEndEdit(titleTextField.text!)
    }
    
    @IBAction func categoryButtonClik(sender: AnyObject) {
        
        self.delegate?.categoryButtonClicked()
        
        
        
      
    }
    
    @IBOutlet weak var categoryButton: UIButton!
    override func awakeFromNib() {
        NSBundle.mainBundle().loadNibNamed("TitleView", owner: self, options: nil)
        
        self.addSubview(contentView)
    }
    
    
    func confirmButtonClicked(title: String,type:AlertConfirmType,index:Int) {
        self.categoryButton.setTitle(title, forState: .Normal)
    }
    
    func cancelButtonClicked() {
        
    }


}
