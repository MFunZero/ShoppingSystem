//
//  ChatViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/9/13.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class ChatViewController: EaseMessageViewController ,EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource{

    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ChatViewController {
    

   
    
//    override func didSendText(text: String!) {
//        
//        super.didSendText(text)
//        
//        print("didSendText:\(text)")
////        
////        EMClient.sharedClient().pushOptions.displayStyle = EMPushDisplayStyle.init(0)
////        
////        let body:EMTextMessageBody = EMTextMessageBody(text: text)
////       
////        let msg:EMMessage = EMMessage(conversationID: self.conversation.conversationId, from:currentUserName, to: self.conversation.conversationId, body: body, ext: nil)
////        
////        EMClient.sharedClient().chatManager.asyncSendMessage(msg, progress: nil) { (msge, error) in
////            if error != nil{
////                print("error:\(error)")
////            }
////        }
//        
//    }
//    
    
   
    
    
    override func conversationListDidUpdate(aConversationList: [AnyObject]!) {
        super.conversationListDidUpdate(aConversationList)
        
        print("aMessages:\(aConversationList)")
        
    }
    
    
    func messageViewControllerShouldMarkMessagesAsRead(viewController: EaseMessageViewController!) -> Bool {
        return true
    }
  
    
    
    
//    func messageViewController(tableView: UITableView!, cellForMessageModel messageModel: IMessageModel!) -> UITableViewCell! {
//    
//        if messageModel.bodyType == EMMessageBodyType.init(rawValue: 1) {
//            
//            let cell = tableView.dequeueReusableCellWithIdentifier("CustomMessageCell") as? CustomMessageCell
//            cell?.model = messageModel
//            
//            return cell!
//        }
//        
//        return nil
//    }
    
    func messageViewController(viewController: EaseMessageViewController!, heightForMessageModel messageModel: IMessageModel!, withCellWidth cellWidth: CGFloat) -> CGFloat {
        return 100
    }
    
    
}
