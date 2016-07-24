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
}


class SpecificationTableViewCell: UITableViewCell {
    
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
        self.delegate?.deleteButtonClicked(atIndexPath:row!)
        
    }
    override func drawRect(rect: CGRect) {
        self.cView.layer.borderWidth = 1
        self.cView.layer.borderColor = UIColor(rgb: seperatorRGB).CGColor
        self.cView.layer.cornerRadius = 5
    }
}
