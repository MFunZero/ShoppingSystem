//
//  SQLiteTool.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/8/31.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

private let dbTool = SQLiteTool()


class SQLiteTool: NSObject {

    var db:COpaquePointer = nil
    

    
    static var shareInstance:SQLiteTool {
        return dbTool
    }
    
    private override init(){
        
    }
    
    func openDB(dbName:String)->Bool{
        
        let path = NSHomeDirectory().stringByAppendingString("/Documents/\(dbName)")
        
        NSLog("dbPath:",path)
        
        if sqlite3_open(path,&db) == SQLITE_OK {
            
            print("sqlite3_open successfule")
            
            return true
        }
        print("sqlite3_open failed")
        return false
    }
    
    
    func createTable(dbName:String,sql:String)->Bool {
        
        if !self.openDB(dbName) {
            return false
        }
        
        
        var stmt:COpaquePointer = nil
        
        let sqlReturn = sqlite3_prepare_v2(db, sql, -1, &stmt, nil)
        
        if sqlReturn != SQLITE_OK {
            print("createTable failed")
            return false
        }
        
        let success = sqlite3_step(stmt)
        
        sqlite3_finalize(stmt)
        
        if success != SQLITE_DONE {
            return false
        }
        print("createTable success")
        return true
        
    }
    
    
    func executeSQL(sql:String)->Bool{
        return sqlite3_exec(db,sql.cStringUsingEncoding(NSUTF8StringEncoding)!,nil,nil,nil) == SQLITE_OK
    }
    
    
    func insertTable(dbName:String,sql:String)->Bool {
        if self.openDB(dbName) {
            var stmt:COpaquePointer = nil
            
            if sqlite3_prepare_v2(db,sql.cStringUsingEncoding(NSUTF8StringEncoding)!,-1,&stmt,nil) == SQLITE_OK{
                
                
                let suc = sqlite3_step(stmt)
                
                
                sqlite3_finalize(stmt)
                
                sqlite3_close(db)
                
                if suc == SQLITE_ERROR {
                    return false
                }
                else{
                    return true
                }
                
                
            }
            else {
                if let error = String.fromCString(sqlite3_errmsg(self.db)) {
                    let msg = "SQLiteDB - failed to prepare SQL: \(sql), Error: \(error)"
                    print(msg)
                }
                sqlite3_finalize(stmt)
                sqlite3_close(db)
                return false
            }
            
        }
        
        return false
    }
    
    
    func recordSet(dbName:String,sql:String,callBack:(NSMutableArray)->(),mathFunction: (COpaquePointer, callBack:(AnyObject)->())->()) {
        
        if !self.openDB(dbName) {
            return
        }
        var list:NSMutableArray = NSMutableArray()
        
        var stmt:COpaquePointer = nil
        
        if sqlite3_prepare_v2(db,sql.cStringUsingEncoding(NSUTF8StringEncoding)!,-1 ,&stmt,nil) == SQLITE_OK {
            
            
            while sqlite3_step(stmt) == SQLITE_ROW {
                var pointer:COpaquePointer = stmt
                
                mathFunction(stmt,callBack: {(obj) in
                    list.addObject(obj)
                })
                
            }
            
        }
        
        closeDB(stmt)
        
        callBack(list)
    }
    
    func closeDB(stmt:COpaquePointer) {
        sqlite3_finalize(stmt)
        sqlite3_close (db)
    }
    
    func recordData(stmt:COpaquePointer,callBack:(CartItem)->()){
        
        let id = Int(sqlite3_column_int(stmt,0))
        
        let num = NSNumber(int: sqlite3_column_int(stmt,1))
        let totalPrice = String(sqlite3_column_double(stmt,2))
        let goodsId = Int(sqlite3_column_int(stmt,3))
        let specId = Int(sqlite3_column_int(stmt,4))
        
        let item = CartItem(num:num,id:id,specId:specId,goodsId:goodsId,totalPrice:totalPrice)
        callBack(item)
        
        
    }
    
    func recordData(stmt:COpaquePointer) {
        let count = sqlite3_column_count(stmt)
        
        for i in 0 ..< count {
            
            let type = sqlite3_column_type (stmt,i)
            
            switch type {
            case SQLITE_INTEGER:
                print("整数 \(sqlite3_column_int64(stmt, i))")
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
