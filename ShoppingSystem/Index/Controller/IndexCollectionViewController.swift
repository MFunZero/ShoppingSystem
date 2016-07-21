//
//  IndexCollectionViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/10.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

protocol IndexViewControllerDelegate {
    func addButtonClicked()
}



private let reuseIdentifier = "Cell"

class IndexCollectionViewController: UICollectionViewController,WaterfallFlowCollectionViewLayoutDelegate {
    
    var delegate:IndexViewControllerDelegate?

    var imgURLS = ["http://i0.hdslb.com/bfs/bangumi/a32e30108af7cd7349201f0b7664392b5b7a3646.jpg","http://i0.hdslb.com/bfs/bangumi/1cc08a1f81b6241b31afa90b8ebd62c5b3c75e09.jpg","http://i0.hdslb.com/bfs/bangumi/9ff5679d5bb95750802ec98796fde26b16740f10.jpg"]
    
    @IBOutlet weak var regesterBarButton: UIBarButtonItem!
    @IBOutlet weak var loginBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "LightBlurView"), forBarMetrics: .Default)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.title = NSLocalizedString("首页", comment: "Index")
               
        let layoutNew = WaterfallFlowCollectionViewLayout()
        layoutNew.delegate = self;
        self.collectionView!.collectionViewLayout = layoutNew
        self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
     
        
        
        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(loginSuccess(_:)), name: "LoginSuccess", object: nil)
        
        
        // Do any additional setup after loading the view.
    }
    
    func loginSuccess(notification:NSNotification){
        loginBarButton.title = ""

        let customView1 = UIImageView(image: UIImage(named: "Artboard 1"))
       
        loginBarButton.customView = customView1
        customView1.userInteractionEnabled = true
        let gap1 = UITapGestureRecognizer(target: self, action: #selector(rightBarButtonClicked))
        customView1.addGestureRecognizer(gap1)
        
        regesterBarButton.title = ""
        let customView = UIImageView(image: UIImage(named: "leftMenu"))

        regesterBarButton.customView = customView
        customView.userInteractionEnabled = true
        let gap = UITapGestureRecognizer(target: self, action: #selector(showMenu))
        customView.addGestureRecognizer(gap)
        
    }
    
    func showMenu()
    {
        print("The leftMenu was  being clicked")
    }
    
    func rightBarButtonClicked(){
        
        self.delegate?.addButtonClicked()
        
    }

    @IBAction func regesterButtonClicked(sender: AnyObject) {
        let vc = UIStoryboard(name: "RegesterViewController", bundle: nil)
        let vcController = vc.instantiateViewControllerWithIdentifier("RegesterViewController")
        
        self.presentViewController(vcController, animated: true, completion: nil)
    }
    @IBAction func loginButtonClicked(sender: AnyObject) {
        
        let vc = UIStoryboard(name: "LoginControllerViewController", bundle: nil)
        let vcController = vc.instantiateViewControllerWithIdentifier("LoginControllerViewController")
        
        self.presentViewController(vcController, animated: true, completion: nil)
        
    }
    func flowLayout(layout: WaterfallFlowCollectionViewLayout, heightForWidth width: CGFloat, atIndexPath indexPath: NSIndexPath) -> CGFloat {
        let row = indexPath.row
        if row%2 == 1{
            return 120
        }else {
            return 80
        }
        
    }
    
    func flowLayout(layout: WaterfallFlowCollectionViewLayout, heightForHeader width: CGFloat) -> CGFloat {
        return 140
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

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reusableView:UICollectionReusableView!
        
        reusableView = collectionView.dequeueReusableSupplementaryViewOfKind( kind, withReuseIdentifier: "HeaderView", forIndexPath: indexPath)
            reusableView.backgroundColor = UIColor.cyanColor()
        
        let banner = BanerImagesScrollView(frame: CGRect(x: 0, y: 0, width: screenW, height: reusableView.frame.height))
        banner.backgroundColor = UIColor.whiteColor()
        banner.imgsURL = imgURLS
        reusableView.addSubview(banner)
        
      return reusableView
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        // Configure the cell
        cell.backgroundColor = UIColor.brownColor()
    
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
