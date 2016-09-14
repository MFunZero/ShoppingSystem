//
//  ViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/10.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

private let collectionCellIdentifier = "collectionCellIdentifier"
private let reuseViewHeader = "Header"
private let reuseViewFooter = "Footer"


protocol FoundViewControllerPushDelegate {
    func searchBarDidFocus()
}

class ViewController: UIViewController ,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var delegate:FoundViewControllerPushDelegate?
    
    var searchBar:UISearchBar!
    
    var historyView:UIScrollView = UIScrollView()
    var vw:SearchScrollView!
    
 
    
    
    
    @IBOutlet var collectionView: UICollectionView!
    
   
    
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
    
    
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    
        self.collectionView.registerNib(UINib(nibName: "CategoryCollectionViewCell",bundle: nil),forCellWithReuseIdentifier: collectionCellIdentifier)
        
        self.collectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseViewHeader)
        self.collectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: reuseViewFooter)
        
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

extension ViewController {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(screenW, 50)
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSizeMake(screenW, 50)
//    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let reuseView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: reuseViewHeader, forIndexPath: indexPath)
            reuseView.backgroundColor = UIColor.blueColor()
            return reuseView
        }else{
            let reuseView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: reuseViewFooter, forIndexPath: indexPath)
            reuseView.backgroundColor = UIColor.blueColor()
            return reuseView
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellIdentifier, forIndexPath: indexPath)
        as! CategoryCollectionViewCell
        
        cell.backgroundColor = UIColor.cyanColor()
        
        return cell
    }
}

