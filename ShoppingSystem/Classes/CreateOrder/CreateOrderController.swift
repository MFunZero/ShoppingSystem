//
//  CreateOrderController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/9/1.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit
import Alamofire


private let cellAddresstifier = "address"
private let cellIdentifier = "custom"
private let cellIsFree = "cellIsFree"
private let cellHeaderIdentifier = "sectionHeader"
private let cellImgIdentifier = "goods"



class CreateOrderController: UIViewController ,UITableViewDelegate,UITableViewDataSource,ServiceConfirmViewDelegate{
    
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var grayView:UIView = UIView()
    var confirmView:ServiceConfimView?
    
    var order:Orders = Orders()
    var cartItem:[CartItem] = [CartItem]()
    var addressed:[Address] = [Address]()
    var userCoupons:[UserCoupons] = [UserCoupons]()

    var addressTableViewCell:AddressTableViewCell?
    var couponscell:UITableViewCell?
    var address:Address!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        self.tableView.backgroundColor = UIColor(rgb: seperatorRGB)
        
        tableView.separatorStyle = .SingleLine

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNib(UINib(nibName: "OrderItemTableViewCell",bundle: nil), forCellReuseIdentifier: cellImgIdentifier)
        tableView.registerNib(UINib(nibName: "AddressTableViewCell",bundle: nil), forCellReuseIdentifier: cellAddresstifier)
        
        tableView.registerNib(UINib(nibName: "FreePostageTableViewCell",bundle: nil), forCellReuseIdentifier: cellIsFree)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension CreateOrderController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case cartItem.count+1:
            return 2
        default:
            return cartItem.count+3
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = indexPath.section
        let row = indexPath.row
        switch section {
        case 0:
            return 80
        case cartItem.count+1:
            return 44
        default:
            switch row {
            case 0:
                return 44
                
            case cartItem.count+1:
                return 44
            case cartItem.count+2:
                return 44
            default:
                return 80
            }
        }
    }

    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == cartItem.count+1{
            return 0
        }
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        switch section {
        case 0:
          addressTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellAddresstifier, forIndexPath: indexPath) as? AddressTableViewCell
            addressTableViewCell!.accessoryType = .DisclosureIndicator
            addressTableViewCell!.selectionStyle = .None

            return addressTableViewCell!
        case cartItem.count+1:
            switch row {
            case 0:
                couponscell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
                couponscell! .accessoryType = .DisclosureIndicator
                couponscell! .textLabel?.text = "使用优惠券"
                couponscell! .isThereAnyCoupons()
                couponscell! .selectionStyle = .None

                return couponscell!
             
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier(cellIsFree, forIndexPath: indexPath) as! FreePostageTableViewCell
                cell.selectionStyle = .None

                return cell
            }
        default:
            
            switch row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
                cell.textLabel?.text = cartItem[row].saller
                cell.imageView?.image = UIImage(named: "care")
                cell.selectionStyle = .None

                return cell
          
            case cartItem.count+1:
           
                let cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
                cell.textLabel?.text = "快递"
                cell.detailTextLabel?.text = "快递 免费"
                cell.selectionStyle = .None

                return cell
            case cartItem.count+2:
              
                let cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
                var price:Double = 0
                var num:Int = 0
                for item in cartItem{
                    price += Double(item.totalPrice!)!
                    num += item.num!.integerValue
                }
                cell.textLabel?.text = "共\(num)件商品"
                cell.detailTextLabel?.text = "￥\(price)"
                

                order.sumMoney = String(price)
           
            
            totalPriceLabel.setAttributeText("合计：", subfixText: "￥\(order.sumMoney!)",color: UIColor.redColor())
                
                cell.selectionStyle = .None
            
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier(cellImgIdentifier, forIndexPath: indexPath) as! OrderItemTableViewCell
                cell.selectionStyle = .None
                cell.setItemModel(cartItem[row-1])
                
                return cell
            }
            
      
        }
        
        
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        switch section {
        case 0:
            getAddressList()
        case cartItem.count+1:
            switch row {
            case 0:
                getUserCouponsList()
            default:
                break
            }
        default:
            
                break
            }
        
    }
    
    func getUserCouponsList(){
        
      
        
        guard let userCoupons = couponscell!.userCoupons else{
            toastErrorMessage(self.view, title: "您当前无可用优惠券", hideAfterDelay: 2.0)
            return
        }
        
        self.userCoupons = userCoupons
        
        grayView.frame = self.view.frame
        grayView.backgroundColor = UIColor.blackColor()
        grayView.alpha = 0.3
        self.navigationController?.view.addSubview(grayView)
        
        confirmView = NSBundle.mainBundle().loadNibNamed("ServiceConfimView", owner: self, options: nil).last as? ServiceConfimView
        
        confirmView?.frame = CGRectMake(screenW*0.05, screenH/2-screenW*0.3, screenW*0.9, screenW*0.6)
        self.navigationController?.view.addSubview(confirmView!)
       
        confirmView?.delegate = self
        
        confirmView?.layer.cornerRadius = 10
        confirmView?.clipsToBounds = true
        confirmView?.type = AlertConfirmType.service
  
                        var strs:[String] = [String]()
                        
                        for item in self.userCoupons{
                            strs.append(item.description)
                            self.userCoupons.append(item)
                        }
                        
                        self.confirmView?.titles.appendContentsOf(strs)
                        
                        self.confirmView?.pickerView.reloadAllComponents()
        
        }


    func getAddressList(){
        grayView.frame = self.view.frame
        grayView.backgroundColor = UIColor.blackColor()
        grayView.alpha = 0.3
        self.navigationController?.view.addSubview(grayView)
        
        confirmView = NSBundle.mainBundle().loadNibNamed("ServiceConfimView", owner: self, options: nil).last as? ServiceConfimView
        
        confirmView?.frame = CGRectMake(screenW*0.05, screenH/2-screenW*0.3, screenW*0.9, screenW*0.6)
        self.navigationController?.view.addSubview(confirmView!)
        
        confirmView?.delegate = self
        
        confirmView?.layer.cornerRadius = 10
        confirmView?.clipsToBounds = true
        confirmView?.type = AlertConfirmType.address
        
        
        let url = BaseURL.stringByAppendingString("address/query?").stringByAppendingString("userId=\(currentUserId)")
        Alamofire.request(.GET, url)
            .responseJSON() { (data)in
                
                let result = data.result
                
                switch (result) {
                    
                case .Failure:
                    
                    print("Error to getArress:\(result.error)")
                    
                    toastErrorMessage(self.view, title: "获取数据出错，请稍后重试", hideAfterDelay: 2.0)
                    
                case .Success(let value):
                    print("Success to getArress:\(value)")
                    
                    
                    if let items = result.value as? NSDictionary{
                        //遍历数组得到每一个字典模型
                        let array = items.objectForKey("list") as! NSArray
                        print("items:\(array)")
                        
                        let address:NSArray = Address.mj_objectArrayWithKeyValuesArray(array)
                        
                        
                        var strs:[String] = [String]()
                        
                        for item in address{
                            strs.append(item.description)
                            self.addressed.append(item as! Address)
                        }
                        
                        self.confirmView?.titles.appendContentsOf(strs)
                        
                        self.confirmView?.pickerView.reloadAllComponents()
                        
                    }
                    
                    
                }
        }

    }
    
    func cancelButtonClicked() {
        grayView.removeFromSuperview()
        confirmView?.removeFromSuperview()
    }
    
    func confirmButtonClicked(title: String,type:AlertConfirmType,index:Int) {
        grayView.removeFromSuperview()
        confirmView?.removeFromSuperview()
        
        if title == "" {
            return
        }
        
     
        
        switch type {
            
        case .category:
            break
        case .address:
            order.addressId = self.addressed[index].id
            
             address = self.addressed[index]

        addressTableViewCell?.setItem(self.addressed[index])
            
        case .service:
            order.userCouponsId = self.userCoupons[index].id

        }

        
    }

    
    @IBAction func confirmButtonClicked(sender: AnyObject) {
        
        guard order.addressId != nil else{
        
            toastErrorMessage(self.view, title: "请选择收货地址", hideAfterDelay: 2)
            return
        }
        
        guard self.order.id != "" else {
            toastErrorMessage(self.view, title: "订单已经创建成功，可移步到‘我的订单’进行查看", hideAfterDelay: 2)
            return
        }
        
        
        order.purchaseId = currentUserId
        var items:[OrderItem] = [OrderItem]()
        
        for item in self.cartItem {
            
            let oi:OrderItem = OrderItem(goodsId: item.goodsId!, count: item.num!, specificationId: item.specId!, totalPrice: item.totalPrice!)
            items.append(oi)
            
        }
        
        let para1 = OrderItemsList(list: items)
        
        let url = BaseURL.stringByAppendingString("orders/self/addOne")
      
        
        
        let param = ["list":para1.mj_JSONString(),
                     "orders":order.mj_JSONString()]
        
      
        let dict = NSMutableDictionary()
//        dict["orders"] = order.mj_JSONString()
        dict["list"] = para1.mj_JSONString()
        
        let meter = dict as NSDictionary as! [String:AnyObject]
        print("item:\(meter)")

        
        SuzeeRequest.shareInstance.request("orders", url: url, param: param) { (falg, value) in
            
            switch (falg) {
                
            case false:
                
                print("Error to AddOrders")
                
            case true:
                if let val = value {
                    let orders:Orders = Orders.mj_objectWithKeyValues(val)
                    let mainStoryBoard = UIStoryboard(name: "PayOrderController", bundle: nil)
                    let vc = mainStoryBoard.instantiateInitialViewController() as? PayOrderController
                    vc?.cartItem = self.cartItem
                    vc?.orders = orders
                    vc?.address = self.address
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
                    
                    
                }
            
        }
        
    }
    
}


//MARK: UITableViewCell的扩展
extension UITableViewCell {
    
   
    private struct AssociatedKeys {
        static var usercoupons:[UserCoupons]?
    }
    
    var userCoupons: [UserCoupons]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.usercoupons) as? [UserCoupons]
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.usercoupons, newValue as [UserCoupons]?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    func  isThereAnyCoupons() {
        
        
        let url = BaseURL.stringByAppendingString("usercoupons/queryListByUserId?userId=\(currentUserId)")
        SuzeeRequest.shareInstance.request("coupons", url: url) { (falg, value) in
            
            switch (falg) {
                
            case false:
                
                print("Error to getUserCoupons")
              
            case true:
                print("Success to getUserCoupons:\(value)")
                if let array = value as? NSArray {
                    
                    if array.count == 0 {
                       self.detailTextLabel?.text = "无可用优惠券"
                        return
                    }
                    
                    print("items:\(array)")
                    
                    let address:NSArray = UserCoupons.mj_objectArrayWithKeyValuesArray(array)
                    
                    
                    var strs:[String] = [String]()
                    var coupons:[UserCoupons] = [UserCoupons]()
                    for item in address{
                        strs.append(item.description)
                        coupons.append(item as! UserCoupons)
                    }
                    
                    self.userCoupons = coupons
                }
                }
            }
        
    }
}


extension UILabel {
    func setAttributeText(prefixText:String,subfixText:String,color:UIColor) {
        let str = prefixText+subfixText
        let attr = NSMutableAttributedString(string: str)
        attr.addAttributes([NSForegroundColorAttributeName:color], range: NSRange(location: prefixText.characters.count,length: subfixText.characters.count))
        self.attributedText = attr
        
    }
    func setSizeAttributeText(prefixText:String,subfixText:String,color:UIColor,subfixSize:CGFloat) {
        let str = prefixText+subfixText
        let attr = NSMutableAttributedString(string: str)
        attr.addAttributes([NSFontAttributeName:UIFont(name: "Arial", size: subfixSize)!], range: NSRange(location: prefixText.characters.count,length: subfixText.characters.count))
        self.attributedText = attr
        
    }
}
