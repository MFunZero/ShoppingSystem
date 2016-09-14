//
//  SpecView.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/29.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

enum AlertType {
    case Spec,Confirm
}

protocol SpecViewDelegate {
    func confirmButtonClicked()
    func cancelButtonClicked()
    func confirmCreateOrder(item:CartItem)
    
}

private let clIdentiFier = "SpecIdentifier"

class SpecView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {

    var delegate:SpecViewDelegate?
    
    var type:AlertType?
    
    var selectedRow:Int?
    lazy var cartItem = CartItem()
    
    private lazy var specifications:[Specification] = [Specification]()
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
  
    @IBOutlet weak var remarkLabel: UILabel!
    
    func setSpeciFications(spes:[Specification],goods:GoodsModelItem)
    {
        
        self.specifications = spes
        self.priceLabel.text = "￥\(goods.price!)"
        self.titleLabel.text = goods.title
        let urls = goods.mainPicture?.componentsSeparatedByString(",")
        let url = BaseImgURL.stringByAppendingString(urls![0])
        let iUrl = NSURL(string: url)
        picture.sd_setImageWithURL(iUrl)
        
        
        self.collectionView.reloadData()
        
        cartItem.goods = goods
        cartItem.goodsId = goods.id
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code

        picture.layer.cornerRadius = 10
        picture.clipsToBounds = true
        picture.layer.borderColor = UIColor.whiteColor().CGColor
        picture.layer.borderWidth = 5
    
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        
        collectionView.registerNib(UINib(nibName: "SpeItemCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: clIdentiFier)
        
    }
 
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        
        self.delegate?.cancelButtonClicked()
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return specifications.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(clIdentiFier, forIndexPath: indexPath) as! SpeItemCollectionViewCell
        let row = indexPath.row
        
        cell.contentLabel.text = "\(specifications[row].descriptionTitle!)"
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(rgb: seperatorRGB)
        
//        cell.selectedBackgroundView = selectedView
        
        return cell
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let row  = indexPath.row
        let cell = collectionView.cellForItemAtIndexPath(indexPath)

        cell!.backgroundColor = UIColor(rgb: seperatorRGB)

        if row == selectedRow{
            cell?.selected = false
            selectedRow = nil
            cell!.backgroundColor = UIColor.whiteColor()

        
        }
        else{
            selectedRow = row
            
            remarkLabel.attributedText = nil
            remarkLabel.text = "规格"
        }
    }
    
 
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize{
        let row = indexPath.row
        
        let size = sizeForText(CGSizeMake(150, 30), str: specifications[row].descriptionTitle!)
        
        return size
    }
    
    @IBAction func addNumButtonClicked(sender: AnyObject) {
        
        let num = Int(self.numLabel.text!)!+1
        self.numLabel.text = "\(num)"
       
        
    }
    
    @IBAction func subNumButtonClicked(sender: AnyObject) {
        
        
        let num = Int(self.numLabel.text!)!-1
        if num == 0 {
            return
        }
        self.numLabel.text = "\(num)"
        
    }
    
    @IBAction func confirmButtonClicked(sender: AnyObject) {
        
        if type == AlertType.Spec {
            addToCart()
        }
        else{
            createOrder()
        }
        
    }
    
    func createOrder()
    {
        if let row = selectedRow{
            cartItem.spec = specifications[row]
            let num = Int(numLabel.text!)
            guard  cartItem.spec?.price != nil else{
                print("price error")
                return
            }
            print("price \(specifications[row].price!)")
            
            let price = Double(num!) * Double(cartItem.spec!.price!)!
            cartItem.totalPrice = String(price)
            
            cartItem.num = num
            
            let goodsId = cartItem.goods!.id!
            let specId = cartItem.spec!.id!
            
            cartItem.goodsId = goodsId
            cartItem.specId = specId
            

            
          self.delegate?.confirmCreateOrder(cartItem)
            
            
        }
        else{
            remarkLabel.text = "规格  请选择商品规格   "
            let att = NSMutableAttributedString(string: "规格  请选择商品规格")
            att.addAttributes([NSForegroundColorAttributeName:UIColor.redColor()], range: NSRange(location: 3,length: 8))
            att.addAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)], range: NSRange(location: 3,length: 8))
            
            remarkLabel.attributedText = att
            
            
            return
        }

        
        
        
    }
    
    func addToCart()
    {
        if let row = selectedRow{
            cartItem.spec = specifications[row]
            let num = Int(numLabel.text!)
            guard  cartItem.spec?.price != nil else{
                print("price error")
                return
            }
            print("price \(specifications[row].price!)")
            
            let price = Double(num!) * Double(cartItem.spec!.price!)!
            cartItem.totalPrice = String(price)
            
            cartItem.num = num
            cartItem.saller = cartItem.goods!.userId!
            let goodsId = cartItem.goods!.id!
            let specId = cartItem.spec!.id!
            
            CartDBTool.shareInstance.createTable("Cart.db")
            
            
            let isExistSql = "select * from T_Cart where goodsId=\(goodsId) and specId=\(specId)"
            CartDBTool.shareInstance.recordSet("Cart.db",sql: isExistSql,callBack: { (array) in
                print("array:\(array)")
                
                let count = array.count
                if count > 0 {
                    //                    update num
                    let item = array[0] as! CartItem
                    print("购物车:\(item.description)")
                    
                    let num = Int(self.numLabel.text!)
                    let updateSql = "update T_Cart set num=\(num) where id=\(item.id)"
                    
                    if CartDBTool.shareInstance.executeSQL(updateSql) {
                        print("添加到购物车成功")
                        self.delegate?.confirmButtonClicked()
                    }else{
                        
                        self.delegate?.confirmButtonClicked()
                    }
                    
                }
                else{
                    let sql = "insert into T_Cart(num,totalPrice,goodsId,specId) values (\(num!),\(price),\(goodsId),\(specId))"
                    let flag = CartDBTool.shareInstance.insertTable("Cart.db", sql: sql)
                    print("dbTool flag:\(flag)")
                    self.delegate?.confirmButtonClicked()
                    
                }
                
            })
            
            
        }
        else{
            remarkLabel.text = "规格  请选择商品规格   "
            let att = NSMutableAttributedString(string: "规格  请选择商品规格")
            att.addAttributes([NSForegroundColorAttributeName:UIColor.redColor()], range: NSRange(location: 3,length: 8))
            att.addAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)], range: NSRange(location: 3,length: 8))
            
            remarkLabel.attributedText = att
            
            
            return
        }

    }
    
}
