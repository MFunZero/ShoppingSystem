//
//  PublishViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/20.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import MBProgressHUD

enum AlertConfirmType {
    case category,service,address
}


private let SpecificationTableCellIdentifier="SpecificationTableViewCell"

class PublishViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,SpecificationTableViewDelegate,CollectionViewCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ServiceConfirmViewDelegate,TitleViewDelegate{
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var topContentView: TitleView!
    @IBOutlet weak var uploadContentView: UploadContentView!
    
    @IBOutlet weak var  tableView:UITableView!
    
    @IBOutlet weak var bottomView: UIView!
    //MARK -- bottomView Service
    @IBOutlet weak var serviceButton: UIButton!
    
    @IBOutlet weak var expressAddressButton: UIButton!
    
    @IBOutlet weak var isPostageFree: UISwitch!
    
    
    
    
    //MARK -- confirmView
    
    var confirmView:ServiceConfimView?
    var grayView:UIView = UIView()
    
    
    // MARK--dataSource
    
    var imgs:[String] = [String]()
    
    var imgpickerController:UIImagePickerController = UIImagePickerController()
    
    var cellCount = 1
    
    
    lazy var specifications:[Specification] = [Specification]()
    var goods:GoodsModelItem = GoodsModelItem()

    lazy var addresses:[Address] = [Address]()
    lazy var saleServices:[Post_SaleService] = [Post_SaleService]()
    lazy var categorys:[Category] = [Category]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        congfigView()
    }
    
    func congfigView()
    {
        uploadContentView.setframe(uploadContentView.frame)
        
        uploadContentView.delegate = self
        uploadContentView.imgs.append(UIImage(named: "Artboard 1")!)
        
        
        topContentView.setframe(topContentView.frame)
        
        topContentView.delegate = self
        topContentView.layer.cornerRadius = 10
        topContentView.clipsToBounds = true
        
        
        
        uploadContentView.layer.cornerRadius = 10
        uploadContentView.clipsToBounds = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        tableView.scrollEnabled = false
        
        tableView.registerNib(UINib(nibName: "SpecificationTableViewCell",bundle: nil), forCellReuseIdentifier: SpecificationTableCellIdentifier)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .None
        
        
    }
    
        func textFieldDidEndEdit(text: String) {
         goods.title = text
    }
    
    
    @IBAction func doneButtonClicked(sender: AnyObject) {
        
        print("发布商品信息:\(isPostageFree.on)")
        
        let str = imgs.joinWithSeparator(",")
        goods.mainPicture = str
        print("发布商品信息:\(str)")
        let flag = isPostageFree.on
        if flag {
            goods.isFreePostage = 1
        }else{
            goods.isFreePostage = 0
        }
        
        goods.userId = currentUserId
        
        if goods.categoryId == nil {
            
            toastErrorMessage(self.view, title: "请选择商品分类", hideAfterDelay: 2.0)
            
            return
        }
        
        if goods.title == nil {
           
            toastErrorMessage(self.view, title: "请输入标题描述", hideAfterDelay: 2.0)

            
            return
        }

        if goods.titleDescription == nil {
            
            toastErrorMessage(self.view, title: "请输入商品描述", hideAfterDelay: 2.0)
            
            
            return
        }
        
        if str == ""{
            
            toastErrorMessage(self.view, title: "请上传图片完成后操作", hideAfterDelay: 2.0)
            return
        }
        
        if goods.post_saleService == "" {
            
            toastErrorMessage(self.view, title: "请选择售后服务", hideAfterDelay: 2.0)

            
            return
        }
        
      
        
       
        
        if specifications.count == 0 {
           
            toastErrorMessage(self.view, title: "请添加商品规格参数", hideAfterDelay: 2.0)
            
            return
        }
        
        if goods.deliveryAddressId == nil {
            
            toastErrorMessage(self.view, title: "请选择发货地址", hideAfterDelay: 2.0)
            
            
            return
        }
        
        getSpecificationsIDS { (flag) in
            if flag {
                self.insertGoodsItem()
            }
        }
        
    }
    
    func insertGoodsItem(){
        let urlSpe = BaseURL.stringByAppendingString("goods/addOne")
        
        let goodsArray = [goods]
        let param = GoodsModelItem.mj_keyValuesArrayWithObjectArray(goodsArray)
        print("list:\(param)")
        Alamofire.request(.GET, urlSpe, parameters:param[0] as? [String : AnyObject] )
            .responseJSON { response in
                let result = response.result
                switch result{
                case .Failure(let error):
                    print("goods failed:\(error)")
                 SVProgressHUD.showErrorWithStatus("发生未知错误，请稍后重试")
                    
                case .Success(let value):
                    print("goods successed:\(value)")
                    SVProgressHUD.showSuccessWithStatus("发布成功")
                    self.navigationController?.popToRootViewControllerAnimated(true)
                   
                }
        }
        
    }
    
    
    func getSpecificationsIDS(callback:(Bool)->()){
        let urlSpe = BaseURL.stringByAppendingString("specifications/addList")
        
        let spe = SpecificationsList(list: specifications)
        
        let param = ["Specifications":spe.mj_JSONString()]
        print("list:\(param)")
        Alamofire.request(.GET, urlSpe, parameters:param )
            .responseJSON { response in
                let result = response.result
                switch result{
                case .Failure(let error):
                    print("addSpecificationList failed:\(error)")
                    callback(false)

                case .Success(let value):
                    print("addSpecificationList successed:\(value)")
                    
                    let arr = value as! NSArray
                    print("arr:\(arr.count)")
                    
                    let spe = arr.componentsJoinedByString(",")
                    self.goods.specifications = spe
                    callback(true)
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
            goods.categoryId = categorys[index].id

            topContentView.categoryButton.setTitle(title, forState: .Normal)
            
        case .address:
            self.expressAddressButton.setTitle(title, forState: .Normal)
            goods.deliveryAddressId = addresses[index].id

        case .service:
            self.serviceButton.setTitle(title, forState: .Normal)
            goods.post_saleService = title

        }
        
    }
    
    
    func categoryButtonClicked() {
        
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
        confirmView?.type = AlertConfirmType.category
        
        let url = BaseURL.stringByAppendingString("category/query")
        Alamofire.request(.GET, url)
            .responseJSON() { (data)in
                
                let result = data.result
                
                switch (result) {
                    
                case .Failure:
                    
                    print("Error to getCategory:\(result.error)")
                    
                    
                    
                    toastErrorMessage(self.view, title: "获取数据出错，请稍后重试", hideAfterDelay: 2.0)
                    
                case .Success:
                    print("Success to getCategory")
                    
                    if let items = result.value as? NSDictionary{
                        //遍历数组得到每一个字典模型
                        let array = items.objectForKey("list") as! NSArray
                        print("items:\(array)")
                        
                       
                        
                        var strs:[String] = [String]()
                        
                        for item in array{
                            
                            let category = Category.mj_objectWithKeyValues(item)
                            
                            print("item:\(item),id:\(category.id),name:\(category.name),descr:\(category.description),uid:\(category.userId)")
                            strs.append(category.name!)
                            
                            self.categorys.append(category)
                        }

                        self.confirmView?.titles.appendContentsOf(strs)
                        
                        self.confirmView?.pickerView.reloadAllComponents()
                        
                    }
                    
                }
        }
        
        
        
        
    }
    
    @IBAction func serviceButtonClicked(sender: AnyObject) {
        
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
        let url = BaseURL.stringByAppendingString("saleService/query")
        Alamofire.request(.GET, url)
            .responseJSON() { (data)in
                
                let result = data.result
                
                switch (result) {
                    
                case .Failure:
                    
                    print("Error to getPostofsaleservice:\(result.error)")
                    
                    
                    
                     toastErrorMessage(self.view, title: "获取数据出错，请稍后重试", hideAfterDelay: 2.0)
                    
                case .Success(let value):
                    print("Success to getPostofsaleservice:\(value)")
                    
                    
                    if let items = result.value as? NSDictionary{
                        //遍历数组得到每一个字典模型
                        let array = items.objectForKey("list") as! NSArray
                        print("items:\(array)")
                        
                        let address:NSArray = Post_SaleService.mj_objectArrayWithKeyValuesArray(array)
                        
                
                        
                        var strs:[String] = [String]()
                        
                        for item in address{
                            strs.append(item.description)
                            self.saleServices.append(item as! Post_SaleService)
                        }
                        
                        self.confirmView?.titles.appendContentsOf(strs)
                        
                        self.confirmView?.pickerView.reloadAllComponents()
                        
                    }
                    
                    
                }
        }
        
        
    }
    

    
    @IBAction func expressAddressButtonClicked(sender: AnyObject) {
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
                            self.addresses.append(item as! Address)
                        }
                        
                        self.confirmView?.titles.appendContentsOf(strs)
                        
                        self.confirmView?.pickerView.reloadAllComponents()
                        
                    }
                    

                }
        }
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func disablesAutomaticKeyboardDismissal() -> Bool {
        return false
    }
    
    
}
extension PublishViewController{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if cellCount-1 == indexPath.row {
            
            return 64
        }else{
            return 140
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if cellCount-1 == indexPath.row {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            addSubButton(cell)
            
            cell.selectionStyle = .None
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier(SpecificationTableCellIdentifier, forIndexPath: indexPath) as? SpecificationTableViewCell
            cell!.selectionStyle = .None
            cell?.delegate = self
            
            
            return cell!
        }
    }
    
    
    
    
    func subImageButtonCliked(imgs: [UIImage]) {
//        self.imgs = imgs
    }
    
    func deleteButtonClicked(atIndexPath indexPath: NSIndexPath) {
        cellCount -= 1
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        updateFrame()
    }
    
    func addSubButton(view:UIView)
    {
        let rect = view.frame
        
        let button = UIButton(frame: CGRectMake(15,10,rect.width-30,rect.height-20))
        
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor(rgb: seperatorRGB).CGColor
        button.layer.borderWidth = 1
        
        button.setTitle("添加规格", forState: .Normal)
        button.setTitleColor(UIColor(rgb: mainRBG), forState: .Normal)
        button.addTarget(self, action: #selector(addSpecificationCell), forControlEvents: .TouchUpInside)
        
        
        view.addSubview(button)
    }
    
    func addSpecificationCell()
    {
        cellCount += 1
        let indexPath = NSIndexPath(forRow: cellCount-2, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        updateFrame()
        
    }
    
    
    
    func updateFrame(){
        
        let constrains = tableView.constraints
        let height = 140*CGFloat(cellCount-1)+64
        self.tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.width, height)
        
        for constraint in constrains {
            if constraint.firstAttribute == NSLayoutAttribute.Height {
                constraint.constant = height
            }
        }
        
        
        
        bottomView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y+height+15, tableView.frame.width, bottomView.frame.height)
        tableView.setNeedsDisplay()
        
    }
    
    
    // MARK -- CollectionViewCellDelegate
    
    func textViewDidEdit(text: String) {
        goods.titleDescription = text
    }
    
    
    func addCellButtonClicked() {
        
        self.imgpickerController.delegate = self
        
        self.imgpickerController.allowsEditing = true
        
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let alertController = UIAlertController(title: nil, message: "", preferredStyle: .ActionSheet)
            
            
            
            let cameraAction = UIAlertAction(title: "相机拍照", style: .Default, handler: { (action) in
                self.imgpickerController.sourceType = .Camera
                self.presentViewController(self.imgpickerController, animated: true, completion: nil)
            })
            
            alertController.addAction(cameraAction)
            
            
            let photoAction = UIAlertAction(title: "相册选取", style: .Default, handler: { (action) in
                self.imgpickerController.sourceType = .PhotoLibrary
                self.imgpickerController.navigationBar.barTintColor = UIColor(rgb: mainRBG)
                
                
                self.imgpickerController.navigationBar.tintColor = UIColor.whiteColor()
                self.imgpickerController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
                    NSFontAttributeName: UIFont(name: "Heiti SC", size: 24.0)!]
                self.presentViewController(self.imgpickerController, animated: true, completion: nil)
                
                
            })
            
            alertController.addAction(photoAction)
            
            
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            
        }else{
            let alertController = UIAlertController(title: nil, message: "", preferredStyle: .ActionSheet)
            
            
            let photoAction = UIAlertAction(title: "相册选取", style: .Default, handler: { (action) in
                self.imgpickerController.sourceType = .PhotoLibrary
                self.imgpickerController.navigationBar.barTintColor = UIColor(rgb: mainRBG)
                
                
                self.imgpickerController.navigationBar.tintColor = UIColor.whiteColor()
                
                self.presentViewController(self.imgpickerController, animated: true, completion: nil)
                
                
            })
            
            alertController.addAction(photoAction)
            
            
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func getContent(atIndexPath indexPath: NSIndexPath, specification: String, stockCount: NSNumber, price: String) {
        print("stockCount:\(stockCount),indexPath:\(indexPath.row)")
        let row = indexPath.row
        
        if specifications.count == row {
            let spe = Specification(descriptionTitle: specification, stockCount: stockCount , price: price)
            specifications.append(spe)
        }else{
            specifications[row].price = price
            specifications[row].stockCount = stockCount
            specifications[row].descriptionTitle = specification
        }
        
        
    }
    
    
    // MARK -- UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true , completion: nil)
        
        var img:UIImage!
        
        if picker.allowsEditing {
            img = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            img = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        
        let time = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM_dd_yyyy_h:mm:ss"
        let str = dateFormatter.stringFromDate(time)
        let newName = "img_\(str).png"
        self.saveImage(img, newSize: img.size, percent: 1, imgName: newName)
        
        let fullPath = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents/").stringByAppendingString("/\(newName)")
        print("homeD:\(NSHomeDirectory())::::\(fullPath)")
        
        
        
        let savedImage = UIImage(contentsOfFile: fullPath)
        
        uploadContentView.imgs.insert(savedImage!, atIndex: 1)
        
        uploadContentView.collectionView.reloadData()
        
        SVProgressHUD.setBackgroundColor(UIColor(colorLiteralRed: 0.5, green: 0.5, blue: 0.5, alpha: 0.3))
        SVProgressHUD.showWithStatus("图片上传中...")

        let url = BaseURL.stringByAppendingString("goods/uploadOne")
        let file = NSURL(fileURLWithPath:fullPath)
        Alamofire.upload(.POST,url, multipartFormData: { (multipartFormData) in
            
            multipartFormData.appendBodyPart(fileURL: file, name: "file")
        }) { (encodingResult) in
            switch encodingResult {
                
            case .Success(let upload,_,_):
                upload.response(completionHandler: { (request, response, json, error) in
                    
                    let str = NSString(data: json!, encoding: NSUTF8StringEncoding)
                   
                    print("response:\(request),str:\(str)")
                    self.imgs.append(str as! String)
                     SVProgressHUD.showSuccessWithStatus("上传成功")
                })
               
            case .Failure(let encodingError):
                print("faliure:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        }
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func saveImage(currentImage:UIImage,newSize:CGSize,percent:CGFloat,imgName:String)
    {
        //压缩图片尺寸
        UIGraphicsBeginImageContext(newSize)
        currentImage.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //高保真压缩图片质量
        //UIImageJPEGRepresentation此方法可将图片压缩，但是图片质量基本不变，第二个参数即图片质量参数。
        let imageData: NSData = UIImageJPEGRepresentation(newImage, percent)!
        // 获取沙盒目录,这里将图片放在沙盒的documents文件夹中
        let fullPath: String = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents/").stringByAppendingString("/\(imgName)")
        // 将图片写入文件
        imageData.writeToFile(fullPath, atomically: false)
    }
}
