//
//  FreePostageTableViewCell.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/9/2.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class FreePostageTableViewCell: UITableViewCell {
    @IBOutlet weak var textLable: UILabel!

    @IBOutlet weak var isFree: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
