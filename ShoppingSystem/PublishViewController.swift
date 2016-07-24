//
//  PublishViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/20.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit


private let SpecificationTableCellIdentifier="SpecificationTableViewCell"

class PublishViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,SpecificationTableViewDelegate,CollectionViewCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
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
    
    var imgs:[UIImage] = [UIImage]()
    
    var imgpickerController:UIImagePickerController = UIImagePickerController()
    
    var cellCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
        
        congfigView()
    }

    func congfigView()
    {
         uploadContentView.setframe(uploadContentView.frame)
        
        uploadContentView.delegate = self
        
         topContentView.setframe(topContentView.frame)
        
        
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
    
    @IBAction func serviceButtonClicked(sender: AnyObject) {
        
        grayView.frame = self.view.frame
        grayView.backgroundColor = UIColor.blackColor()
        grayView.alpha = 0.3
        self.navigationController?.view.addSubview(grayView)
        
        confirmView = NSBundle.mainBundle().loadNibNamed("ServiceConfimView", owner: self, options: nil).last as? ServiceConfimView
        
        confirmView?.frame = CGRectMake(screenW*0.05, screenH/2-screenW*0.3, screenW*0.9, screenW*0.6)
        self.navigationController?.view.addSubview(confirmView!)
        
        confirmView?.layer.cornerRadius = 10
        confirmView?.clipsToBounds = true
        confirmView?.titles.appendContentsOf(service)
        confirmView?.pickerView.reloadAllComponents()
        
    }
    @IBAction func expressAddressButtonClicked(sender: AnyObject) {
        
        
        
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
        self.imgs = imgs
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
    
        let fullPath = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents/").stringByAppendingString(newName)
        print("homeD:\(NSHomeDirectory())::::\(fullPath)")
        
        
        
        let savedImage = UIImage(contentsOfFile: fullPath)
        
        imgs.insert(savedImage!, atIndex: 0)
        uploadContentView.imgs.insert(savedImage!, atIndex: 0)
        
        uploadContentView.collectionView.reloadData()
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
                 let fullPath: String = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents/").stringByAppendingString(imgName)
                 // 将图片写入文件
                 imageData.writeToFile(fullPath, atomically: false)
    }
}
