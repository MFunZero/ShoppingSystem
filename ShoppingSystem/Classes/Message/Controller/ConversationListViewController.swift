//
//  ConversationListViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/9/14.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

protocol ChatListDelegate {
    func toChatList(conversation:EMConversation)
}

class ConversationListViewController: EaseConversationListViewController {

    var toChatDetaildelegate:ChatListDelegate?

    var conversationsArray:NSMutableArray = NSMutableArray()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        requestData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerNib(UINib(nibName: "ChatListTableViewCell",bundle: nil), forCellReuseIdentifier: "cellIdentifier")

        // Do any additional setup after loading the view.
    }
    
    func requestData(){
        self.conversationsArray.removeAllObjects()
        let conversations:NSArray = EMClient.sharedClient().chatManager.getAllConversations()
        self.conversationsArray.addObjectsFromArray(conversations as [AnyObject])
        self.tableView.reloadData()
        
    }

    override func tableViewDidTriggerHeaderRefresh() {
        super.tableViewDidTriggerHeaderRefresh()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}

extension ConversationListViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationsArray.count
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath) as! ChatListTableViewCell
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor.cyanColor()
        
        let conversation = self.conversationsArray[row] as! EMConversation
        cell.setConversation(conversation)
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        
        let conversation = self.conversationsArray[row] as! EMConversation
        self.toChatDetaildelegate?.toChatList(conversation)

    }
    
    
  
    override func didReceiveMessages(aMessages: [AnyObject]!) {
        requestData()
    }
    
}


