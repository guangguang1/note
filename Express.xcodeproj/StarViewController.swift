//
//  StarViewController.swift
//  
//
//  Created by 梁慧广 on 16/4/9.
//
//

import UIKit

class StarViewController: UIViewController,UITextViewDelegate {

    var bgImageView:UIImageView?
    var lab:UILabel?
    var view1: TQViewController?
    var num:Float?
    var touxiangImage:UIImageView?
    var nameLab:UILabel?
    var starLab:UILabel?
    var line1:UIImageView?
    var line2:UIImageView?
    var line3:UIImageView?
    var line4:UIImageView?
    var line5:UIImageView?
    var rightBtn:UIBarButtonItem?
    var tap:UITapGestureRecognizer?
    var textView:UITextView?
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths.first! as! String
        }()
    
    var db: COpaquePointer = nil
    var stmt: COpaquePointer = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "评价"
        self.view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        bgImageView = UIImageView(frame: CGRect(x: 20, y: 130, width: self.view.bounds.width  - 40, height: 340))
        bgImageView?.backgroundColor = UIColor.whiteColor()
        bgImageView?.layer.cornerRadius = 10
        bgImageView?.userInteractionEnabled = true
        self.view.addSubview(bgImageView!)
        createDatabase()
        createTable()
        
        var name111 = NSUserDefaults.standardUserDefaults().valueForKey("UserName") as! String
        
        var order111 = NSUserDefaults.standardUserDefaults().valueForKey("OrderNumber") as? String
        var cur = NSUserDefaults.standardUserDefaults().objectForKey("curValue") as! NSNumber
        var n = cur - NSNumber(100) 
        NSLog("curValue\(n)")
        //insertAddress(name111, Score: self.starLab!.text, Detail: self.textView?.text, Num: <#String#>)
        rightBtn = UIBarButtonItem(title: "提交", style: UIBarButtonItemStyle.Plain, target: self, action: "rightBtnClick")
        self.navigationItem.rightBarButtonItem = rightBtn
        touxiangImage = UIImageView(frame: CGRect(x: 20, y: 20, width: 40, height: 40))
        touxiangImage?.layer.cornerRadius = 20
        touxiangImage?.layer.masksToBounds = true
        touxiangImage?.image = UIImage(named: "e")
        bgImageView?.addSubview(touxiangImage!)
        nameLab = UILabel(frame: CGRect(x: 70, y: 20, width: 100, height: 40))
        nameLab?.textAlignment = NSTextAlignment.Center
        nameLab?.text = "快递员名字"
        bgImageView?.addSubview(nameLab!)
        line1 = UIImageView(frame: CGRect(x: 10, y: 80, width: self.view.bounds.width  - 60, height: 1))
        line1?.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        bgImageView?.addSubview(line1!)
        starLab = UILabel(frame: CGRect(x: 130, y: 170, width: 80, height: 40))
        starLab?.textAlignment = NSTextAlignment.Center
        starLab?.font = UIFont.boldSystemFontOfSize(25)
        bgImageView?.addSubview(starLab!)
        view1 = TQViewController(frame: CGRect(x: 70, y: 110, width: 200, height: 40), clb: { (cur) -> (Void) in
            self.num = cur
            self.starLab!.text = NSString(format: "%0.2f", cur * 10) as String
            NSLog("self.starLab!.text\(self.starLab!.text)")
            }
        )
        //self.view.addSubview(bgImageView!)
        bgImageView?.addSubview(view1!)
        line2 = UIImageView(frame: CGRect(x: 10, y: 240, width: self.view.bounds.width  - 60, height: 1))
        line2?.backgroundColor = UIColor.lightGrayColor()
        bgImageView?.addSubview(line2!)
        line3 = UIImageView(frame: CGRect(x: 10, y: 320, width: self.view.bounds.width  - 60, height: 1))
        line3?.backgroundColor = UIColor.lightGrayColor()
        bgImageView?.addSubview(line3!)
        line4 = UIImageView(frame: CGRect(x: 10, y: 240, width: 1, height: 80))
        line4?.backgroundColor = UIColor.lightGrayColor()
        bgImageView?.addSubview(line4!)
        line5 = UIImageView(frame: CGRect(x: self.view.bounds.width  - 50, y: 240, width: 1, height: 80))
        line5?.backgroundColor = UIColor.lightGrayColor()
        bgImageView?.addSubview(line5!)
        setupTextView()
        
        bgImageView?.addSubview(textView!)
        
    }
    
    func setupTextView()
    {
        
        let textView = TextView()
        textView.frame = CGRectMake(11, 241, self.view.bounds.width  - 62, 78)
        textView.backgroundColor = UIColor.whiteColor()
        textView.font = UIFont.systemFontOfSize(15)
        //设置占位文字
        textView.placeholder = "写下您对快递员的评价吧~"
        self.view.addSubview(textView)
        self.textView = textView
        tap = UITapGestureRecognizer(target: self, action: "click1")
        self.textView?.addGestureRecognizer(tap!)
        self.textView?.delegate = self
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange", name: UITextViewTextDidChangeNotification, object: textView)
        
    }
    
    func textViewDidBeginEditing(textView: UITextView)
    {
        var frame:CGRect = textView.frame
        var offset = frame.origin.y + 100 - (self.view.bounds.height - 216.0)
        var animationDuration:NSTimeInterval = 0.3
        UIView.beginAnimations("ResizeForkeyboard", context: nil)
        UIView.setAnimationDuration(animationDuration)
        if(offset > 0)
        {
            self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height)
            
        }
        UIView.commitAnimations()

    }
    func textViewDidEndEditing(textView: UITextView)
    {
        self.view.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)

    }
    func click1()
    {
        self.textView!.resignFirstResponder()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension StarViewController
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

