//
//  LoginControllerViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/14.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit
import Alamofire


class LoginControllerViewController: UIViewController {
    
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var mailAddressTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var bgView: UIView!
    
    var RippleLayer:CALayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
    }
    
    func configView()
    {
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        loginButton.layer.borderWidth = 1
        
       
        mailAddressTextfield.layer.cornerRadius = 5
        mailAddressTextfield.layer.borderColor = UIColor(rgb: 0x3EDBB8).CGColor
        mailAddressTextfield.layer.borderWidth = 1
        passwordTextfield.layer.cornerRadius = 5
        passwordTextfield.layer.borderColor = UIColor(rgb: 0x3EDBB8).CGColor
        passwordTextfield.layer.borderWidth = 1
        passwordTextfield.secureTextEntry = true

        
        let waterView = WaterWaveView(frame: CGRectMake(0,bgView.frame.height*3/4,bgView.frame.width,bgView.frame.height))
//        self.bgView.addSubview(waterView)
        
//    waterView.layer.addSublayer(shadowAsInverse(CGRectMake(0,250,screenW,screenH-250)))
    
        
        RippleLayer.frame = CGRect(x: (screenW-40)/2-loginButton.frame.height/2, y: 0, width: loginButton.frame.height, height: (loginButton.frame.height))
        RippleLayer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3).CGColor
        RippleLayer.cornerRadius = loginButton.frame.height/2;
        RippleLayer.masksToBounds=true;
        RippleLayer.opacity = 0
        self.loginButton.layer.masksToBounds = true
    }
    
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
 
    @IBAction func loginButtonClicked(sender: AnyObject) {
//        
//        buttonBGChange()
//        

        if mailAddressTextfield.text == "" {
            shakeAnimationForView(mailAddressTextfield)
            mailAddressTextfield.becomeFirstResponder()
            return
        }
        
        if passwordTextfield.text == "" {
            shakeAnimationForView(passwordTextfield)
            passwordTextfield.becomeFirstResponder()
            return
        }
        
        addWaterAnimationForView(loginButton)

        
        let username = mailAddressTextfield.text! as String
        let pwd = passwordTextfield.text! as String
        
        
        
        
        let prefixURL = "user/login?".stringByAppendingString("nickname=\(username)&pwd=\(pwd)")
        let url = BaseURL.stringByAppendingString(prefixURL)
        
//        
//        Alamofire.request(.GET,url).responseJSON() {
//            
//            (data)in
//            
//           let result = data.result
//            
//            switch (result) {
//                
//            case .Failure:
//                
//                print("Error to Login:\(result.error)")
//
//            case .Success:
//                print("Success to Login:\(data)")
        
        
        
//          
        
        
        let delta:UInt64 = 2;
        let time:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,Int64( NSEC_PER_SEC*delta))
        dispatch_after(time, dispatch_get_global_queue(0, 0)) {
            NSNotificationCenter.defaultCenter().postNotificationName("LoginSuccess", object: nil, userInfo: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        

//            }
//        
//            
//            
//        }
//        
        
        
    }
    
    func buttonBGChange()
    {
        

        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.0

        
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
      
        scaleAnimation.fromValue = 0.1
        scaleAnimation.toValue = 10.0
        scaleAnimation.duration = 1.0
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
  
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1.0
        animationGroup.autoreverses = false
        animationGroup.animations = NSArray(objects: animation,scaleAnimation) as? [CAAnimation]
        self.RippleLayer.addAnimation(animationGroup, forKey: "animationGroup")
        self.loginButton.layer.addSublayer(self.RippleLayer)
        
      
        
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
    
}
