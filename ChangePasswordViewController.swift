//
//  ChangePasswordViewController.swift
//
//
//  Created by 梁慧广 on 16/3/24.
//
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    var bgImageView: UIImageView?
    var bgImageView1: UIImageView?
    var passwordQueLabel: UILabel?
    var passwordQueLabel1: UILabel?
    var PasswordAwnLabel: UILabel?
    var PasswordAwnTextField: UITextField?
    var confirmButton: UIButton?
    var PageTitle: String?
    var lineImageView1: UIImageView?
    var rightBarButton: UIBarButtonItem?
    var question: String?
    var question1: NSString?
    var an1: NSString?
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths.first! as! String
        }()
    
    var db: COpaquePointer = nil
    var stmt: COpaquePointer = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("\(question)")
        self.navigationItem.title = "找回密码"
        rightBarButton = UIBarButtonItem(title: "修改密码", style: UIBarButtonItemStyle.Plain, target: self, action: "modifyPassword")
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        bgImageView?.image = UIImage(named: "10")
        self.view.addSubview(bgImageView!)
        
        bgImageView1 = UIImageView(frame: CGRect(x: 31, y: 112, width: 310, height: 310))
        bgImageView1?.image = UIImage(named: "注册1")
        bgImageView1?.layer.cornerRadius = 50
        self.view.addSubview(bgImageView1!)
        
        
        passwordQueLabel = UILabel(frame: CGRect(x: 50, y: 137, width: 120, height: 40))
        //passwordQueLabel?.backgroundColor = UIColor.greenColor()
        passwordQueLabel?.text = "(密码问题)："
        passwordQueLabel?.font = UIFont(name: "Arial", size: 20)
        passwordQueLabel?.textColor = UIColor.blackColor()
        self.view.addSubview(passwordQueLabel!)
        
        
        passwordQueLabel1 = UILabel(frame: CGRect(x: 39, y: 185, width: 293, height: 60))
        //passwordQueLabel1?.backgroundColor = UIColor.greenColor()
        passwordQueLabel1?.font = UIFont(name: "Arial", size: 20)
        passwordQueLabel1?.textColor = UIColor.blackColor()
        self.view.addSubview(passwordQueLabel1!)
        
        
        PasswordAwnLabel = UILabel(frame: CGRect(x: 39, y: 260, width: 100, height: 21))
        PasswordAwnLabel?.text = "保密答案："
        PasswordAwnLabel?.font = UIFont(name: "Arial", size: 20)
        PasswordAwnLabel?.textColor = UIColor.blackColor()
        self.view.addSubview(PasswordAwnLabel!)
        
        
        
        
        PasswordAwnTextField = UITextField(frame: CGRect(x: 128, y: 256, width: 190, height: 30))
        PasswordAwnTextField?.font = UIFont(name: "Arial", size: 20)
        PasswordAwnTextField?.textColor = UIColor.blackColor()
        //PasswordAwnTextField?.backgroundColor = UIColor.greenColor()
        PasswordAwnTextField?.addTarget(self, action: "passwordClick:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(PasswordAwnTextField!)
        
        
        
        lineImageView1 = UIImageView(frame: CGRect(x: 39, y: 300, width: 291, height: 1))
        lineImageView1?.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(lineImageView1!)
        
        
        
        confirmButton = UIButton(frame: CGRect(x: 140, y: 350, width: 92, height: 31))
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
        passwordQueLabel1?.text = findQuestion(question!) as String
        
        // Do any additional setup after loading the view.
    }
    func confirm()
    {
        if(PasswordAwnTextField?.text == findAn(question!) )
        {
            NSLog("正确")
        }
        else
        {
            NSLog("错误")
        }
    }
    
    func passwordClick(sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    
    func modifyPassword()
    {
        var VC2 = RecityPasswordViewController()
        VC2.ps = self.question
        self.navigationController?.pushViewController(VC2, animated: true)
    }
}



extension ChangePasswordViewController
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
    
    func findQuestion(name: String) ->NSString
    {
        NSLog("name\(name)")
        let string: NSString = "select userQuestion from UserMessage where userName = '\(name)' "
        let sql = string.UTF8String
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK
        {
            
            if sqlite3_step(stmt) == SQLITE_ROW
            {
                NSLog("123")
                let cname = sqlite3_column_text(stmt, 0)
                let sname = NSString(UTF8String: UnsafePointer(cname))
                NSLog("问题\(sname)")
                question1 = sname
                NSLog("问题1\(question1)")
            }
        }
        return question1!
        
        
    }
    func findAn(name: String) -> NSString
    {
        let string: NSString = "select userAnswer from UserMessage where userName = '\(name)' "
        let sql = string.UTF8String
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK
        {
            if sqlite3_step(stmt) == SQLITE_ROW
            {
                let cname = sqlite3_column_text(stmt, 0)
                let sname = NSString(UTF8String: UnsafePointer(cname))
                NSLog("答案\(sname)")
                an1 = sname!
                NSLog("答案1\(an1)")
            }
        }
        return an1!
        
    }
    
}