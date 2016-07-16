//
//  MainTabBarViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/12.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController,FoundViewControllerPushDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        (self.viewControllers![1].childViewControllers[0] as! ViewController).delegate = self
        

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        
    }
    
 
   
    
    
    
    
    func searchBarDidFocus() {
        let vc = SearchResultsCollectionViewController(collectionViewLayout: NoHeaderCollectionViewLayout())
      
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
        
    

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
