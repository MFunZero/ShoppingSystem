//
//  ServiceConfimView.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/24.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class ServiceConfimView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {

    var titles:[String] = [String]()
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        pickerView.delegate = self
        pickerView.dataSource = self
    }
 
    @IBAction func cancelButtonClicked(sender: AnyObject) {
    }

    @IBAction func confirmButtonClicked(sender: AnyObject) {
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
        
    }
    
    
}
