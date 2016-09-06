//
//  LoginViewController.swift
//
//
//  Created by 梁慧广 on 16/3/31.
//
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    var bgImageView: UIImageView?
    var bgImageView1: UIImageView?
    var nameLabel: UILabel?
    var passwordLabel: UILabel!
    var nameTextField: UITextField?
    var passwordTextField: UITextField?
    var confirmButton: UIButton?
    var forgetPasswordButton: UIButton?
    var PageTitle: String?
    var lineImageView1: UIImageView?
    var lineImageView2: UIImageView?
    var swich1: UISwitch?
    var switchLabel: UILabel?
    var passwordTrue: NSString?
    var alert = UIAlertView()
    var alert1 = UIAlertView()
    var rightBarButton: UIBarButtonItem?
    var tapGestrue: UITapGestureRecognizer?
    var password1: NSString?
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths.first! as! String
        }()
    
    var db: COpaquePointer = nil
    var stmt: COpaquePointer = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField?.delegate = self
        passwordTextField?.delegate = self
        tapGestrue = UITapGestureRecognizer(target: self, action: "click")
        self.view.addGestureRecognizer(tapGestrue!)
        rightBarButton = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "register")
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.view.backgroundColor = UIColor.whiteColor()
        bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        bgImageView?.image = UIImage(named: "10")
        self.view.addSubview(bgImageView!)
        self.navigationItem.title = "登录"
        bgImageView1 = UIImageView(frame: CGRect(x: 31, y: 112, width: 310, height: 310))
        bgImageView1?.image = UIImage(named: "注册1")
        bgImageView1?.layer.cornerRadius = 50
        self.view.addSubview(bgImageView1!)
        nameLabel = UILabel(frame: CGRect(x: 39, y: 157, width: 83, height: 21))
        nameLabel?.text = "用户名："
        nameLabel?.font = UIFont(name: "Arial", size: 20)
        nameLabel?.textColor = UIColor.blackColor()
        self.view.addSubview(nameLabel!)
        passwordLabel = UILabel(frame: CGRect(x: 42, y: 230, width: 80, height: 21))
        passwordLabel?.text = "密 码："
        passwordLabel?.font = UIFont(name: "Arial", size: 20)
        passwordLabel?.textColor = UIColor.blackColor()
        self.view.addSubview(passwordLabel!)
        
        
        
        nameTextField = UITextField(frame: CGRect(x: 112, y: 153, width: 213, height: 30))
        self.view.addSubview(nameTextField!)
        nameTextField?.addTarget(self, action: "nameClick:", forControlEvents: UIControlEvents.TouchDown)
        self.nameTextField?.text = NSUserDefaults.standardUserDefaults().valueForKey("UserName") as! String
        
        
        
        passwordTextField = UITextField(frame: CGRect(x: 112, y: 226, width: 213, height: 30))
        self.view.addSubview(passwordTextField!)
        passwordTextField?.addTarget(self, action: "passwordClick:", forControlEvents: UIControlEvents.TouchDown)
        self.passwordTextField?.text = NSUserDefaults.standardUserDefaults().valueForKey("password") as! String
        
        
        
        lineImageView1 = UIImageView(frame: CGRect(x: 39, y: 186, width: 286, height: 1))
        lineImageView2 = UIImageView(frame: CGRect(x: 39, y: 259, width: 286, height: 1))
        lineImageView1?.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        lineImageView2?.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        self.view.addSubview(lineImageView1!)
        self.view.addSubview(lineImageView2!)
        confirmButton = UIButton(frame: CGRect(x: 140, y: 318, width: 92, height: 31))
        confirmButton?.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
        confirmButton?.setTitle("确认", forState: UIControlState.Normal)
        confirmButton?.titleLabel?.font = UIFont(name: "Arial", size: 19)
        confirmButton?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        confirmButton?.layer.cornerRadius = 10
        confirmButton?.layer.borderWidth = 1
        confirmButton?.layer.masksToBounds = true
        confirmButton?.layer.borderColor = UIColor.lightGrayColor().CGColor
        confirmButton?.addTarget(self, action: "confirmClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(confirmButton!)
        forgetPasswordButton = UIButton(frame: CGRect(x: 148, y: 366, width: 84, height: 30))
        forgetPasswordButton?.setTitle("忘记密码?", forState: UIControlState.Normal)
        forgetPasswordButton?.titleLabel?.font = UIFont(name: "Arial", size: 13)
        forgetPasswordButton?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        forgetPasswordButton?.addTarget(self, action: "forgetPassword", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(forgetPasswordButton!)
        swich1 = UISwitch(frame: CGRect(x: 39, y: 280, width: 30, height: 30))
        self.view.addSubview(swich1!)
        switchLabel = UILabel(frame: CGRect(x: 100, y: 280, width: 150, height: 30))
        switchLabel?.text = "十天内免登录"
        //switchLabel?.font = UIFont.boldSystemFontOfSize(20)   设置粗体
        self.view.addSubview(switchLabel!)
        
        
        createDatabase()
        createTable()
        findQuestion((self.nameTextField?.text)!)
        
        // Do any additional setup after loading the view.
    }
    func click()
    {
        self.nameTextField!.resignFirstResponder()
        self.passwordTextField!.resignFirstResponder()
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
    //
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.view.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
    }
    
    @IBAction func goBack1(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("17", sender: self)
    }
    @IBAction func Login(sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    
    
    func forgetPassword()
    {
        var VC2 = ChangePasswordViewController()
        VC2.question = nameTextField?.text
        self.navigationController?.pushViewController(VC2, animated: true)
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
    
    func confirmClick()
    {
        
        verify()
        let bool = self.swich1!.on
        let bool1: Bool
        verify()
        if bool == true
        {
            NSLog("保存")
            NSUserDefaults.standardUserDefaults().setObject(self.nameTextField?.text, forKey: "UserName")
            NSUserDefaults.standardUserDefaults().setObject(self.passwordTextField?.text, forKey: "password")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
        else
        {
            NSLog("不保存")
        }
        
        if(verify() == true)
        {
            alert1.title = "提示"
            alert1.message = "你已经登录成功,是否跳转主页面？"
            alert1.addButtonWithTitle("取消")
            alert1.addButtonWithTitle("确定")
            alert1.cancelButtonIndex = 0
            alert1.delegate = self
            alert1.show()
            NSLog("登录成功")
            
        }
        else
        {
            alert.title = "提示"
            alert.message = "您的用户名或密码输入有误，请重新输入。"
            alert.addButtonWithTitle("确定")
            alert.delegate = self
            alert.show()
            NSLog("登录失败")
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
                let anotherView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("5") as! UIViewController
                self.presentViewController(anotherView, animated: true, completion: nil)
                //当下面的方法不行，就用这个！！！
                //self.performSegueWithIdentifier("2", sender: self)
            }
        }
        else
        {
            nameTextField?.text = ""
            passwordTextField?.text = ""
        }
    }
    
    func register()
    {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    
}
extension LoginViewController
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
    func verify() -> Bool
    {
        
        let text1 = nameTextField!.text
        let text2 = passwordTextField!.text
        let string: NSString = "select userPassword from UserMessage where userName = '\(text1)' "
        let sql = string.UTF8String
        
        //解析sql文本语句
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK
        {
            
            if sqlite3_step(stmt) == SQLITE_ROW
            {
                let cname = sqlite3_column_text(stmt, 0)
                let sname = NSString(UTF8String: UnsafePointer(cname))!
                NSLog("name,\(sname)")
                passwordTrue = sname
            }
        }
        if(passwordTrue == text2)
        {
            sqlite3_finalize(stmt)
            return true
        }
        else
        {
            sqlite3_finalize(stmt)
            return false
        }
        
    }
    func findQuestion(name: String)
    {
        let string: NSString = "select userQuestion from UserMessage where userName = '\(name)' "
        let sql = string.UTF8String
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK
        {
            if sqlite3_step(stmt) == SQLITE_ROW
            {
                let cname = sqlite3_column_text(stmt, 0)
                let sname = NSString(UTF8String: UnsafePointer(cname))
                NSLog("问题,\(sname)")
            }
        }
        
        
    }
    func findPassword333()
    {
        NSLog("find")
        let string: NSString = "select userPassword from UserMessage where userName = '3' "
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
        
        
    }
    
   
    
    
}
