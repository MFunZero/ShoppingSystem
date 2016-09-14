//
//  PayOrderController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/9/4.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

private let cellAddresstifier = "address"
private let cellIdentifier = "custom"
private let cellIsFree = "cellIsFree"
private let cellHeaderIdentifier = "sectionHeader"
private let cellImgIdentifier = "goods"



class PayOrderController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!

    var cartItem:[CartItem] = [CartItem]()
    var orders:Orders = Orders()
    var address:Address!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.title = "等待付款"
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

extension PayOrderController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
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
        if section == cartItem.count{
            return 0
        }
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        switch section {
        case 0:
            let addressTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellAddresstifier, forIndexPath: indexPath) as! AddressTableViewCell
            
            addressTableViewCell.selectionStyle = .None
            addressTableViewCell.setItem(address)
            return addressTableViewCell
        case cartItem.count+1:
            switch row {
            case 0:
               let couponscell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
                couponscell .accessoryType = .DisclosureIndicator
                couponscell .textLabel?.text = "优惠券"
                couponscell .isThereAnyCoupons()
                couponscell .selectionStyle = .None
                
                return couponscell
                
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier(cellIsFree, forIndexPath: indexPath) as! FreePostageTableViewCell
                cell.selectionStyle = .None
                
                return cell
            }
        default:
            
            switch row {
            case 0:
                let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
                cell.textLabel?.setSizeAttributeText("订单编号：", subfixText: "\(orders.id!)", color: UIColor(rgb:seperatorRGB), subfixSize: 10)
                
                cell.detailTextLabel?.text = timeStampToString(orders.createAt!)

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
                cell.detailTextLabel!.setAttributeText("合计：", subfixText: "￥\(orders.sumMoney!)",color: UIColor.redColor())
                
                
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
    
    
    @IBAction func payRequest(sender: AnyObject) {
        
        let type = PayType()

        let alertController = UIAlertController(title: "请选择付款方式", message: nil, preferredStyle: .ActionSheet)
        let aliPay = UIAlertAction(title: "支付宝支付", style: .Destructive) { (alert) in
            self.payForOrders(type.aliPay)
        }
        
        let wxPay = UIAlertAction(title: "微信支付", style: .Destructive) { (alert) in
            self.payForOrders(type.wxPay)
        }
        let unionPay = UIAlertAction(title: "银联支付", style: .Destructive) { (alert) in
            self.payForOrders(type.unionPay)
        }
        
        let applePay = UIAlertAction(title: "ApplePay支付", style: .Destructive) { (alert) in
            self.payForOrders(type.applePay)
        }
        
        alertController.addAction(aliPay)
        alertController.addAction(wxPay)
        alertController.addAction(unionPay)
        alertController.addAction(applePay)

        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func payForOrders(type:String){
        
        let url = BaseURL.stringByAppendingString("pay/payByClient")
        
        
        
        let param = ["orders":orders.mj_JSONString(),
                     "type":type]
        
        SuzeeRequest.shareInstance.request("payRequest", url: url, param: param) { (falg, value) in
            
            switch (falg) {
                
            case false:
                
                print("Error to payRequest")
                
            case true:
                print("value:\(value)")
                if let val = value {
                    
                    let kUrlScheme = "ShoppingSystem"
                    
                    Pingpp.createPayment(val as! NSObject , viewController: UIViewController(), appURLScheme:kUrlScheme, withCompletion: { (result, error) in
                        if result == "success" {
                            print("支付成功")
                            self.navigationController?.popToRootViewControllerAnimated(true)
                        }else{
                            print("支付失败")
                        }
                    })
                    
                }
            }
        }

    }
    
    @IBAction func cancelOrders(sender: AnyObject) {
    }
    
    @IBAction func relationWithSaler(sender: AnyObject) {
    }
    
    
}


struct PayType {
    let aliPay = "alipay_wap"
    let wxPay = "wx"
    let applePay = "applePay"
    let unionPay = "unionPay"
    
}
