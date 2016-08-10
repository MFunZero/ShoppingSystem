//
//  ServiceConfimView.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/24.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

protocol ServiceConfirmViewDelegate {
    func cancelButtonClicked()
    
    func confirmButtonClicked(title:String)
}



class ServiceConfimView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {

    var delegate:ServiceConfirmViewDelegate?
    
    
    var titles:[String] = [String]()
    
    var selectContent:String?
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        selectContent = titles[0]
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
 
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        
        self.delegate?.cancelButtonClicked()
        
    }

    @IBAction func confirmButtonClicked(sender: AnyObject) {
        self.delegate?.confirmButtonClicked(selectContent!)
    }
}



extension ServiceConfimView {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titles.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titles[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectContent = titles[row]
    }
    
    
}
