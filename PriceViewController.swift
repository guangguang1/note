//
//  PriceViewController.swift
//  
//
//  Created by 梁慧广 on 16/4/14.
//
//

import UIKit

class PriceViewController: UIViewController {

    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths.first! as! String
        }()
    
    var db: COpaquePointer = nil
    var stmt: COpaquePointer = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        createDatabase()
        createTable()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension PriceViewController
{
    func createDatabase()
    {
        let path: NSString = "\(documentsPath)/Price.sqlite3"
        let filename = path.UTF8String
        NSLog("\(path)")
        if sqlite3_open(filename, &db) != SQLITE_OK
        {
            NSLog("database fail")
            sqlite3_close(db)
        }
    }
    func  createTable()
    {
        let string: NSString = "create table if not exists Price(id integer primary key autoincrement,CopName text,addName1 text,addName2 text,price int)"
        let sql = string.UTF8String
        if sqlite3_exec(db, sql, nil, nil, nil) != SQLITE_OK
            
        {
            
            NSLog("table fail")
            sqlite3_close(db)
        }
        
    }
    func insertAddress(CopName: String,addName1: String,addName2: String,price:Double)
    {
        let string: NSString = "insert into Price(CopName,addName1,addName2,price) values(?,?,?,?,)"
        let sql = string.UTF8String
        
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK
        {
            sqlite3_close(db)
            NSLog("\(CopName),insert fail")
            
        }
        
        let name1 = (CopName as NSString).UTF8String
        let addName1 = (addName1 as NSString).UTF8String
        let addName2 = (addName2 as NSString).UTF8String
        let price = price as Double

        
        sqlite3_bind_text(stmt, 1, name1, -1, nil)
        sqlite3_bind_text(stmt, 2, addName1, -1, nil)
        sqlite3_bind_text(stmt, 3, addName2, -1, nil)
        sqlite3_bind_double(stmt, 4, price)

        
        if sqlite3_step(stmt) == SQLITE_ERROR
        {
            NSLog("插入失败")
            sqlite3_close(db)
            NSLog("\(name1),insert fail")
            
        }
        else
        {
            NSLog("\(name1)")
            sqlite3_finalize(stmt)
        }
}

}