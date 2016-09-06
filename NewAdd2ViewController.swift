//
//  NewAdd2ViewController.swift
//  
//
//  Created by 梁慧广 on 16/4/8.
//
//

import UIKit

class NewAdd2ViewController: UIViewController,UITextFieldDelegate{

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
    var index:Int?
    var table:UITableView?
    var nameArray:NSMutableArray?
    var phoneArray:NSMutableArray?
    var addressArray:NSMutableArray?
    var address2Array:NSMutableArray?
    var address3Array:NSMutableArray?
    var phone1:String?
    var address1:String?
    var address2:String?
    var address3:String?
    var name1:String?
    var imageBg1:UIImageView?
    var deleteLabel:UILabel?
    var deleteTap:UITapGestureRecognizer?
    var alert = UIAlertView()
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("index\(index)")
        self.province1 = NSUserDefaults.standardUserDefaults().valueForKey("province") as? String
        self.city1 = NSUserDefaults.standardUserDefaults().valueForKey("city") as? String
        self.area1 = NSUserDefaults.standardUserDefaults().valueForKey("area") as? String
        self.street1 = NSUserDefaults.standardUserDefaults().valueForKey("street") as? String
        
        self.nameArray = NSUserDefaults.standardUserDefaults().valueForKey("name2") as? NSMutableArray
        self.phoneArray = NSUserDefaults.standardUserDefaults().objectForKey("phone2") as? NSMutableArray
        self.addressArray = NSUserDefaults.standardUserDefaults().objectForKey("address2") as? NSMutableArray
        self.address2Array = NSUserDefaults.standardUserDefaults().objectForKey("address22") as? NSMutableArray
        self.address3Array = NSUserDefaults.standardUserDefaults().objectForKey("address222") as? NSMutableArray
        name1 = nameArray?.objectAtIndex(index!) as? String
        phone1 = phoneArray?.objectAtIndex(index!) as? String
        address1 = addressArray?.objectAtIndex(index!) as? String
        address2 = address2Array?.objectAtIndex(index!) as? String
        address3 = address3Array?.objectAtIndex(index!) as? String
        self.navigationItem.title = "修改地址"
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
        //lab1?.backgroundColor = UIColor.redColor()
        self.view.addSubview(lab1!)
        text1 = UITextField(frame: CGRect(x: 110, y: 80, width: 300, height: 24))
        text1?.textColor = UIColor.lightGrayColor()
        text1?.font = UIFont(name: "Arial", size: 17)
        text1?.addTarget(self, action: "click1:", forControlEvents: UIControlEvents.TouchDown)
        text1?.text = name1
        text1?.delegate = self
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
        text2?.text = phone1
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
        lab4?.text = address1
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
        text3?.text = self.address2
        text3?.delegate = self
        text3?.addTarget(self, action: "click3:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(text3!)
        line2 = UIImageView(frame: CGRect(x: 0, y: 261, width: self.view.bounds.width, height: 1))
        line2?.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(line2!)
        self.setupTextView()
        
      
        
        self.province1 = NSUserDefaults.standardUserDefaults().valueForKey("province") as? String
        self.city1 = NSUserDefaults.standardUserDefaults().valueForKey("city") as? String
        self.area1 = NSUserDefaults.standardUserDefaults().valueForKey("area") as? String
        self.street1 = NSUserDefaults.standardUserDefaults().valueForKey("street") as? String
        
        
        imageBg1 = UIImageView(frame: CGRect(x: 0, y: 360, width: self.view.bounds.width, height: 50))
        imageBg1?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(imageBg1!)
        deleteLabel = UILabel(frame: CGRect(x: 10, y: 375, width: 80, height: 20))
        deleteLabel?.text = "删除地址"
        self.view.addSubview(deleteLabel!)
        imageBg1?.userInteractionEnabled = true
        deleteTap = UITapGestureRecognizer(target: self, action: "delete1")
        imageBg1?.addGestureRecognizer(deleteTap!)
        
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


    
    func delete1()
    {
        alert.title = "提示"
        alert.message = "确定要删除吗?"
        alert.addButtonWithTitle("取消")
        alert.addButtonWithTitle("确定")
        alert.cancelButtonIndex = 0
        alert.delegate = self
        alert.show()

    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(buttonIndex == 0)
        {
            return
            
        }
        else
        {
            tempNameArray = NSUserDefaults.standardUserDefaults().objectForKey("name2") as? NSArray
            mutableNameArray = tempNameArray?.mutableCopy() as? NSMutableArray
            mutableNameArray?.removeObjectAtIndex((self.index)!)
            NSUserDefaults.standardUserDefaults().setObject(mutableNameArray, forKey: "name2")
            myaddress?.nameArray = mutableNameArray
            NSLog("mutableNameArray\(mutableNameArray)")
            
            tempPhoneArray = NSUserDefaults.standardUserDefaults().objectForKey("phone2") as? NSArray
            mutablePhoneArray = tempPhoneArray?.mutableCopy() as? NSMutableArray
            mutablePhoneArray?.removeObjectAtIndex((self.index)!)
            NSUserDefaults.standardUserDefaults().setObject(mutablePhoneArray, forKey: "phone2")
            myaddress?.phoneArray = mutablePhoneArray
            NSLog("mutablePhoneArray\(mutablePhoneArray)")
            
            
            tempAddress1Array = NSUserDefaults.standardUserDefaults().objectForKey("address2") as? NSArray
            mutableAddress1Array = tempAddress1Array?.mutableCopy() as? NSMutableArray
            mutableAddress1Array?.removeObjectAtIndex((self.index)!)
            NSUserDefaults.standardUserDefaults().setObject(mutableAddress1Array, forKey: "address2")
            myaddress?.addressArray = mutableAddress1Array
            NSLog("mutableAddress1Array\(mutableAddress1Array)")
            
            
            tempAddress2Array = NSUserDefaults.standardUserDefaults().objectForKey("address22") as? NSArray
            mutableAddress2Array = tempAddress2Array?.mutableCopy() as? NSMutableArray
            mutableAddress2Array?.removeObjectAtIndex((self.index)!)
            NSUserDefaults.standardUserDefaults().setObject(mutableAddress2Array, forKey: "address22")
            NSUserDefaults.standardUserDefaults().synchronize()
            myaddress?.address1Array = mutableAddress2Array
            NSLog("mutableAddress3Array\(mutableAddress2Array)")
            
            
            tempAddress3Array = NSUserDefaults.standardUserDefaults().objectForKey("address222") as? NSArray
            mutableAddress3Array = tempAddress3Array?.mutableCopy() as? NSMutableArray
            mutableAddress3Array?.removeObjectAtIndex((self.index)!)
            NSUserDefaults.standardUserDefaults().setObject(mutableAddress3Array, forKey: "address222")
            NSUserDefaults.standardUserDefaults().synchronize()
            myaddress?.address2Array = mutableAddress3Array
            NSLog("mutableAddress3Array\(mutableAddress3Array)")

            
            
            //self.navigationController?.pushViewController(HomeViewController(), animated: true)
            
            
            
        }
    }

    func save()
    {
        tempNameArray = NSUserDefaults.standardUserDefaults().objectForKey("name2") as? NSArray
        mutableNameArray = tempNameArray?.mutableCopy() as? NSMutableArray
        mutableNameArray?.removeObjectAtIndex((self.index)!)
        Namestring = text1?.text
        NSLog("Namestring\(Namestring)")
        mutableNameArray?.insertObject(Namestring!, atIndex: (self.index)!)
        NSUserDefaults.standardUserDefaults().setObject(mutableNameArray, forKey: "name2")
        NSUserDefaults.standardUserDefaults().synchronize()
        myaddress?.nameArray = mutableNameArray
        NSLog("mutableNameArray\(mutableNameArray)")
        
        
        tempPhoneArray = NSUserDefaults.standardUserDefaults().objectForKey("phone2") as? NSArray
        mutablePhoneArray = tempPhoneArray?.mutableCopy() as? NSMutableArray
        mutablePhoneArray?.removeObjectAtIndex((self.index)!)
        Phonestring = text2?.text
        mutablePhoneArray?.insertObject(Phonestring!, atIndex: (self.index)!)
        NSUserDefaults.standardUserDefaults().setObject(mutablePhoneArray, forKey: "phone2")
        NSUserDefaults.standardUserDefaults().synchronize()
        myaddress?.phoneArray = mutablePhoneArray
        NSLog("mutablePhoneArray\(mutablePhoneArray)")
        
        tempAddress1Array = NSUserDefaults.standardUserDefaults().objectForKey("address2") as? NSArray
        mutableAddress1Array = tempAddress1Array?.mutableCopy() as? NSMutableArray
        mutableAddress1Array?.removeObjectAtIndex((self.index)!)
        Address1string = (self.lab4!.text)
        mutableAddress1Array?.insertObject(Address1string!, atIndex: (self.index)!)
        NSUserDefaults.standardUserDefaults().setObject(mutableAddress1Array, forKey: "address2")
        NSUserDefaults.standardUserDefaults().synchronize()
        myaddress?.addressArray = mutableAddress1Array
        NSLog("mutableAddress1Array\(mutableAddress1Array)")
        
        
        tempAddress2Array = NSUserDefaults.standardUserDefaults().objectForKey("address22") as? NSArray
        mutableAddress2Array = tempAddress2Array?.mutableCopy() as? NSMutableArray
        mutableAddress2Array?.removeObjectAtIndex((self.index)!)
        Address2string = self.text3?.text
        mutableAddress2Array?.insertObject(Address2string!, atIndex: 0)
        NSUserDefaults.standardUserDefaults().setObject(mutableAddress2Array, forKey: "address22")
        NSUserDefaults.standardUserDefaults().synchronize()
        myaddress?.address1Array = mutableAddress2Array
        NSLog("mutableAddress3Array\(mutableAddress2Array)")
        
        
        tempAddress3Array = NSUserDefaults.standardUserDefaults().objectForKey("address222") as? NSArray
        mutableAddress3Array = tempAddress3Array?.mutableCopy() as? NSMutableArray
        mutableAddress3Array?.removeObjectAtIndex((self.index)!)
        Address3string = self.textView?.text
        mutableAddress2Array?.insertObject(Address3string!, atIndex: 0)
        NSUserDefaults.standardUserDefaults().setObject(mutableAddress3Array, forKey: "address222")
        NSUserDefaults.standardUserDefaults().synchronize()
        myaddress?.address2Array = mutableAddress3Array
        NSLog("mutableAddress3Array\(mutableAddress3Array)")
        
        
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
        self.textView?.text = self.address3
        
        //        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange", name: UITextViewTextDidChangeNotification, object: textView)
        
    }
    func click1()
    {
        self.textView!.resignFirstResponder()
        
        NSLog("321")
    }
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
