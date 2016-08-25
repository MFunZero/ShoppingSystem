//
//  CustomTableViewCell.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/9.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit
import Alamofire



enum TableCellType{
    case Service,SalesAddress
}


class CustomTableViewCell: UITableViewCell {

    var type:TableCellType?
    var goodsId:Int?
    
    
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func drawRect(rect: CGRect) {
        
        if TableCellType.SalesAddress == type{
            
        }
    }
    
    func getAddress()
    {
        let url = BaseURL.stringByAppendingString("address/queryById?").stringByAppendingString("id=\(goodsId)")
        Alamofire.request(.GET, url)
            .responseJSON() { (data)in
                
                let result = data.result
                
                switch (result) {
                    
                case .Failure:
                    
                    print("Error to getArress:\(result.error)")
                    
                    toastErrorMessage(self, title: "获取数据出错，请稍后重试", hideAfterDelay: 2.0)
                    
                case .Success(let value):
                    print("Success to getArress:\(value)")
                
                        let address = Address.mj_objectWithKeyValues(value)
                       
                            self.rightLabel.text = "\(address.province) \(address.city)"
                    
                    }
                }
    }
    
}
