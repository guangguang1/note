//
//  FirstViewController.swift
//  
//
//  Created by 梁慧广 on 16/4/8.
//
//

import UIKit

class FirstViewController: UIViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var login: UIBarButtonItem?
    var a: UIView?
    var b: UIView?
    var c: UIView?
    var aa: UIImageView?
    var bb: UIImageView?
    var cc: UIImageView?
    var scroll : UIScrollView?
    var page : UIPageControl?
    var bgImageView: UIImageView?
    var btn4: UIButton?
    var btn2: UIButton?
    var btn3: UIButton?
    var btn11: UIButton?
    var btn12: UIButton?
    var btn13: UIButton?
    var lab1: UILabel?
    var lab2: UILabel?
    var lab3: UILabel?
    var table1: UITableView?
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths.first! as! String
        }()
    
    var db: COpaquePointer = nil
    var stmt: COpaquePointer = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "SE_X驿站"
        self.view.backgroundColor = UIColor(red: 244/255, green:  244/255, blue:  244/255, alpha: 1)
        login = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "login")
        self.navigationItem.leftBarButtonItem = login
        scroll = UIScrollView(frame: CGRect(x: 0, y: 60, width: self.view.bounds.width, height: 160))
        scroll?.backgroundColor = UIColor.redColor()
        scroll?.contentSize = CGSize(width: (self.view.bounds.width)*3, height: 160)
        scroll?.showsHorizontalScrollIndicator = false
        scroll?.showsVerticalScrollIndicator = false
        scroll?.delegate = self
        scroll?.scrollEnabled = true
        scroll?.pagingEnabled = true
        aa = UIImageView(frame: CGRect(x: 0*(self.view.bounds.width), y: 0, width: self.view.bounds.width, height: 160))
        aa?.image = UIImage(named: "shunfeng")
        aa?.layer.masksToBounds = true
        bb = UIImageView(frame: CGRect(x: 1*(self.view.bounds.width), y: 0, width: self.view.bounds.width, height: 160))
        bb?.image = UIImage(named: "yuantong")
        bb?.layer.masksToBounds = true
        cc = UIImageView(frame: CGRect(x: 2*(self.view.bounds.width), y: 0, width: self.view.bounds.width, height: 160))
        cc?.image = UIImage(named: "zhongtong")
        cc?.layer.masksToBounds = true
//        a = UIView(frame: CGRect(x: 0*(self.view.bounds.width), y: 0, width: self.view.bounds.width, height: 160))
//        b = UIView(frame: CGRect(x: 1*(self.view.bounds.width), y: 0, width: self.view.bounds.width, height: 160))
//        c = UIView(frame: CGRect(x: 2*(self.view.bounds.width), y: 0, width: self.view.bounds.width, height: 160))
//        a?.backgroundColor = UIColor.brownColor()
//        b?.backgroundColor = UIColor.blueColor()
//        c?.backgroundColor = UIColor.blackColor()
        scroll?.addSubview(aa!)
        scroll?.addSubview(bb!)
        scroll?.addSubview(cc!)
        page = UIPageControl(frame: CGRectMake(170, 180, 50, 50))
        page?.numberOfPages = 3
        page?.currentPage = 0
        page?.addTarget(self, action: "change", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(scroll!)
        self.view.addSubview(page!)
        
        bgImageView = UIImageView(frame: CGRect(x: 0, y: 220, width: self.view.bounds.width, height: 100))
        bgImageView?.backgroundColor = UIColor(red: 1, green:  1, blue:  1, alpha: 0.9)
        self.view.addSubview(bgImageView!)
        
        btn4 = UIButton(frame: CGRect(x: 50, y: 235, width: 50, height: 50))
        btn2 = UIButton(frame: CGRect(x: 170, y: 235, width: 50, height: 50))
        btn3 = UIButton(frame: CGRect(x: 280, y: 235, width: 50, height: 50))
        lab1 = UILabel(frame: CGRect(x: 50, y: 285, width: 50, height: 20))
        lab2 = UILabel(frame: CGRect(x: 170, y: 285, width: 50, height: 20))
        lab3 = UILabel(frame: CGRect(x: 280, y: 285, width: 50, height: 20))
        btn4?.layer.cornerRadius = 25
        btn2?.layer.cornerRadius = 25
        btn3?.layer.cornerRadius = 25
        btn4?.backgroundColor = UIColor.blueColor()
        btn2?.backgroundColor = UIColor.lightGrayColor()
        btn3?.backgroundColor = UIColor.yellowColor()
        lab1?.text = "寄快递"
        lab2?.text = "取快递"
        lab3?.text = "查快递"
        lab1?.font = UIFont.boldSystemFontOfSize(15)
        lab2?.font = UIFont.boldSystemFontOfSize(15)
        lab3?.font = UIFont.boldSystemFontOfSize(15)
        self.view.addSubview(btn4!)
        self.view.addSubview(btn2!)
        self.view.addSubview(btn3!)
        self.view.addSubview(lab1!)
        self.view.addSubview(lab2!)
        self.view.addSubview(lab3!)
        btn4?.addTarget(self, action: "btn1Click", forControlEvents: UIControlEvents.TouchDown)
        //btn2?.addTarget(self, action: "aaa", forControlEvents: UIControlEvents.TouchDown)
        btn11 = UIButton(frame: CGRect(x: 100, y: 235, width: 50, height: 50))
        btn12 = UIButton(frame: CGRect(x: 100, y: 235, width: 50, height: 50))
        btn13 = UIButton(frame: CGRect(x: 100, y: 235, width: 50, height: 50))
        btn11?.layer.cornerRadius = 25
        btn12?.layer.cornerRadius = 25
        btn13?.layer.cornerRadius = 25
        btn11?.setTitle("快速", forState: UIControlState.Normal)
        btn12?.setTitle("取消", forState: UIControlState.Normal)
        btn13?.setTitle("普通", forState: UIControlState.Normal)
        btn12?.addTarget(self, action: "btn12Click", forControlEvents: UIControlEvents.TouchDown)
        btn13?.addTarget(self, action: "btn13Click", forControlEvents: UIControlEvents.TouchDown)
        btn11?.addTarget(self, action: "btn11Click", forControlEvents: UIControlEvents.TouchDown)
        btn11?.backgroundColor = UIColor.greenColor()
        btn12?.backgroundColor = UIColor.greenColor()
        btn13?.backgroundColor = UIColor.greenColor()
        btn11?.alpha = 0
        btn12?.alpha = 0
        btn13?.alpha = 0
        self.view.addSubview(btn11!)
        self.view.addSubview(btn12!)
        self.view.addSubview(btn13!)
        
        table1 = UITableView(frame: CGRect(x: 0, y: 370, width: self.view.bounds.width , height: self.view.bounds.height))
        table1?.delegate = self
        table1?.dataSource = self
        self.view.addSubview(table1!)
        createDatabase()
        createTable()
        selectSHaddress1()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func btn11Click()
    {
        
    }
    func btn13Click()
    {
        
        self.navigationController?.pushViewController(ExpressNormalView1Controller(), animated: true)
    }
    
    func btn1Click()
    {
        NSLog("123")
        self.btn11?.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        self.btn12?.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        self.btn13?.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        
        
        
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            
            self.btn11?.alpha = 1
            self.btn11?.layer.setAffineTransform(CGAffineTransformMakeRotation(180))
            self.btn11?.center = CGPointMake(80, 340)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
            },
            completion:
            {
                (finished:Bool) -> Void in
                UIView.animateWithDuration(0.5, animations:{
                    self.btn11!.layer.setAffineTransform(CGAffineTransformIdentity)
                })
        })
        
        
        
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            self.btn12?.alpha = 1
            self.btn12?.layer.setAffineTransform(CGAffineTransformMakeRotation(180))
            self.btn12?.center = CGPointMake(135, 340)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
            
            },
            completion:
            {
                (finished:Bool) -> Void in
                UIView.animateWithDuration(0.5, animations:{
                    self.btn12?.layer.setAffineTransform(CGAffineTransformIdentity)
                })
        })
        
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            self.btn13?.alpha = 1
            self.btn13?.layer.setAffineTransform(CGAffineTransformMakeRotation(180))
            self.btn13?.center = CGPointMake(25, 340)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
            
            },
            completion:
            {
                (finished:Bool) -> Void in
                UIView.animateWithDuration(0.5, animations:{
                    self.btn13?.layer.setAffineTransform(CGAffineTransformIdentity)
                })
        })
        
        
        
    }
    func btn12Click()
    {
        
        self.btn11?.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        self.btn12?.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        self.btn13?.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            
            self.btn11!.alpha = 0
            self.btn11?.layer.setAffineTransform(CGAffineTransformMakeRotation(180))
            self.btn11?.center = CGPointMake(50, 235)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
            },
            completion:
            {
                (finished:Bool) -> Void in
                UIView.animateWithDuration(0.5, animations:{
                    self.btn11!.layer.setAffineTransform(CGAffineTransformIdentity)
                })
        })
        
        
        
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            self.btn12!.alpha = 0
            self.btn12?.layer.setAffineTransform(CGAffineTransformMakeRotation(180))
            self.btn12?.center = CGPointMake(50, 235)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
            
            },
            completion:
            {
                (finished:Bool) -> Void in
                UIView.animateWithDuration(0.5, animations:{
                    self.btn12!.layer.setAffineTransform(CGAffineTransformIdentity)
                })
        })
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            self.btn13!.alpha = 0
            self.btn13?.layer.setAffineTransform(CGAffineTransformMakeRotation(180))
            self.btn13?.center = CGPointMake(50, 235)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
            
            },
            completion:
            {
                (finished:Bool) -> Void in
                UIView.animateWithDuration(0.5, animations:{
                    self.btn13!.layer.setAffineTransform(CGAffineTransformIdentity)
                })
        })
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cellid = "sundy"
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellid) as? UITableViewCell
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellid)
        }
        //        NSLog("detail\(detail1)")
        //        note1 = noteArray?.objectAtIndex(indexPath.row) as? String
        //        date1 = dateArray?.objectAtIndex(indexPath.row) as? String
        //        detail1 = detailArray?.objectAtIndex(indexPath.row) as? String
        //        cell?.title1Label?.text = note1
        //        cell?.title2Label?.text = detail1
        //        cell?.title3Label?.text = date1
        //cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell!
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var curPage = scroll!.contentOffset.x/320
        page?.currentPage = Int(curPage)
    }
    func change()
    {
        var curPage = page?.currentPage
        //var a = (self.view.bounds.width)
        scroll?.scrollRectToVisible(CGRect(x: curPage!*400, y: 0, width: 400, height: 568), animated: true)
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



extension FirstViewController
{
    func createDatabase()
    {
        let path: NSString = "\(documentsPath)/Address.sqlite3"
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
        let string: NSString = "create table if not exists Address(id integer primary key autoincrement,name text,SHname text,SHphone text,SHaddress1 text,SHaddress2 text,SHaddress3 text)"
        let sql = string.UTF8String
        if sqlite3_exec(db, sql, nil, nil, nil) != SQLITE_OK
            
        {
            
            NSLog("table fail")
            sqlite3_close(db)
        }
    }
    func selectSHaddress1()
    {
        NSLog("123")
        let string: NSString = "select SHaddress1 from Address where name = '1' "
        let sql = string.UTF8String
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK
        {
            if sqlite3_step(stmt) == SQLITE_ROW
            {
                let cname = sqlite3_column_text(stmt, 0)
                let sname = NSString(UTF8String: UnsafePointer(cname))
                NSLog("地址\(sname)")
                
            }
            
        }
    }
    
}

