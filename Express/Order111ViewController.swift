//
//  Order111ViewController.swift
//  
//
//  Created by 梁慧广 on 16/5/11.
//
//

import UIKit

class Order111ViewController: UIViewController { //var array = ["1","2"]
    var scrol: UIScrollView?
    var i = 0
    var orderArray:NSMutableArray?
    var orderArray1:NSArray?
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths.first! as! String
        }()
    
    var db: COpaquePointer = nil
    var stmt: COpaquePointer = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderArray = NSUserDefaults.standardUserDefaults().valueForKey("OrderNumber") as? NSMutableArray
        orderArray1 = orderArray?.copy() as? NSArray
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "订单"
        var num = 180 * orderArray1!.count
        var num1 = 30 * orderArray1!.count
        scrol = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height:CGFloat(num)))
        scrol?.contentSize = CGSize(width: (self.view.bounds.width), height: CGFloat(num) + CGFloat(num1))
        createDatabase()
        createTable()
        self.view.addSubview(scrol!)
        
        let zjr = MyExpressView1.init(frame: CGRectMake(0, 0, self.view.bounds.width, 130),isAutoHeight: true) { (cur) -> (Void) in
            if(cur > 99)
            {
                self.navigationController?.pushViewController(StarViewController(), animated: true)
            }
            else
            {
                self.navigationController?.pushViewController(OrderViewController(), animated: true)
            }
            
        }
        scrol?.addSubview(zjr)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension Order111ViewController
{
    func createDatabase()
    {
        let path: NSString = "\(documentsPath)/MyEvaluateView.sqlite3"
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
        let string: NSString = "create table if not exists Evalution(id integer primary key autoincrement,UserName text,Score text,Detail text,Num text)"
        let sql = string.UTF8String
        if sqlite3_exec(db, sql, nil, nil, nil) != SQLITE_OK
            
        {
            
            NSLog("table fail")
            sqlite3_close(db)
        }
        
    }
    func insertAddress(Name: String,Score: String,Detail: String,Num: String)
    {
        let string: NSString = "insert into Evalution(Name,Score,Detail,Num) values(?,?,?,?)"
        let sql = string.UTF8String
        
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK
        {
            sqlite3_close(db)
            NSLog("\(Name),insert fail")
            
        }
        
        let name1 = (Name as NSString).UTF8String
        let score = (Score as NSString).UTF8String
        let detail = (Detail as NSString).UTF8String
        let num = (Num as NSString).UTF8String
        
        sqlite3_bind_text(stmt, 1, name1, -1, nil)
        sqlite3_bind_text(stmt, 2, score, -1, nil)
        sqlite3_bind_text(stmt, 3, detail, -1, nil)
        sqlite3_bind_text(stmt, 4, num, -1, nil)
        
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
