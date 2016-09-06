//
//  NewAdd3ViewController.swift
//  
//
//  Created by 梁慧广 on 16/4/9.
//
//

import UIKit

class NewAdd3ViewController: UIViewController,UITextFieldDelegate {

    var lab1:UILabel?
    var lab2:UILabel?
    var lab3:UILabel?
    var lab4:UILabel?
    var lab5:UILabel?
    var text1:UITextField?
    var text2:UITextField?
    var text3:UITextField?
    var barbutton: UIBarButtonItem?
    var line1:UIImageView?
    var line2:UIImageView?
    var line3:UIImageView?
    var line4:UIImageView?
    var imageBg:UIImageView?
    var tap:UITapGestureRecognizer?
    var textView:UITextView?
    var region1:String?
    var province1:String?
    var city1:String?
    var area1:String?
    var street1:String?
    var count1:Int?
    var count2:Int?
    var count3:Int?
    var count4:Int?
    var num1:Int?
    var tempNameArray: NSArray?
    var mutableNameArray: NSMutableArray?
    var Namestring: NSString?
    var tempPhoneArray: NSArray?
    var mutablePhoneArray: NSMutableArray?
    var Phonestring: NSString?
    var tempAddress1Array: NSArray?
    var mutableAddress1Array: NSMutableArray?
    var Address1string: NSString?
    var tempAddress2Array: NSArray?
    var mutableAddress2Array: NSMutableArray?
    var Address2string: NSString?
    var tempAddress3Array: NSArray?
    var mutableAddress3Array: NSMutableArray?
    var Address3string: NSString?
    var Addressstring: String?
    var myaddress: NewAddressViewController?
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths.first! as! String
        }()
    
    var db: COpaquePointer = nil
    var stmt: COpaquePointer = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = "添加新地址"
        self.view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        barbutton = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: "save")
        self.navigationItem.rightBarButtonItem = barbutton
        
        imageBg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 260))
        imageBg?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(imageBg!)
        
        
        lab1 = UILabel(frame: CGRect(x: 15, y: 80, width: 80, height: 24))
        lab1?.textColor = UIColor.blackColor()
        lab1?.font = UIFont(name: "Arial", size: 17)
        lab1?.text = "收货人"
        self.view.addSubview(lab1!)
        text1 = UITextField(frame: CGRect(x: 110, y: 80, width: 300, height: 24))
        text1?.textColor = UIColor.lightGrayColor()
        text1?.font = UIFont(name: "Arial", size: 17)
        text1?.delegate = self
        text1?.addTarget(self, action: "click1:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(text1!)
        line1 = UIImageView(frame: CGRect(x: 0, y: 114, width: self.view.bounds.width, height: 1))
        line1?.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(line1!)
        
        
        lab2 = UILabel(frame: CGRect(x: 15, y: 129, width: 80, height: 24))
        lab2?.textColor = UIColor.blackColor()
        lab2?.font = UIFont(name: "Arial", size: 17)
        //lab2?.backgroundColor = UIColor.redColor()
        lab2?.text = "联系电话"
        self.view.addSubview(lab2!)
        text2 = UITextField(frame: CGRect(x: 110, y: 129, width: 300, height: 24))
        text2?.textColor = UIColor.lightGrayColor()
        text2?.font = UIFont(name: "Arial", size: 17)
        text2?.addTarget(self, action: "click2:", forControlEvents: UIControlEvents.TouchDown)
        text2?.delegate = self
        self.view.addSubview(text2!)
        line2 = UIImageView(frame: CGRect(x: 0, y: 163, width: self.view.bounds.width, height: 1))
        line2?.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(line2!)
        
        
        lab3 = UILabel(frame: CGRect(x: 15, y: 178, width: 80, height: 24))
        lab3?.textColor = UIColor.blackColor()
        lab3?.font = UIFont(name: "Arial", size: 17)
        lab3?.text = "所在地区"
        self.view.addSubview(lab3!)
        lab4 = UILabel(frame: CGRect(x: 110, y: 178, width: 300, height: 24))
        lab4?.textColor = UIColor.grayColor()
        lab4?.userInteractionEnabled = true
        lab4?.font = UIFont(name: "Arial", size: 17)
        self.view.addSubview(lab4!)
        line2 = UIImageView(frame: CGRect(x: 0, y: 212, width: self.view.bounds.width, height: 1))
        line2?.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(line2!)
        tap = UITapGestureRecognizer(target: self, action: "choose")
        lab4?.addGestureRecognizer(tap!)
        
        
        
        
        
        lab5 = UILabel(frame: CGRect(x: 15, y: 227, width: 80, height: 24))
        lab5?.textColor = UIColor.blackColor()
        lab5?.font = UIFont(name: "Arial", size: 17)
        lab5?.text = "街道"
        self.view.addSubview(lab5!)
        text3 = UITextField(frame: CGRect(x: 110, y: 227, width: 200, height: 24))
        text3?.textColor = UIColor.grayColor()
        text3?.font = UIFont(name: "Arial", size: 17)
        text3?.delegate = self
        text3?.addTarget(self, action: "click3:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(text3!)
        line2 = UIImageView(frame: CGRect(x: 0, y: 261, width: self.view.bounds.width, height: 1))
        line2?.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(line2!)
        self.setupTextView()

        createDatabase()
        createTable()
        selectSHaddress1()
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
        
    }
    func click1(sender:UITextField)
    {
        sender.resignFirstResponder()
    }
    func click2(sender:UITextField)
    {
        sender.resignFirstResponder()
    }
    func click3(sender:UITextField)
    {
        sender.resignFirstResponder()
    }
    func save()
    {
        tempNameArray = NSUserDefaults.standardUserDefaults().objectForKey("name2") as? NSArray
        mutableNameArray = tempNameArray?.mutableCopy() as? NSMutableArray
        //mutableNameArray = ["1"]
        Namestring = text1?.text
        mutableNameArray?.insertObject(Namestring!, atIndex: 0)
        NSUserDefaults.standardUserDefaults().setObject(mutableNameArray, forKey: "name2")
        NSUserDefaults.standardUserDefaults().synchronize()
        myaddress?.nameArray = mutableNameArray
        NSLog("mutableNameArray\(mutableNameArray)")
        
        tempPhoneArray = NSUserDefaults.standardUserDefaults().objectForKey("phone2") as? NSArray
        mutablePhoneArray = tempPhoneArray?.mutableCopy() as? NSMutableArray
        //mutablePhoneArray = ["1"]
        Phonestring = text2?.text
        mutablePhoneArray?.insertObject(Phonestring!, atIndex: 0)
        NSUserDefaults.standardUserDefaults().setObject(mutablePhoneArray, forKey: "phone2")
        NSUserDefaults.standardUserDefaults().synchronize()
        myaddress?.phoneArray = mutablePhoneArray
        NSLog("mutablePhoneArray\(mutablePhoneArray)")
        
        tempAddress1Array = NSUserDefaults.standardUserDefaults().objectForKey("address2") as? NSArray
        mutableAddress1Array = tempAddress1Array?.mutableCopy() as? NSMutableArray
        //mutableAddress1Array = ["1"]
        Address1string = (self.lab4!.text)
        mutableAddress1Array?.insertObject(Address1string!, atIndex: 0)
        NSUserDefaults.standardUserDefaults().setObject(mutableAddress1Array, forKey: "address2")
        NSUserDefaults.standardUserDefaults().synchronize()
        myaddress?.addressArray = mutableAddress1Array
        NSLog("mutableAddress1Array\(mutableAddress1Array)")
        
        
        tempAddress2Array = NSUserDefaults.standardUserDefaults().objectForKey("address22") as? NSArray
        mutableAddress2Array = tempAddress2Array?.mutableCopy() as? NSMutableArray
        //mutableAddress2Array = ["1"]
        Address2string = self.text3?.text
        mutableAddress2Array?.insertObject(Address2string!, atIndex: 0)
        NSUserDefaults.standardUserDefaults().setObject(mutableAddress2Array, forKey: "address22")
        NSUserDefaults.standardUserDefaults().synchronize()
        myaddress?.address1Array = mutableAddress2Array
        NSLog("mutableAddress2Array\(mutableAddress2Array)")

        
        tempAddress3Array = NSUserDefaults.standardUserDefaults().objectForKey("address222") as? NSArray
        mutableAddress3Array = tempAddress3Array?.mutableCopy() as? NSMutableArray
        //mutableAddress3Array = ["1"]
        Address3string = self.textView?.text
        mutableAddress3Array?.insertObject(Address3string!, atIndex: 0)
        NSUserDefaults.standardUserDefaults().setObject(mutableAddress3Array, forKey: "address222")
        NSUserDefaults.standardUserDefaults().synchronize()
        myaddress?.address2Array = mutableAddress3Array
        NSLog("mutableAddress3Array\(mutableAddress3Array)")
        
        let UseName = NSUserDefaults.standardUserDefaults().valueForKey("UserName") as! String
        insertAddress(UseName, SHname:String(Namestring!) , SHphone: String(Phonestring!), SHaddress1: String(Address1string!), SHaddress2: String(Address2string!), SHaddress3: String(Address3string!))
        
        
        
        
    }
    func choose()
    {
        let addressPickerView:AddressChoicePickerView = AddressChoicePickerView.creatAddressChoicePickView();
        addressPickerView.show();
        addressPickerView.block = {
            (view:AddressChoicePickerView,obj:AreaObject) in
            self.lab4!.text = "";
            self.lab4!.text = obj.province!+" "+obj.city!+" "+obj.area!;
            return Void()
        }
    }
    
    func setupTextView(){
        
        let textView = TextView()
        textView.frame = CGRectMake(0, 262, self.view.frame.size.width, 90)
        textView.backgroundColor = UIColor.whiteColor()
        textView.font = UIFont.systemFontOfSize(15)
        //设置占位文字
        textView.placeholder = "详细地址"
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
extension NewAdd3ViewController
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
    func insertAddress(name: String,SHname: String,SHphone: String,SHaddress1: String,SHaddress2: String,SHaddress3: String)
    {
        let string: NSString = "insert into Address(name,SHname,SHphone,SHaddress1,SHaddress2,SHaddress3) values(?,?,?,?,?,?)"
        let sql = string.UTF8String
        
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK
        {
            sqlite3_close(db)
            NSLog("\(name),insert fail")
            
        }
        
        let name1 = (name as NSString).UTF8String
        let SHname1 = (SHname as NSString).UTF8String
        let SHphone1 = (SHphone as NSString).UTF8String
        let SHaddress11 = (SHaddress1 as NSString).UTF8String
        let SHaddress21 = (SHaddress2 as NSString).UTF8String
        let SHaddress31 = (SHaddress3 as NSString).UTF8String
        
        sqlite3_bind_text(stmt, 1, name1, -1, nil)
        sqlite3_bind_text(stmt, 2, SHname1, -1, nil)
        sqlite3_bind_text(stmt, 3, SHphone1, -1, nil)
        sqlite3_bind_text(stmt, 4, SHaddress11, -1, nil)
        sqlite3_bind_text(stmt, 5, SHaddress21, -1, nil)
        sqlite3_bind_text(stmt, 6, SHaddress31, -1, nil)
        
        if sqlite3_step(stmt) == SQLITE_ERROR
        {
            NSLog("插入失败")
            sqlite3_close(db)
            NSLog("\(name),insert fail")
            
        }
        else
        {
            NSLog("\(name1),\(SHname1)")
            sqlite3_finalize(stmt)
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