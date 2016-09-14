//
//  DetailTitleTableViewCell.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/8.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class DetailTitleTableViewCell: UITableViewCell {

    
    
    
    
    
    @IBOutlet weak var postageLabel: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func drawRect(rect: CGRect) {

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
