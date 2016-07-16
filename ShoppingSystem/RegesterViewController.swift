//
//  RegesterViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/15.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit
import Alamofire


class RegesterViewController: UIViewController {

    @IBOutlet weak var regesterButton: UIButton!
    
    @IBOutlet weak var mailAddressTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var pwdAgainTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configView()
        // Do any additional setup after loading the view.
    }
    
    
    func configView()
    {
        regesterButton.layer.cornerRadius = 5
        regesterButton.layer.borderColor = UIColor.whiteColor().CGColor
        regesterButton.layer.borderWidth = 1
        
        
        mailAddressTextField.layer.cornerRadius = 5
        mailAddressTextField.layer.borderColor = UIColor(rgb: 0x3EDBB8).CGColor
        mailAddressTextField.layer.borderWidth = 1
        pwdTextField.layer.cornerRadius = 5
        pwdTextField.layer.borderColor = UIColor(rgb: 0x3EDBB8).CGColor
        pwdTextField.layer.borderWidth = 1
        pwdTextField.secureTextEntry = true
        
        
        pwdAgainTextField.layer.cornerRadius = 5
        pwdAgainTextField.layer.borderColor = UIColor(rgb: 0x3EDBB8).CGColor
        pwdAgainTextField.layer.borderWidth = 1
        pwdAgainTextField.secureTextEntry = true

        
        
//        let waterView = WaterWaveView(frame: CGRectMake(0,bgView.frame.height*4/5,bgView.frame.width,bgView.frame.height))
//        self.bgView.addSubview(waterView)
        
        //    waterView.layer.addSublayer(shadowAsInverse(CGRectMake(0,250,screenW,screenH-250)))
        
   
    }


    @IBAction func regesterButtonClicked(sender: AnyObject) {
        addWaterAnimationForView(regesterButton)
        
        if mailAddressTextField.text == "" {
            shakeAnimationForView(mailAddressTextField)
            mailAddressTextField.becomeFirstResponder()
            return
        }
        
        if pwdTextField.text == "" {
            shakeAnimationForView(pwdTextField)
            pwdTextField.becomeFirstResponder()
            return
        }
        
        if pwdAgainTextField.text == "" {
            shakeAnimationForView(pwdAgainTextField)
            pwdAgainTextField.becomeFirstResponder()
            return
        }
        if pwdAgainTextField.text != pwdTextField.text {
            shakeAnimationForView(pwdAgainTextField)
            pwdAgainTextField.becomeFirstResponder()
            return
        }
        
        let username = mailAddressTextField.text! as String
        let pwd = pwdTextField.text! as String
        let prefixURL = "user/regester?".stringByAppendingString("nickname=\(username)&pwd=\(pwd)")
        let url = BaseURL.stringByAppendingString(prefixURL)
        
        Alamofire.request(.GET,url).responseJSON() {
            
            (data)in
            
            let result = data.result
            
            switch (result) {
                
            case .Failure:
                
                print("Error to Regester:\(result.error)")
                
            case .Success:
                print("Success to Regester:\(data)")
                
                NSNotificationCenter.defaultCenter().postNotificationName("LoginSuccess", object: nil, userInfo: nil)
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
            
            
            
        }

    }
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
