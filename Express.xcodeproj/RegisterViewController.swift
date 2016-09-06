//
//  RegisterViewController.swift
//
//
//  Created by 梁慧广 on 16/3/31.
//
//

import UIKit

class RegisterViewController: UIViewController,UITextFieldDelegate {
    
    var bgImageView: UIImageView?
    var bgImageView1: UIImageView?
    var nameLabel: UILabel?
    var passwordLabel: UILabel?
    var passwordQueLabel: UILabel?
    var passwordAmsLabel: UILabel?
    var nameTextField: UITextField?
    var passwordTextField: UITextField?
    var passwordQueTextField: UITextField?
    var passwordAmsTextField: UITextField?
    var confirmButton: UIButton?
    var PageTitle: String?
    var lineImageView1: UIImageView?
    var lineImageView2: UIImageView?
    var lineImageView3: UIImageView?
    var lineImageView4: UIImageView?
    var touxiangImageView: UIImageView?
    var touxiangButton: UIButton?
    var namerepeat: NSString?
    var alert = UIAlertView()
    var alert1 = UIAlertView()
    var alert2 = UIAlertView()
    var passwordTrue: NSString?
    var view1: TheView?
    var textfield: UITextField?
    
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths.first! as! String
        }()
    
    var db: COpaquePointer = nil
    var stmt: COpaquePointer = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "注册"
        
        bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        bgImageView?.image = UIImage(named: "10")
        self.view.addSubview(bgImageView!)
        
        bgImageView1 = UIImageView(frame: CGRect(x: 21, y: 102, width: 335, height: 424))
        bgImageView1?.image = UIImage(named: "注册1")
        bgImageView1?.layer.cornerRadius = 5
        self.view.addSubview(bgImageView1!)
        
        
        nameLabel = UILabel(frame: CGRect(x: 39, y: 147, width: 100, height: 21))
        nameLabel?.text = "用 户  名："
        nameLabel?.font = UIFont(name: "Arial", size: 20)
        nameLabel?.textColor = UIColor.blackColor()
        self.view.addSubview(nameLabel!)
        
        
        passwordLabel = UILabel(frame: CGRect(x: 42, y: 220, width: 100, height: 21))
        passwordLabel?.text = "密      码："
        passwordLabel?.font = UIFont(name: "Arial", size: 20)
        passwordLabel?.textColor = UIColor.blackColor()
        self.view.addSubview(passwordLabel!)
        
        
        passwordQueLabel = UILabel(frame: CGRect(x: 39, y: 293, width: 100, height: 21))
        passwordQueLabel?.text = "保密问题："
        passwordQueLabel?.font = UIFont(name: "Arial", size: 20)
        passwordQueLabel?.textColor = UIColor.blackColor()
        self.view.addSubview(passwordQueLabel!)
        
        
        passwordAmsLabel = UILabel(frame: CGRect(x: 42, y: 366, width: 100, height: 21))
        passwordAmsLabel?.text = "保密答案："
        passwordAmsLabel?.font = UIFont(name: "Arial", size: 20)
        passwordAmsLabel?.textColor = UIColor.blackColor()
        self.view.addSubview(passwordAmsLabel!)
        
        nameTextField = UITextField(frame: CGRect(x: 125, y: 145, width: 213, height: 30))
        self.view.addSubview(nameTextField!)
        nameTextField?.addTarget(self, action: "nameClick:", forControlEvents: UIControlEvents.TouchDown)
        
        passwordTextField = UITextField(frame: CGRect(x: 125, y: 216, width: 213, height: 30))
        self.view.addSubview(passwordTextField!)
        passwordTextField?.addTarget(self, action: "passwordClick:", forControlEvents: UIControlEvents.TouchDown)
        //        passwordTextField?.backgroundColor = UIColor.blackColor()
        passwordQueTextField = UITextField(frame: CGRect(x: 125, y: 291, width: 213, height: 30))
        self.view.addSubview(passwordQueTextField!)
        passwordQueTextField?.addTarget(self, action: "passwordQueClick:", forControlEvents: UIControlEvents.TouchDown)
        //        passwordQueTextField?.backgroundColor = UIColor.blackColor()
        passwordAmsTextField = UITextField(frame: CGRect(x: 125, y: 365, width: 213, height: 30))
        self.view.addSubview(passwordAmsTextField!)
        //        passwordAmsTextField?.backgroundColor = UIColor.blackColor()
        passwordAmsTextField?.addTarget(self, action: "passwordAmsClick:", forControlEvents: UIControlEvents.TouchDown)
        
        lineImageView1 = UIImageView(frame: CGRect(x: 39, y: 176, width: 286, height: 1))
        lineImageView2 = UIImageView(frame: CGRect(x: 39, y: 249, width: 286, height: 1))
        lineImageView1?.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        lineImageView2?.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        self.view.addSubview(lineImageView1!)
        self.view.addSubview(lineImageView2!)
        lineImageView3 = UIImageView(frame: CGRect(x: 39, y: 322, width: 286, height: 1))
        lineImageView4 = UIImageView(frame: CGRect(x: 39, y: 395, width: 286, height: 1))
        lineImageView3?.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        lineImageView4?.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        self.view.addSubview(lineImageView3!)
        self.view.addSubview(lineImageView4!)
        
        
        confirmButton = UIButton(frame: CGRect(x: 155, y: 460, width: 92, height: 31))
        confirmButton?.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
        confirmButton?.setTitle("确认", forState: UIControlState.Normal)
        confirmButton?.titleLabel?.font = UIFont(name: "Arial", size: 19)
        confirmButton?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        confirmButton?.addTarget(self, action: "resgister", forControlEvents: UIControlEvents.TouchUpInside)
        confirmButton?.layer.cornerRadius = 10
        confirmButton?.layer.borderWidth = 1
        confirmButton?.layer.masksToBounds = true
        confirmButton?.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.view.addSubview(confirmButton!)
        
        view1 = TheView(frame: CGRect(x: 170, y: 410, width: 100, height: 30))
        self.view.addSubview(view1!)
        
        textfield = UITextField(frame: CGRect(x: 39, y: 410, width: 120, height: 30))
        textfield?.placeholder = "请输入验证码"
        textfield?.addTarget(self, action: "textfieldClick:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(textfield!)
        textfield?.delegate = self
        createDatabase()
        createTable()
        
        
        // Do any additional setup after loading the view.
    }
    
    func textfieldClick(sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    func nameClick(sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    func passwordClick(sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    func passwordQueClick(sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    func passwordAmsClick(sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        var frame:CGRect = textField.frame
        var offset = frame.origin.y + 100 - (self.view.bounds.height - 216.0)
        NSLog("offset\(offset)")
        var animationDuration:NSTimeInterval = 0.3
        UIView.beginAnimations("ResizeForkeyboard", context: nil)
        UIView.setAnimationDuration(animationDuration)
        if(offset > 0)
        {
            self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height)
            
        }
        UIView.commitAnimations()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.view.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
    }
    
    func resgister()
    {
        
        let text1 = nameTextField?.text
        let text2 = passwordTextField?.text
        let text3 = passwordQueTextField?.text
        let text4 = passwordAmsTextField?.text
        
        nameSame()
        NSLog("\(nameSame())")
        if(nameSame() == 1)
        {
            alert.title = "提示"
            alert.message = "您的用户名已经被使用，请重新输入。"
            //alert.addButtonWithTitle("取消")
            alert.addButtonWithTitle("确定")
            //alert.cancelButtonIndex = 0
            alert.delegate = self
            alert.show()
            NSLog("您的用户名已经被使用")
        }
        let str1 = textfield?.text
        let str2 = view1?.changeString
        let result = str1!.rangeOfString(str2!, options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil)
        
        if(result == nil)
        {
            alert.title = "提示"
            alert.message = "您的验证码有误，请重新输入。"
            alert.addButtonWithTitle("确定")
            alert.delegate = self
            alert.show()
            NSLog("wrong")
        }
        
        if(nameSame() == 2 && result != nil)
        {
            alert1.title = "提示"
            alert1.message = "你已经申请成功,是否跳转主页面？"
            alert1.addButtonWithTitle("取消")
            alert1.addButtonWithTitle("确定")
            alert1.cancelButtonIndex = 0
            alert1.delegate = self
            alert1.show()
            NSLog("申请成功")
            
            insertUser(text1!, password: text2!, question: text3!, answer: text4!)
        }
        
        
        
        
        
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(alertView == alert1)
        {
            if(buttonIndex == 0)
            {
                return
                
            }
            else
            {
                //self.navigationController?.pushViewController(RegisterViewController(), animated: true)
                //self.performSegueWithIdentifier("20", sender: self)
                
            }
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


extension RegisterViewController
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
    func insertUser(name: String,password: String,question: String,answer: String)
    {
        let string: NSString = "insert into UserMessage(userName,userPassword,userQuestion,userAnswer) values(?,?,?,?)"
        let sql = string.UTF8String
        
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK
        {
            sqlite3_close(db)
            NSLog("\(name),insert fail")
            
        }
        
        let name1 = (name as NSString).UTF8String
        let password1 = (password as NSString).UTF8String
        let question1 = (question as NSString).UTF8String
        let answer1 = (answer as NSString).UTF8String
        
        sqlite3_bind_text(stmt, 1, name1, -1, nil)
        sqlite3_bind_text(stmt, 2, password1, -1, nil)
        sqlite3_bind_text(stmt, 3, question1, -1, nil)
        sqlite3_bind_text(stmt, 4, answer1, -1, nil)
        
        if sqlite3_step(stmt) == SQLITE_ERROR
        {
            NSLog("插入失败")
            sqlite3_close(db)
            NSLog("\(name),insert fail")
            
        }
        else
        {
            NSLog("\(name1),\(password1)")
            sqlite3_finalize(stmt)
        }
    }
    
    //查询用户名是否重复
    func nameSame() ->Int
    {
        
        let name = nameTextField!.text
        let string: NSString = "select userName from UserMessage where userName = '\(name)'"
        let sql = string.UTF8String
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK
        {
            if sqlite3_step(stmt) == SQLITE_ROW
            {
                let cname = sqlite3_column_text(stmt, 0)
                let sname = NSString(UTF8String: UnsafePointer(cname))
                NSLog("\(sname)")
                namerepeat = sname
                NSLog("名字\(namerepeat)")
                
            }
        }
        if(name == namerepeat)
        {
            NSLog("重复")
            return 1
            
        }
        else
        {
            NSLog("不重复")
            return 2
        }
        
        
    }
}
