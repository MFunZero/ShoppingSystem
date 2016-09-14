//
//  AddressTableViewCell.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/9/1.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    @IBOutlet weak var recevierLabel: UILabel!

    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var addressContentLabel: UILabel!
    
    
    
    private var  item:Address!
    
    func setItem(items:Address){
        self.item = items
        
        self.recevierLabel.text = "收货人：\(item.receiver!)"
        
        self.numberLabel.text = item.recevierPhoneNum!
        
        self.addressContentLabel.text = "\(item.province!) \(item.city!) \(item.detail!)"
        
    }
    
    func getItem()->Address{
        return item
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
