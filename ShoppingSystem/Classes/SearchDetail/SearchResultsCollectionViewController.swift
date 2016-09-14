//
//  SearchResultsCollectionViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/13.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SearchResultsCollectionViewController: UICollectionViewController,UISearchResultsUpdating ,UISearchBarDelegate,NoHeaderCollectionViewLayoutDelegate {
    
    var searchController:UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.modalPresentationStyle = .CurrentContext
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.collectionView?.backgroundColor = UIColor.whiteColor()
        

        let layoutNew = NoHeaderCollectionViewLayout()
        layoutNew.delegate = self
        self.collectionView!.collectionViewLayout = layoutNew
        
        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        
        self.searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            return controller
        })()
        
        
        // Add search bar to navigation bar
        navigationItem.titleView = searchController.searchBar
        // Size search bar
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        // Do any additional setup after loading the view.
    }

    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        
    }
    
    
    deinit
    {
        //Attempting to load the view of a view controller while it is deallocating is not allowed and may result in undefined behavior (<UISearchController: 0x7fb6dbfebc10>)
        //如果出现这些，请用下面任意的一种方法
        
        searchController.active = false
        searchController.view.removeFromSuperview()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: NoHeaderCollectionViewLayoutDelegate
    
    func flowLayout(layout: NoHeaderCollectionViewLayout, heightForWidth width: CGFloat, atIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 2
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        // Configure the cell
    cell.backgroundColor = UIColor.cyanColor()
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
