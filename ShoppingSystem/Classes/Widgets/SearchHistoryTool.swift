//
//  SearchHistoryTool.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/13.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

public class SearchHistoryTool: NSObject {

    private var historyModel:NSMutableArray = NSMutableArray()
    
    static var shareInstance:SearchHistoryTool {
        struct Static {
            static let instance:SearchHistoryTool = SearchHistoryTool()
        }
        return Static.instance
    }
    
    func insertElementToHistory(arr:NSString){
        historyModel = readHistory()
        
        var flag:Bool = true
        for i in 0..<historyModel.count {

        if arr == historyModel[i] as! NSString {
            flag = false
            historyModel.removeObject(historyModel[i])
            historyModel.insertObject(arr, atIndex: 0)
        }
        }
        if flag{
            historyModel.insertObject(arr, atIndex: 0)
        }
        
        for i in 0..<historyModel.count {
            if i >= 5 {
                historyModel.removeObjectsInRange(NSMakeRange(3, historyModel.count - i))
                break
            }
           
        }
        let array = NSArray(array: historyModel)
        saveHistory(array)
    }
    
    func deleteHistory(){
        let def = NSUserDefaults.standardUserDefaults()
        def.removeObjectForKey("SearchHistory")
        def.synchronize()
    }
    
    
   func saveHistory(array:NSArray){
        deleteHistory()
        let def = NSUserDefaults.standardUserDefaults()
        def.setObject(array, forKey: "SearchHistory")
        def.synchronize()
    }
    
    
  func readHistory()->NSMutableArray{
        let def = NSUserDefaults.standardUserDefaults()

    if let history = def.arrayForKey("SearchHistory") {
    
//        historyModel.removeAllObjects()
//        historyModel.addObjectsFromArray(history)
    
        return NSMutableArray(array: history)
    }else{
        return NSMutableArray()
    }
    }
}
