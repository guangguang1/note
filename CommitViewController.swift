//
//  CommitViewController.swift
//
//
//  Created by 梁慧广 on 16/4/2.
//
//

import UIKit

class CommitViewController: UIViewController,UIActionSheetDelegate {
    
    
    var tempNameArray: NSArray?
    var mutableNameArray: NSMutableArray?
   
    var tempOrderArray: NSArray?
    var mutableOrderArray: NSMutableArray?

    var tempName1Array: NSArray?
    var mutableName1Array: NSMutableArray?
    
    var tempAddArray: NSArray?
    var mutableAddArray: NSMutableArray?
    
    var tempTimeArray: NSArray?
    var mutableTimeArray: NSMutableArray?
    
    
    var tempStateArray: NSArray?
    var mutableStateArray: NSMutableArray?
    
    var tempPriceArray: NSArray?
    var mutablePriceArray: NSMutableArray?

    
    var touxiangImage:UIImageView?
    var nameLabel:UILabel?
    var scoreLabel:UILabel?
    var scoreImage:UIImageView?
    var phoneImageview:UIImageView?
    var textLable: UILabel?
    var cancelBtn: UIButton?
    var progress: KDCircularProgress!
    var timer : NSTimer?
    var timeLable: UILabel?
    var btn: UIButton?
    var numView: TheView1?
    var cancelReason = ["1","2","3","4","其他"]
    var actionSheet: UIActionSheet?
    var completeBtn:UIButton?
    var compeleteAlert = UIAlertView()
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths.first! as! String
        }()
    
    var db: COpaquePointer = nil
    var stmt: COpaquePointer = nil
    var isCounting:Bool = false
        
        {
        willSet(newValue)
        {
            if newValue
            {
                
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime:", userInfo: nil, repeats: true)
            }
            else
            {
                timer?.invalidate()
                timer = nil
            }
            
        }
    }
    var remainTime:Int = 600 {
        willSet(newSeconds) {
            //就是这两个公式(输入的全部是以秒为单位的数)
            let min = newSeconds/60
            let seconds = newSeconds%60
            timeLable?.text = NSString(format: "%02d:%02d", min,seconds) as String
        }
    }
    var longTimeLabel: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var a = NSUserDefaults.standardUserDefaults().integerForKey("expresserPhone")
        NSLog("\(a)")
        
        self.view.backgroundColor = UIColor.whiteColor()
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        progress.startAngle = -90
        progress.progressThickness = 0.1
        progress.trackThickness = 0.3
        progress.clockwise = true
        progress.center = view.center
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = true
        progress.glowMode = .Forward
        progress.setColors(UIColor.cyanColor() ,UIColor.whiteColor(), UIColor.magentaColor())
        view.addSubview(progress)
        progress.animateToAngle(360, duration: 600) { completed in
            if completed {
                println("animation stopped, completed")
            } else {
                println("animation stopped, was interrupted")
            }
        }
        timeLable = UILabel(frame: CGRect(x: 110, y: 300, width: 150, height: 60))
        timeLable?.font = UIFont(name: "DBLCDTempBlack", size: 40)
        timeLable?.textAlignment = NSTextAlignment.Center
        timeLable?.textColor = UIColor.blackColor()
        timeLable?.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(timeLable!)
        self.isCounting = true
        
        longTimeLabel = UILabel(frame: CGRect(x: 115, y: 275, width: 140, height: 30))
        longTimeLabel?.text = "预计取件时长"
        longTimeLabel?.textAlignment = NSTextAlignment.Center
        self.view.addSubview(longTimeLabel!)
        
        cancelBtn = UIButton(frame: CGRect(x: 20, y: 620, width: self.view.bounds.width - 40, height: 40))
        cancelBtn?.setTitle("取消订单", forState: UIControlState.Normal)
        cancelBtn?.backgroundColor = UIColor.lightGrayColor()
        cancelBtn?.layer.cornerRadius = 5
        cancelBtn?.addTarget(self, action: "cancel", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(cancelBtn!)
        
        
        textLable = UILabel(frame: CGRect(x: 60, y: 510, width: 260, height: 40))
        textLable?.text = "快递单号"
        textLable?.textAlignment = NSTextAlignment.Center
        textLable?.font = UIFont.systemFontOfSize(20)
        self.view.addSubview(textLable!)
        
        numView = TheView1(frame: CGRect(x: 90, y: 550, width: 200, height: 60))
        self.view.addSubview(numView!)
        
        
        touxiangImage = UIImageView(frame: CGRect(x: 10, y: 80, width: 50, height: 50))
        touxiangImage?.layer.cornerRadius = 25
        touxiangImage?.layer.masksToBounds = true
        touxiangImage?.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(touxiangImage!)
        
        nameLabel = UILabel(frame: CGRect(x: 70, y: 80, width: 100, height: 20))
        nameLabel?.text = NSUserDefaults.standardUserDefaults().valueForKey("expresserName") as? String
        nameLabel?.backgroundColor = UIColor.redColor()
        self.view.addSubview(nameLabel!)
        
        
        scoreLabel = UILabel(frame: CGRect(x: 145, y: 110, width: 30, height: 20))
        scoreLabel?.backgroundColor = UIColor.yellowColor()
        scoreLabel?.textAlignment = NSTextAlignment.Center
        scoreLabel?.text = NSUserDefaults.standardUserDefaults().valueForKey("expresserScore") as? String
        self.view.addSubview(scoreLabel!)
        
        
        scoreImage = UIImageView(frame: CGRect(x: 70, y: 110, width: 70, height: 20))
        scoreImage?.backgroundColor = UIColor.redColor()
        self.view.addSubview(scoreImage!)
        
        phoneImageview = UIImageView(frame: CGRect(x: 300, y: 80, width: 50, height: 50))
        phoneImageview?.layer.cornerRadius = 25
        phoneImageview?.backgroundColor = UIColor.greenColor()
        phoneImageview?.layer.masksToBounds = true
        self.view.addSubview(phoneImageview!)
        //NSUserDefaults.standardUserDefaults().setObject("完成订单", forKey: "state")
        
        
        createDatabase2()
        createTable2()
        
        var dbName = NSUserDefaults.standardUserDefaults().valueForKey("UserName") as? String
        var dbNum = NSUserDefaults.standardUserDefaults().valueForKey("num") as? String
        var dbRN = NSUserDefaults.standardUserDefaults().valueForKey("RN") as? String
        var dbRA = NSUserDefaults.standardUserDefaults().valueForKey("RA") as? String
        var dbTime = NSUserDefaults.standardUserDefaults().valueForKey("time") as? String
        var dbState = NSUserDefaults.standardUserDefaults().valueForKey("state") as? String
        var dbPrice = NSUserDefaults.standardUserDefaults().valueForKey("price") as? String
        
        //insert(dbName!, orderNum: dbNum!, receiverName: dbRN!, receiverAddress: dbRA!, time: dbTime!, state: dbState!, price: dbPrice!)
        //        NSLog("\(dbNum)")
        //        NSLog("\(dbRN)")
        //        NSLog("\(dbRA)")
        //        NSLog("\(dbTime)")
        //        NSLog("\(dbState)")
        //        NSLog("\(dbPrice)")
        
        selectAllMessage()
        
        

        completeBtn = UIButton(frame: CGRect(x: 80, y: 200, width: 10, height: 10))
        completeBtn?.backgroundColor = UIColor.lightGrayColor()
        completeBtn?.addTarget(self, action: "complete", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(completeBtn!)
        
        
    }
    
    func complete()
    {
        compeleteAlert.title = "提示"
        compeleteAlert.message = "你的订单已经被接受，请耐心等待快递员上门"
        compeleteAlert.addButtonWithTitle("确定")
        compeleteAlert.cancelButtonIndex = 0
        compeleteAlert.delegate = self
        compeleteAlert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
    if(buttonIndex == 0)
    {
        NSLog("123")
    NSUserDefaults.standardUserDefaults().setObject("待评价", forKey: "state")
        var aa = NSUserDefaults.standardUserDefaults().valueForKey("state") as? String
        NSLog("\(aa)")
    }
    else
    {
        
    }
       
    }

    func updateTime(timer : NSTimer){
        remainTime -= 1
    
        //等到时间小于零的时候要提示用户倒计时完成
        if remainTime < 1 {
            //弹出一个alert
            isCounting = false
            let alert = UIAlertView()
            alert.title = "倒计时结束"
            alert.alertViewStyle = UIAlertViewStyle.Default
            alert.addButtonWithTitle("OK")
            alert.message = ""
            
            //显示
            alert.show()
        }
    }
    
    func cancel()
    {
        NSUserDefaults.standardUserDefaults().setObject("取消订单", forKey: "state")
        actionSheet = UIActionSheet(title: "取消原因", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "地址填写错误","等待时间太长","其他")
        actionSheet?.showInView(self.view)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


extension CommitViewController
{
    func createDatabase2()
    {
        let path: NSString = "\(documentsPath)/Order211.sqlite3"
        let filename = path.UTF8String
        NSLog("\(path)")
        if sqlite3_open(filename, &db) != SQLITE_OK
        {
            NSLog("database fail")
            sqlite3_close(db)
        }
    }
    func  createTable2()
    {
        let string: NSString = "create table if not exists bbb(id integer primary key autoincrement,name text,num text,name1 text,address text,time text,state text,price text)"
        let sql = string.UTF8String
        if sqlite3_exec(db, sql, nil, nil, nil) != SQLITE_OK
            
        {
            
            NSLog("table fail")
            sqlite3_close(db)
        }
        
    }
    func insert(userName: String,orderNum: String,receiverName: String,receiverAddress: String,time: String,state: String,price: String)
        
    {   let string: NSString = "insert into bbb(name,num,name1,address,time,state,price) values(?,?,?,?,?,?,?)"
        let sql = string.UTF8String
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK
        {
            sqlite3_close(db)
            NSLog("\(userName),insert fail")
        }
        
        let uName = (userName as NSString).UTF8String
        let oNum = (orderNum as NSString).UTF8String
        let Rname = (receiverName as NSString).UTF8String
        let Raddress = (receiverAddress as NSString).UTF8String
        let time = (time as NSString).UTF8String
        let state = (state as NSString).UTF8String
        let price = (price as NSString).UTF8String
        
        sqlite3_bind_text(stmt, 1, uName, -1, nil)
        sqlite3_bind_text(stmt, 2, oNum, -1, nil)
        sqlite3_bind_text(stmt, 3, Rname, -1, nil)
        sqlite3_bind_text(stmt, 4, Raddress, -1, nil)
        sqlite3_bind_text(stmt, 5, time, -1, nil)
        sqlite3_bind_text(stmt, 6, state, -1, nil)
        sqlite3_bind_text(stmt, 7, price, -1, nil)
        
        if sqlite3_step(stmt) == SQLITE_ERROR
        {
            NSLog("插入失败")
            sqlite3_close(db)
            NSLog("\(userName)insert fail")
            
        }
        else
        {
            NSLog("\(userName),\(oNum)")
            sqlite3_finalize(stmt)
        }
        
    }
    func selectAllMessage()
    {
        
        
        let string: NSString = "select * from bbb where name = '1'"
        let sql = string.UTF8String
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK
        {
            var count = sqlite3_column_count(stmt)
            NSLog("count\(count)")
            if sqlite3_step(stmt) == SQLITE_ROW
            {
                
                //for i in 0..<count {
                let cname = sqlite3_column_text(stmt, 1)
                let sname = NSString(UTF8String: UnsafePointer(cname))!
                NSLog("name,\(sname)")
                tempNameArray = NSUserDefaults.standardUserDefaults().objectForKey("OrderUsername") as? NSArray
                mutableNameArray = tempNameArray?.mutableCopy() as? NSMutableArray
                //mutableNameArray = ["1"]
                //mutableNameArray?.insertObject(sname, atIndex: 0)
                NSUserDefaults.standardUserDefaults().setObject(mutableNameArray, forKey: "OrderUsername")
                NSUserDefaults.standardUserDefaults().synchronize()
                NSLog("mutableNameArray\(mutableNameArray)")
                
                
                let cname1 = sqlite3_column_text(stmt, 2)
                let sname1 = NSString(UTF8String: UnsafePointer(cname1))!
                NSLog("name1,\(sname1)")
                tempOrderArray = NSUserDefaults.standardUserDefaults().objectForKey("OrderNumber") as? NSArray
                mutableOrderArray = tempOrderArray?.mutableCopy() as? NSMutableArray
                //mutableOrderArray = ["1"]
                //mutableOrderArray?.insertObject(sname1, atIndex: 0)
                NSUserDefaults.standardUserDefaults().setObject(mutableOrderArray, forKey: "OrderNumber")
                NSUserDefaults.standardUserDefaults().synchronize()
                NSLog("mutableOrderArray\(mutableOrderArray)")

                let cname2 = sqlite3_column_text(stmt, 3)
                let sname2 = NSString(UTF8String: UnsafePointer(cname2))!
                NSLog("name2,\(sname2)")
                tempName1Array = NSUserDefaults.standardUserDefaults().objectForKey("Name1") as? NSArray
                mutableName1Array = tempName1Array?.mutableCopy() as? NSMutableArray
                //mutableName1Array = ["1"]
                //mutableName1Array?.insertObject(sname2, atIndex: 0)
                NSUserDefaults.standardUserDefaults().setObject(mutableName1Array, forKey: "Name1")
                NSUserDefaults.standardUserDefaults().synchronize()
                NSLog("mutableNameArray\(mutableName1Array)")
                
                
                
                let cname3 = sqlite3_column_text(stmt, 4)
                let sname3 = NSString(UTF8String: UnsafePointer(cname3))!
                NSLog("name3,\(sname3)")
                tempAddArray = NSUserDefaults.standardUserDefaults().objectForKey("Add") as? NSArray
                mutableAddArray = tempAddArray?.mutableCopy() as? NSMutableArray
                //mutableAddArray = ["1"]
                //mutableAddArray?.insertObject(sname3, atIndex: 0)
                NSUserDefaults.standardUserDefaults().setObject(mutableAddArray, forKey: "Add")
                NSUserDefaults.standardUserDefaults().synchronize()
                NSLog("mutableNameArray\(mutableAddArray)")
                
                
                
                
                let cname4 = sqlite3_column_text(stmt, 5)
                let sname4 = NSString(UTF8String: UnsafePointer(cname4))!
                NSLog("name4,\(sname4)")
                tempTimeArray = NSUserDefaults.standardUserDefaults().objectForKey("Time") as? NSArray
                mutableTimeArray = tempTimeArray?.mutableCopy() as? NSMutableArray
                //mutableTimeArray = ["1"]
                //mutableTimeArray?.insertObject(sname4, atIndex: 0)
                NSUserDefaults.standardUserDefaults().setObject(mutableTimeArray, forKey: "Time")
                NSUserDefaults.standardUserDefaults().synchronize()
                NSLog("mutableNameArray\(mutableTimeArray)")
                
                
                
                let cname5 = sqlite3_column_text(stmt, 6)
                let sname5 = NSString(UTF8String: UnsafePointer(cname5))!
                NSLog("name5,\(sname5)")
                tempStateArray = NSUserDefaults.standardUserDefaults().objectForKey("State") as? NSArray
                mutableStateArray = tempStateArray?.mutableCopy() as? NSMutableArray
                //mutableStateArray = ["1"]
                //mutableStateArray?.insertObject(sname5, atIndex: 0)
                NSUserDefaults.standardUserDefaults().setObject(mutableStateArray, forKey: "State")
                NSUserDefaults.standardUserDefaults().synchronize()
                NSLog("mutableStateArray\(mutableStateArray)")
                
                
                let cname6 = sqlite3_column_text(stmt, 7)
                let sname6 = NSString(UTF8String: UnsafePointer(cname6))!
                NSLog("name6,\(sname6)")
                tempPriceArray = NSUserDefaults.standardUserDefaults().objectForKey("Price") as? NSArray
                mutablePriceArray = tempPriceArray?.mutableCopy() as? NSMutableArray
                //mutablePriceArray = ["1"]
                //mutablePriceArray?.insertObject(sname6, atIndex: 0)
                NSUserDefaults.standardUserDefaults().setObject(mutablePriceArray, forKey: "Price")
                NSUserDefaults.standardUserDefaults().synchronize()
                NSLog("mutableNameArray\(mutablePriceArray)")
                //}
                
            }
        }
    }
}

