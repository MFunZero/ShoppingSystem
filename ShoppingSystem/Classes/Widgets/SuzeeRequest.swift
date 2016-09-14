//
//  SuzeePatch.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/23.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit
import Alamofire




public class SuzeeRequest: NSObject {
   
    static let shareInstance:SuzeeRequest = SuzeeRequest()
    
    private override init() {}
    
    
    func request(tagString:String,url:String,callback:(Bool,AnyObject?)->()){
        
        Alamofire.request(.GET, url)
            .responseJSON { (response) in
                let result = response.result
                switch result{
                case .Failure(let err):
                    print("Failed get\(tagString):\(err)")
                    callback(false,nil)

                case .Success(let value):
                    print("Success get\(tagString):\(value)")
                    
                    callback(true,result.value)
                }
        }

    }
    
    func request(tagString:String,url:String,param:[String : AnyObject]?,callback:(Bool,AnyObject?)->()){
        Alamofire.request(.GET, url, parameters: param)
            .responseJSON { (response) in
                let result = response.result
                switch result{
                case .Failure(let err):
                    print("Failed get\(tagString):\(err)")
                    callback(false,nil)
                    
                case .Success(let value):
                    print("Success get\(tagString):\(value)")
                    
                    callback(true,result.value)
                }
        }
        
    }
    
    
}
