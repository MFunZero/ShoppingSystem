//
//  IndexCollectionViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/10.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD


protocol IndexViewControllerDelegate {
    func addButtonClicked()
    func toDetailController(item:GoodsModelItem)
}



private let reuseIdentifier = "Cell"

class IndexCollectionViewController: UICollectionViewController,WaterfallFlowCollectionViewLayoutDelegate {
    
    var delegate:IndexViewControllerDelegate?

   
    
    @IBOutlet weak var regesterBarButton: UIBarButtonItem!
    @IBOutlet weak var loginBarButton: UIBarButtonItem!
    
    lazy var goodsList:[GoodsModelItem] = [GoodsModelItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        
        requestData()
    }

    func requestData()
    {
//        SVProgressHUD.showInfoWithStatus("数据加载中...")
        
        let url = BaseURL.stringByAppendingString("goods/query")
    Alamofire.request(.GET, url)
        .responseJSON { (response) in
            let result = response.result
            switch result{
            case .Failure(let error):
                print("Failed get goodsList:\(error)")
//                SVProgressHUD.dismiss()
                toastErrorMessage(self.view, title: "获取数据出错，请稍后重试", hideAfterDelay: 2)
                
            case .Success(let value):
                print("Successed get goodsList:\(value)")
                let list = value.objectForKey("list") as! NSMutableArray
                
                let goodsArray = GoodsModelItem.mj_objectArrayWithKeyValuesArray(list)
                for item in goodsArray{
                    self.goodsList.append(item as! GoodsModelItem)
                }
                
                self.collectionView?.reloadData()
//                SVProgressHUD.showSuccessWithStatus("数据加载完成")
            }
        }
    }
    
    func configView()
    {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "LightBlurView"), forBarMetrics: .Default)
        
        
        
        self.title = NSLocalizedString("首页", comment: "Index")
        
        let layoutNew = WaterfallFlowCollectionViewLayout()
        layoutNew.delegate = self;
        self.collectionView!.collectionViewLayout = layoutNew
        self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        
        
        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.registerNib(UINib(nibName: "IndexCustomCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: "custom")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(loginSuccess(_:)), name: "LoginSuccess", object: nil)
        

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
            return 200
        }else {
            return 160
        }
        
    }
    
    func flowLayout(layout: WaterfallFlowCollectionViewLayout, heightForHeader width: CGFloat) -> CGFloat {
        return 140
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.goodsList.count
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("custom", forIndexPath: indexPath) as! IndexCustomCollectionViewCell
    
        // Configure the cell
        cell.backgroundColor = UIColor.brownColor()
        let row = indexPath.row
        cell.setGoodModel(goodsList[row])
        
        return cell
    }

   override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

    self.delegate?.toDetailController(self.goodsList[indexPath.row])
    
    }

}
