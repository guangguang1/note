//
//  PCommitViewController.swift
//
//
//  Created by 梁慧广 on 16/4/16.
//
//

import UIKit

class PCommitViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    
    var btn1:UIButton?
    var redBtn:UIButton?
    var lab1:UILabel?
    var lab2:UILabel?
    var lab3:UILabel?
    var text1:UITextField?
    var textView:UITextView?
    var tap:UITapGestureRecognizer?
    var line1:UIImageView?
    var line2:UIImageView?
    var line3:UIImageView?
    var line4:UIImageView?
    var i = 0
    var leftTableView:UITableView?
    var bool = false
    var express = ["顺丰快递","圆通快递","中通快递","韵达快递","申通快递"]
    var image111:[UIImage] = []
    var bgImage:UIImageView?
    var pushPrice:Int32 = 0
    var pushPrice1:Int32 = 0
    var pro1:String?
    var pro2:String?
    var allPrice:Int?
    var aaa:String?
    var copName:String?
    var addExp:String?
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths.first! as! String
        }()
    
    var db: COpaquePointer = nil
    var stmt: COpaquePointer = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("价格\(pushPrice * 10)")
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        bgImage = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        bgImage?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(bgImage!)
        bgImage?.hidden = true
        
        
        btn1 = UIButton(frame: CGRect(x: 20, y: 80, width: self.view.bounds.width - 40, height: 40))
        btn1?.setTitle("请选择快递公司", forState: UIControlState.Normal)
        btn1?.addTarget(self, action: "choooseCor", forControlEvents: UIControlEvents.TouchDown)
        btn1?.backgroundColor = UIColor.greenColor()
        self.view.addSubview(btn1!)
        
        lab1 = UILabel(frame: CGRect(x: 0, y: 140, width: 90, height: 40))
        lab1?.text = "物品重量："
        //lab1?.backgroundColor = UIColor.greenColor()
        self.view.addSubview(lab1!)
        
        text1 = UITextField(frame: CGRect(x: 100, y: 140, width: 200, height: 40))
        text1?.placeholder = "请输入物品的重量"
        //text1?.backgroundColor = UIColor.greenColor()
        self.view.addSubview(text1!)
        self.setupTextView()
        
        lab2 = UILabel(frame: CGRect(x: 0, y: 320, width:90, height: 40))
        lab2?.text = "总计金额："
        //lab2?.backgroundColor = UIColor.greenColor()
        self.view.addSubview(lab2!)
        
        
        
        redBtn = UIButton(frame: CGRect(x: 0, y: 380, width: self.view.bounds.width , height: 45))
        redBtn?.backgroundColor = UIColor.redColor()
        redBtn?.addTarget(self, action: "commitClick", forControlEvents: UIControlEvents.TouchDown)
        redBtn?.setTitle("我要寄件", forState: UIControlState.Normal)
        redBtn?.titleLabel?.font = UIFont.boldSystemFontOfSize(22)
        redBtn?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.view.addSubview(redBtn!)
        
        leftTableView = UITableView(frame: CGRectMake(20, 120,self.view.bounds.width - 40, 300), style: UITableViewStyle.Grouped)
        leftTableView?.delegate = self
        leftTableView?.dataSource = self
        leftTableView?.rowHeight = 60
        leftTableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(leftTableView!)
        leftTableView?.hidden = true
        let image1 = UIImage(named: "sf")
        let image2 = UIImage(named: "yt")
        let image3 = UIImage(named: "zt")
        let image4 = UIImage(named: "yd")
        let image5 = UIImage(named: "st")
        image111.insert(image1!, atIndex: 0)
        image111.insert(image2!, atIndex: 1)
        image111.insert(image3!, atIndex: 2)
        image111.insert(image4!, atIndex: 3)
        image111.insert(image5!, atIndex: 4)
        
        pro1 = NSUserDefaults.standardUserDefaults().valueForKey("pro1") as? String
        pro2 = NSUserDefaults.standardUserDefaults().valueForKey("pro2") as? String
        NSLog("pro1\(pro1)")
        NSLog("pro2\(pro2)")
        
        createDatabase()
        createTable()
        createDatabase1()
        createTable1()
        
        
        
        addExp = NSUserDefaults.standardUserDefaults().valueForKey("addressExpress") as? String
        NSLog("addExp\(addExp)")
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return express.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cellid = "sundy"
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellid) as? UITableViewCell
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellid)
        }
        cell?.textLabel?.text = express[indexPath.row]
        cell?.imageView?.image = image111[indexPath.row]
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        copName = express[indexPath.row]
        NSLog("copName\(copName)")
        leftTableView?.hidden = true
        bgImage?.hidden = true
        selectPrice(pro2!, add2:pro1! , copName: copName!)
        selectExpresser(copName!, addName1: addExp!)
    }
    func choooseCor()
    {
        
        bool = !bool
        if(bool)
        {
            leftTableView?.hidden = false
            bgImage?.hidden = false
        }
        else
        {
            leftTableView?.hidden = true
            bgImage?.hidden = true
        }
        
    }
    func setupTextView(){
        
        let textView = TextView()
        textView.frame = CGRectMake(0, 200, self.view.frame.size.width, 100)
        textView.backgroundColor = UIColor.whiteColor()
        textView.font = UIFont.systemFontOfSize(15)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.blackColor().CGColor
        //设置占位文字
        textView.placeholder = "备注(如是否需要带称、包装箱子等物件上门)"
        self.view.addSubview(textView)
        self.textView = textView
        tap = UITapGestureRecognizer(target: self, action: "click1")
        self.textView?.addGestureRecognizer(tap!)
        
        //        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange", name: UITextViewTextDidChangeNotification, object: textView)
        
    }
    func click1()
    {
        self.textView!.resignFirstResponder()
    }
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func AllMoney()
    {
        var weight = text1?.text.toInt()
        if(weight > 0)
        {
            if(weight > 1)
            {
                NSLog("大于1")
                NSLog("pushPrice\(pushPrice)")
                NSLog("pushPrice1\(pushPrice1)")
                allPrice = Int(pushPrice) + (weight! - 1) * Int(pushPrice1)
                aaa = String(stringInterpolationSegment: allPrice)
                
                NSLog("allPrice1\(aaa)")
                NSLog("allPrice\(allPrice)")
            }
            else
            {
                NSLog("小于1")
                allPrice = Int(pushPrice)
                aaa = String(stringInterpolationSegment: allPrice)
                NSLog("allPrice1\(aaa)")
            }
        }
        else
        {
            NSLog("输入有误")
        }
        NSUserDefaults.standardUserDefaults().setObject(aaa, forKey: "price")
    }
    
    func commitClick()
    {
        AllMoney()
        lab3 = UILabel(frame: CGRect(x: 100, y: 320, width:120, height: 40))
        lab3?.text = aaa
        self.view.addSubview(lab3!)
        self.navigationController?.pushViewController(CommitViewController(), animated: true)
        var date = NSDate()
        var timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "YY-MM-dd HH:mm"
        var strNowTime = timeFormatter.stringFromDate(date) as String
        NSUserDefaults.standardUserDefaults().setObject(strNowTime, forKey: "time")
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


extension PCommitViewController
{
    func createDatabase()
    {
        let path: NSString = "\(documentsPath)/Price1.sqlite3"
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
        let string: NSString = "create table if not exists Price(id integer primary key autoincrement,CopName text,addName1 text,addName2 text,price double,extraPrice double)"
        let sql = string.UTF8String
        if sqlite3_exec(db, sql, nil, nil, nil) != SQLITE_OK
            
        {
            
            NSLog("table fail")
            sqlite3_close(db)
        }
        
    }
   func selectPrice(add1:String,add2:String,copName:String)
   {
    let string: NSString = "select price from Price where addName1 = '吉林' and addName2 = '山东' and CopName = '顺丰快递' "
    let sql = string.UTF8String
    if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK
    {
        if sqlite3_step(stmt) == SQLITE_ROW
        {
            let cname = sqlite3_column_text(stmt, 0)
            let sname = NSString(UTF8String: UnsafePointer(cname))
            
            
            let aaa = sname?.intValue
            pushPrice = aaa!
            NSLog("价格111\(aaa)")
            NSLog("价格\(pushPrice)")
            
        }
        else
        {
            NSLog("fail111")
        }
        
    }
    else
        
    {
        NSLog("fail")
    }

    }
    func selectaddress1(add1:String,add2:String,copName:String)
    {
        NSLog("add1\(add1)")
        NSLog("add2\(add2)")
        NSLog("copName\(copName)")
        let string: NSString = "select price from Price where addName1 = '吉林' and addName2 = '山东' and CopName = '顺丰快递' "
        let sql = string.UTF8String
//        let string1: NSString = "select extraPrice from Price where addName1 = '\(add1)' and addName2 = '\(add2)' and CopName = '\(copName)' "
//        let sql1 = string1.UTF8String
        
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK
        {
            if sqlite3_step(stmt) == SQLITE_ROW
            {
                let cname = sqlite3_column_text(stmt, 0)
                let sname = NSString(UTF8String: UnsafePointer(cname))
                
                
                let aaa = sname?.intValue
                pushPrice = aaa!
                NSLog("价格111\(aaa)")
                NSLog("价格\(pushPrice)")
                
            }
            else
            {
               NSLog("fail111")
            }
            
        }
        else
        
        {
            NSLog("fail")
        }
        
//        if sqlite3_prepare_v2(db, sql1, -1, &stmt, nil) == SQLITE_OK
//        {
//            if sqlite3_step(stmt) == SQLITE_ROW
//            {
//                let cname = sqlite3_column_text(stmt, 0)
//                let sname = NSString(UTF8String: UnsafePointer(cname))
//                
//                
//                let aaa = sname?.intValue
//                pushPrice1 = aaa!
//                
//                NSLog("超出价格\(pushPrice1)")
//                
//            }
//            
//        }
        
    }
    
    
}



extension PCommitViewController
{
    func createDatabase1()
    {
        let path: NSString = "\(documentsPath)/Expresser.sqlite3"
        let filename = path.UTF8String
        NSLog("\(path)")
        if sqlite3_open(filename, &db) != SQLITE_OK
        {
            NSLog("database fail")
            sqlite3_close(db)
        }
    }
    func  createTable1()
    {
        let string: NSString = "create table if not exists Expresser(id integer primary key autoincrement,ExpresserName text,ExpresserPhone int,copName text,addName1 text,score double)"
        let sql = string.UTF8String
        if sqlite3_exec(db, sql, nil, nil, nil) != SQLITE_OK
            
        {
            
            NSLog("table fail")
            sqlite3_close(db)
        }
        
    }
    
    func selectExpresser(copName:String,addName1:String)
    {
        
        let string: NSString = "select ExpresserName from Expresser where copName = '\(copName)' and addName1 = '\(addName1)' "
        let sql = string.UTF8String
        let string1: NSString = "select ExpresserPhone from Expresser where copName = '\(copName)' and addName1 = '\(addName1)' "
        let sql1 = string1.UTF8String
        let string2: NSString = "select score from Expresser where copName = '\(copName)' and addName1 = '\(addName1)' "
        let sql2 = string2.UTF8String
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK
        {
            if sqlite3_step(stmt) == SQLITE_ROW
            {
                let cname = sqlite3_column_text(stmt, 0)
                let sname = NSString(UTF8String: UnsafePointer(cname))
                NSUserDefaults.standardUserDefaults().setObject(sname, forKey: "expresserName")
                
                
            }
            
        }
        
        if sqlite3_prepare_v2(db, sql1, -1, &stmt, nil) == SQLITE_OK
        {
            if sqlite3_step(stmt) == SQLITE_ROW
            {
                
                let cname = sqlite3_column_text(stmt, 0)
                let sname = NSString(UTF8String: UnsafePointer(cname))
                
                
                let aaa = sname?.intValue
                let aa = Int(aaa!)
                NSUserDefaults.standardUserDefaults().setInteger(aa, forKey: "expresserPhone")
               
                
            }
            
        }
        if sqlite3_prepare_v2(db, sql2, -1, &stmt, nil) == SQLITE_OK
        {
            if sqlite3_step(stmt) == SQLITE_ROW
            {
                let cname = sqlite3_column_text(stmt, 0)
                let sname = NSString(UTF8String: UnsafePointer(cname))
                
                let aaa = sname?.doubleValue
                NSUserDefaults.standardUserDefaults().setObject(sname, forKey: "expresserScore")
               
                
            }
            
        }

        
    }
    

}



