//
//  CartDBTool.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/31.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

//    CartDBTool.shareInstance.executeSQL("delete from T_Cart where goodsId=\(goodsId) and specId=\(specId)")



//            CartDBTool.shareInstance.recordSet("Cart.db",sql: "select * from T_Cart",callBack: { (array) in
//                print("arrayAll:\(array[0])")
//            })

class CartDBTool: NSObject {
    
    
    var dbTool:SQLiteTool = SQLiteTool.shareInstance
    
    static let shareInstance:CartDBTool = CartDBTool()
    
    private override init(){
        dbTool = SQLiteTool.shareInstance
    }
    
    
    
    
    func createTable(dbName:String)->Bool {
        
        if !dbTool.openDB(dbName) {
            return false
        }
        
        let sql = "CREATE TABLE  IF NOT EXISTS T_Cart(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,num INTEGER NOT NULL,totalPrice Double(45) , goodsId INTEGER NOT NULL ,specId INTEGER NOT NULL);"
        
      return dbTool.createTable(dbName,sql: sql)
        
    }
    
    
    func executeSQL(sql:String)->Bool{
        return dbTool.executeSQL(sql)
    }
    
    
    func insertTable(dbName:String,sql:String)->Bool {
        if dbTool.openDB(dbName) {
           
         return dbTool.insertTable(dbName,sql:sql)
            
        }
        
        return false
    }
    
    
    func recordSet(dbName:String,sql:String,callBack:(NSMutableArray)->()) {
        
        if !dbTool.openDB(dbName) {
            return
        }
        var list:NSMutableArray = NSMutableArray()
        
        dbTool.recordSet(dbName,sql:sql,callBack:{(stmts) in
            
           list = stmts
            
        }, mathFunction:self.recordData)
        callBack(list)
    }
    
    
    
    func recordData(stmt:COpaquePointer,callBack:(CartItem)->()){
        
        let id = Int(sqlite3_column_int(stmt,0))
        
        let num = NSNumber(int: sqlite3_column_int(stmt,1))
        let totalPrice = String(sqlite3_column_double(stmt,2))
        let goodsId = Int(sqlite3_column_int(stmt,3))
        let specId = Int(sqlite3_column_int(stmt,4))
        
//        print("item333:::\(totalPrice)")

        let item = CartItem(num:num,id:id,specId:specId,goodsId:goodsId,totalPrice:(totalPrice))
//        print("item:::\(Double(totalPrice)):::\(item.description)")
        callBack(item)
        
        
    }
    
    func recordDataItem(stmt:COpaquePointer) {
        let count = sqlite3_column_count(stmt)
        
        for i in 0 ..< count {
            
            let type = sqlite3_column_type (stmt,i)
            
            switch type {
            case SQLITE_INTEGER:
                print("整数 \(i)\(sqlite3_column_int64(stmt, i))")
            case SQLITE_FLOAT:
                print("小树 \(sqlite3_column_double(stmt, i))")
            case SQLITE_NULL:
                print("空 \(NSNull())")
            case SQLITE_TEXT:
                let chars = UnsafePointer<CChar>(sqlite3_column_text(stmt, i))
                let str = String(CString: chars, encoding: NSUTF8StringEncoding)!
                print("字符串 \(str)")
            case let type:
                print("不支持的类型 \(type)")
            }
            
        }
        
    }


}
