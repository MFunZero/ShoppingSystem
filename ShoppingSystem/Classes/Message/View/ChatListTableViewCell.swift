//
//  ChatListTableViewCell.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/9/13.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {
    
    private var conversation:EMConversation!
    
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    func setConversation(conversation:EMConversation){
        self.conversation = conversation
        let lastMessage = conversation.latestMessage
        var latestMessageTitle = ""
        
        if lastMessage != nil {
            
            let messageBody = lastMessage.body
            
            switch messageBody.type {
            case EMMessageBodyType.init(2):
                latestMessageTitle = NSLocalizedString("message.image1", comment: "[image]")
            case EMMessageBodyType.init(1):
                let didReceiveText = EaseConvertToCommonEmoticonsHelper.convertToSystemEmoticons((messageBody as! EMTextMessageBody).text)
                latestMessageTitle = didReceiveText
                
                if let extra = lastMessage.ext{
                    latestMessageTitle = "动画表情"
                }
                
            case EMMessageBodyType.init(3):
                latestMessageTitle = NSLocalizedString("message.voice1",comment: "[voice]")
            case EMMessageBodyType.init(4):
                latestMessageTitle = NSLocalizedString("message.location1",comment: "[location]")
            case EMMessageBodyType.init(5):
                latestMessageTitle = NSLocalizedString("message.video1",comment: "[video]")
            case EMMessageBodyType.init(6):
                latestMessageTitle = NSLocalizedString("message.file1",comment: "[file]")
            default:
                break
            }
            
            
            
        }
        self.nickNameLabel.text = conversation.conversationId
    
        self.avatarImageView.image = UIImage(named: "chatListCellHead")
        
        self.messageLabel.text = latestMessageTitle

        let count = conversation.unreadMessagesCount
        if count > 0 {
            addBadgeCount(count)
        }else if count == 0 {
            removeBadgeCount()
        }
        
        
    }
    
    func addBadgeCount(count:Int32){
        badgeView.clipsToBounds = true
        badgeView.layer.cornerRadius = badgeView.frame.width/2
        badgeView.backgroundColor = UIColor.redColor()
        badgeLabel.text = format(Int(count))
        
    }
    
    func removeBadgeCount(){
        
        badgeView.backgroundColor = UIColor.clearColor()
        badgeLabel.text = ""
        
    }
    
    
    func format(count:Int)->String{
        if count > 9 {
            return "9+"
        }else{
            return "\(count)"
        }
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
