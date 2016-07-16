//
//  ViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/10.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

protocol FoundViewControllerPushDelegate {
    func searchBarDidFocus()
}

class ViewController: UIViewController ,UISearchBarDelegate{
    
    var delegate:FoundViewControllerPushDelegate?
    
    var searchBar:UISearchBar!
    
    var historyView:UIScrollView = UIScrollView()
    var vw:SearchScrollView!
    
    override func viewWillAppear(animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        setupView()

    }
    
    func setupView()
    {
        
        setupHistoryView()
        
        self.searchBar = UISearchBar()
        
       searchBar.delegate = self
        // Add search bar to navigation bar
        navigationItem.titleView = searchBar
        // Size search bar
       searchBar.sizeToFit()
       searchBar.showsCancelButton = true
    
    
    }
    deinit
    {
      
    }

    
    func setupHistoryView()
    {
        vw = (NSBundle.mainBundle().loadNibNamed("SearchScrollView", owner: self, options: nil).last as? SearchScrollView)!
        historyView.addSubview(vw)
        historyView.frame = CGRectMake(0,0,screenW,screenH - 113)
        historyView.contentSize = CGSizeMake(0, screenH)
        self.view.addSubview(historyView)
        vw.frame = CGRectMake(0,0,screenW,historyView.frame.height)


        
        vw.backgroundColor = UIColor(rgb: 0xCBCBCB)
        historyView.backgroundColor = UIColor(rgb: 0xCBCBCB)

        historyView.alpha = 0
        
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
      
       

        UIView.animateWithDuration(1) {
            self.historyView.alpha = 1.0
            self.view.bringSubviewToFront(self.historyView)
            
        }
        self.vw.updateHistoryData()

        
       
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        

        searchBar.resignFirstResponder()
        
       
        UIView.animateWithDuration(1) {
            self.historyView.alpha = 0
            self.view.sendSubviewToBack(self.historyView)
        }
        
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        let text = searchBar.text
        
        SearchHistoryTool.shareInstance.insertElementToHistory(text!)
        
        self.delegate?.searchBarDidFocus()
        
        UIView.animateWithDuration(1) { 
            self.historyView.alpha = 0
            self.view.sendSubviewToBack(self.historyView)
        }
        
       
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

