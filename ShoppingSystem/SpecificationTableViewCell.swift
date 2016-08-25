//
//  SpecificationTableViewCell.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/22.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit


protocol SpecificationTableViewDelegate {
    func deleteButtonClicked(atIndexPath indexPath:NSIndexPath)
    
    func getContent(atIndexPath indexPath:NSIndexPath,specification:String,stockCount:Int,price:Double)
    
    
    
}


class SpecificationTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var stockCount: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    
    @IBOutlet weak var sepecificationLabel: UITextField!
    var delegate:SpecificationTableViewDelegate?
    
    @IBOutlet weak var cView: UIView!

    @IBOutlet weak var specifiacationView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
    
  
    
    @IBAction func deleteButtonClicked(sender: AnyObject) {
        let tableView = self.superview?.superview as! UITableView
        let row = tableView.indexPathForCell(self)
        
//        stockCount.resignFirstResponder()
//        priceLabel.resignFirstResponder()
//        sepecificationLabel.resignFirstResponder()
     
        if priceLabel.isFirstResponder(){
            priceLabel.resignFirstResponder()
        }else if stockCount.isFirstResponder() {
            stockCount.resignFirstResponder()
        }else{
            sepecificationLabel.resignFirstResponder()
        }
        self.endEditing(true)
        
        
        self.contentView.endEditing(true)
        
        dispatch_async(dispatch_get_main_queue(), {
                    self.delegate?.deleteButtonClicked(atIndexPath:row!)

            })
        
//        self.delegate?.deleteButtonClicked(atIndexPath:row!)
        
    }
    override func drawRect(rect: CGRect) {
        self.cView.layer.borderWidth = 1
        self.cView.layer.borderColor = UIColor(rgb: seperatorRGB).CGColor
        self.cView.layer.cornerRadius = 5
        
        stockCount.keyboardType = .NumberPad
        priceLabel.keyboardType = .NumberPad
        
        stockCount.delegate = self
        priceLabel.delegate = self
        sepecificationLabel.delegate = self
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textFieldDidChange(_:)), name:UITextFieldTextDidChangeNotification, object: nil)
    }
    
    
    func textFieldDidChange(notification:NSNotification){
        if sepecificationLabel.text == ""{
//            sepecificationLabel.becomeFirstResponder()
//            shakeAnimationForView(sepecificationLabel)
            return
        }
        if priceLabel.text == "" {
//            priceLabel.becomeFirstResponder()
            
//            shakeAnimationForView(priceLabel)
            return
        }
        
        
        if stockCount.text == ""{
//            stockCount.becomeFirstResponder()
//            shakeAnimationForView(stockCount)
            return
        }
        
        let tableView = self.superview?.superview as! UITableView
        let row = tableView.indexPathForCell(self)
        
        
        
        let stock = Int(stockCount.text!)
        let price = Double(priceLabel.text!)
        
        self.delegate?.getContent(atIndexPath: row!, specification: sepecificationLabel.text!, stockCount: stock!, price: price!)
        

    }
 
    
    func textFieldDidEndEditing(textField: UITextField) {
//        if sepecificationLabel.text == ""{
//            sepecificationLabel.becomeFirstResponder()
//            shakeAnimationForView(sepecificationLabel)
//            return
//        }
//        if priceLabel.text == "" {
//            priceLabel.becomeFirstResponder()
//            
//            shakeAnimationForView(priceLabel)
//            return
//        }
//        
//        
//        if stockCount.text == ""{
//            stockCount.becomeFirstResponder()
//            shakeAnimationForView(stockCount)
//            return
//        }



      
    }
    
       
}
