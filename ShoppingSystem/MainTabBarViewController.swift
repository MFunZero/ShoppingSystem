//
//  MainTabBarViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/12.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController,FoundViewControllerPushDelegate  ,MineControllePushDelegate,IndexViewControllerDelegate,ChatListDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        (self.viewControllers![0].childViewControllers[0] as! IndexCollectionViewController).delegate = self
        (self.viewControllers![1].childViewControllers[0] as! ViewController).delegate = self
        (self.viewControllers![3] as! MineCollectionViewController).delegate = self
        (self.viewControllers![2].childViewControllers[0] as! ConversationListViewController).toChatDetaildelegate = self

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
        
    }
    
 
    func toChatList(conversation: EMConversation) {
        let  vc = ChatViewController(conversationChatter: conversation.conversationId, conversationType: conversation.type)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addButtonClicked() {
        
        
        
        let vc = UIStoryboard(name: "PublishViewController", bundle: nil)
        let target = vc.instantiateViewControllerWithIdentifier("PublishViewController")
        self.navigationController?.pushViewController(target, animated: true)
    }
    
    func toDetailController(item: GoodsModelItem) {
        
        let mainStoryboard = UIStoryboard(name: "GoodsItemDetailViewController", bundle: nil)
        let vc = mainStoryboard.instantiateInitialViewController() as! GoodsItemDetailViewController
        vc.goods = item
    
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func searchBarDidFocus() {
        let vc = SearchResultsCollectionViewController(collectionViewLayout: NoHeaderCollectionViewLayout())
      
        self.navigationController?.pushViewController(vc, animated: true)
        
    

    }
    
   
    func settingButtonClicked() {
        
        let vc = UIStoryboard(name: "SettingTableViewController", bundle: nil)
        let target = vc.instantiateViewControllerWithIdentifier("SettingTableViewController")
        self.navigationController?.pushViewController(target, animated: true)
    }

    override func viewWillDisappear(animated: Bool) {

        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.viewDidDisappear(animated)
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
