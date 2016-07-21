//
//  PublishViewController.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/20.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

class PublishViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var topContentView: TitleView!
    @IBOutlet weak var uploadContentView: UploadContentView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
        
        congfigView()
    }

    func congfigView()
    {
         uploadContentView.setframe(uploadContentView.frame)
         topContentView.setframe(topContentView.frame)
        
        
        topContentView.layer.cornerRadius = 10
        topContentView.clipsToBounds = true
        
        uploadContentView.layer.cornerRadius = 10
        uploadContentView.clipsToBounds = true
        
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
