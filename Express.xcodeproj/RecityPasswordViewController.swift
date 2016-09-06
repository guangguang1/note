//
//  RecityPasswordViewController.swift
//
//
//  Created by 梁慧广 on 16/3/24.
//
//

import UIKit

class RecityPasswordViewController: UIViewController {
    
    var bgImageView: UIImageView?
    var bgImageView1: UIImageView?
    var passwordLabel: UILabel?
    var newPasswordLabel: UILabel?
    var passwordTextField: UITextField?
    var newPasswordTextField: UITextField?
    var confirmButton: UIButton?
    var PageTitle: String?
    var lineImageView1: UIImageView?
    var lineImageView2: UIImageView?
    var ps: String?
    var password1: NSString?
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths.first! as! String
        }()
    
    var db: COpaquePointer = nil
    var stmt: COpaquePointer = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "修改密码"
        
        NSLog("\(ps)")
        bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        bgImageView?.image = UIImage(named: "10")
        self.view.addSubview(bgImageView!)
        bgImageView1 = UIImageView(frame: CGRect(x: 31, y: 112, width: 310, height: 310))
        bgImageView1?.image = UIImage(named: "注册1")
        bgImageView1?.layer.cornerRadius = 50
        self.view.addSubview(bgImageView1!)
        
        passwordLabel = UILabel(frame: CGRect(x: 39, y: 157, width: 83, height: 21))
        passwordLabel?.text = "原密码："
        passwordLabel?.font = UIFont(name: "Arial", size: 20)
        passwordLabel?.textColor = UIColor.blackColor()
        self.view.addSubview(passwordLabel!)
        
        newPasswordLabel = UILabel(frame: CGRect(x: 42, y: 230, width: 80, height: 21))
        newPasswordLabel?.text = "新密码："
        newPasswordLabel?.font = UIFont(name: "Arial", size: 20)
        newPasswordLabel?.textColor = UIColor.blackColor()
        self.view.addSubview(newPasswordLabel!)
        
        passwordTextField = UITextField(frame: CGRect(x: 112, y: 153, width: 213, height: 30))
        self.view.addSubview(passwordTextField!)
        passwordTextField?.addTarget(self, action: "nameClick:", forControlEvents: UIControlEvents.TouchDown)
        
        newPasswordTextField = UITextField(frame: CGRect(x: 112, y: 226, width: 213, height: 30))
        self.view.addSubview(newPasswordTextField!)
        newPasswordTextField?.addTarget(self, action: "passwordClick:", forControlEvents: UIControlEvents.TouchDown)
        
        lineImageView1 = UIImageView(frame: CGRect(x: 39, y: 186, width: 286, height: 1))
        lineImageView2 = UIImageView(frame: CGRect(x: 39, y: 259, width: 286, height: 1))
        lineImageView1?.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        lineImageView2?.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        self.view.addSubview(lineImageView1!)
        self.view.addSubview(lineImageView2!)
        confirmButton = UIButton(frame: CGRect(x: 140, y: 318, width: 92, height: 31))
        confirmButton?.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
        confirmButton?.setTitle("确认", forState: UIControlState.Normal)
        confirmButton?.addTarget(self, action: "confirm", forControlEvents: UIControlEvents.TouchUpInside)
        confirmButton?.titleLabel?.font = UIFont(name: "Arial", size: 19)
        confirmButton?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        confirmButton?.layer.cornerRadius = 10
        confirmButton?.layer.borderWidth = 1
        confirmButton?.layer.masksToBounds = true
        confirmButton?.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.view.addSubview(confirmButton!)
        
        createDatabase()
        createTable()
        // Do any additional setup after loading the view.
    }
    func confirm()
    {
        if(passwordTextField?.text == findPassword(ps!))
        {
            if(newPasswordTextField?.text == findPassword(ps!))
            {
                NSLog("两次密码一样，请重新输入")
            }
            else
            {
                updateStudents(ps!, password: (newPasswordTextField?.text)!)
                NSLog("\(newPasswordTextField?.text),\(ps)")
                queryStudents(ps!)
                NSLog("修改成功")
            }
        }
        else
        {
            NSLog("两次输入密码不一致")
        }
    }
    func nameClick(sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    func passwordClick(sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



extension RecityPasswordViewController
{
    func createDatabase()
    {
        let path: NSString = "\(documentsPath)/ExpressUserMessage1.sqlite3"
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
        let string: NSString = "create table if not exists UserMessage(id integer primary key autoincrement,userName text,userPassword text,userQuestion text,userAnswer text)"
        let sql = string.UTF8String
        if sqlite3_exec(db, sql, nil, nil, nil) != SQLITE_OK
            
        {
            
            NSLog("table fail")
            sqlite3_close(db)
        }
    }
    
    func findPassword(name: String) -> NSString
    {
        let string: NSString = "select userPassword from UserMessage where userName = '\(name)' "
        let sql = string.UTF8String
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK
        {
            if sqlite3_step(stmt) == SQLITE_ROW
            {
                let cname = sqlite3_column_text(stmt, 0)
                let sname = NSString(UTF8String: UnsafePointer(cname))
                NSLog("密码\(sname)")
                password1 = sname
                NSLog("密码1\(password1)")
            }
        }
        return password1!
        
    }
    
    
    
    func updateStudents(name:String,password:String)
    {
        let string: NSString = "update UserMessage set 'userPassword' = '\(password)' where 'userName' = '\(name)'"
        let sql = string.UTF8String
        if sqlite3_exec(db, sql , nil, nil, nil) == SQLITE_OK
        {
            
            NSLog("right")
        }
        else
        {
            sqlite3_close(db)
            NSLog("update fail")
        }

    }
    
    func queryStudents(name:String)
    {
        
        let string: NSString = "select userPassword from UserMessage where userName = '\(name)'"
        let sql = string.UTF8String
        //解析sql文本语句
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK
        {
            NSLog("123")
            while sqlite3_step(stmt) == SQLITE_ROW
            {
                
                let cname = sqlite3_column_text(stmt, 0)
                let sname = NSString(UTF8String: UnsafePointer(cname))
                NSLog("新密码\(sname)")
                
            }
        }
        else
        {
            NSLog("fail")
        }
        
        sqlite3_finalize(stmt)
    }
    
    
    
    //    func insertNewPassword(name: String,passowrd: String)
    //    {
    //        let string: NSString = "update UserMessage set userPassword = '\(passowrd)' where userName = '\(name)'"
    //        let sql = string.UTF8String
    //        NSLog("\(name),\(passowrd)")
    //        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK
    //        {
    //            let password1 = (passowrd as NSString).UTF8String
    //            NSLog("password1,\(password1)")
    //            sqlite3_bind_text(stmt, 1, password1, -1, nil)
    //            NSLog("ok")
    //        }
    //
    //        if sqlite3_step(stmt) == SQLITE_ERROR
    //        {
    //            NSLog("插入失败")
    //            sqlite3_close(db)
    //            NSLog("\(name),insert fail")
    //
    //        }
    //        else
    //        {
    //            NSLog("\(name),\(password1)")
    //            sqlite3_finalize(stmt)
    //        }
    //
    //
    //
    //
    //    }
    //
    //查询学生数据
    func queryStudents()
    {
        let string: NSString = "select * from UserMessage"
        let sql = string.UTF8String
        
        //解析sql文本语句
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK
        {
            sqlite3_close(db)
            NSLog("query fail")
            return
        }
        
        //执行sql语句
        
        while sqlite3_step(stmt) == SQLITE_ROW
        {
            let csno = sqlite3_column_text(stmt, 0)
            let sno = NSString(UTF8String: UnsafePointer(csno))
            let cname = sqlite3_column_text(stmt, 1)
            let sname = NSString(UTF8String: UnsafePointer(cname))
            let csno1 = sqlite3_column_text(stmt, 2)
            let sno1 = NSString(UTF8String: UnsafePointer(csno1))
            let cname2 = sqlite3_column_text(stmt, 3)
            let sname2 = NSString(UTF8String: UnsafePointer(cname2))
            let cname3 = sqlite3_column_text(stmt, 3)
            let sname3 = NSString(UTF8String: UnsafePointer(cname3))
            NSLog("123\(sno),\(sname),\(sno1),\(sname2),\(sname3)")
            //print("\(sno),\(sname),\(score)")
        }
        
        //释放资源
        
        sqlite3_finalize(stmt)
    }
    
    
}
