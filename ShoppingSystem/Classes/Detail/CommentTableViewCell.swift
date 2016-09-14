//
//  CommentTableViewCell.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/9.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

protocol CommentDelegate {
    func cellHeight(indexPaht:NSIndexPath)->CGFloat
}

class CommentTableViewCell: UITableViewCell ,CommentDelegate{

    var delegate:CommentDelegate?
    
    var comment:NSMutableDictionary?{
        willSet{
            self.layoutIfNeeded()
            self.delegate = self

        }
    }
    
    func cellHeight(indexPaht: NSIndexPath)->CGFloat {
        let cellheight:CGFloat = 100
        return cellheight
    }
    
    override func drawRect(rect: CGRect) {
        
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
