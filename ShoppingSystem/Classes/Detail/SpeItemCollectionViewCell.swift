//
//  SpeItemCollectionViewCell.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/30.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class SpeItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func drawRect(rect: CGRect) {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(rgb: seperatorRGB).CGColor
    }

}
