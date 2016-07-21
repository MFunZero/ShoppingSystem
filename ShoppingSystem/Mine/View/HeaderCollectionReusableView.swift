//
//  HeaderCollectionReusableView.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/17.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit


protocol SettingProtocol {
    func settingButtonClicked()
    func careButtonClicked()
    func collectionButtonClicked()
    func upvoteButtonClicked()
}

class HeaderCollectionReusableView: UICollectionReusableView {

    var delegate:SettingProtocol?
    
    @IBOutlet weak var imgView: UIImageView!
   
    @IBOutlet weak var avaterView: UIImageView!
    

    @IBOutlet weak var blurView:UIVisualEffectView?
    

    @IBOutlet weak var descriptiongLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func drawRect(rect: CGRect) {
        
    }
    
    @IBAction func collectionButton(sender: AnyObject) {
        self.delegate?.collectionButtonClicked()
    }
    @IBAction func upvoteButton(sender: AnyObject) {
        self.delegate?.upvoteButtonClicked()
    }
    @IBAction func careButtonClicked(sender: AnyObject) {
        self.delegate?.careButtonClicked()
    }
    @IBAction func settingButtonClicked(sender: AnyObject) {
        
        self.delegate?.settingButtonClicked()
    }
}
