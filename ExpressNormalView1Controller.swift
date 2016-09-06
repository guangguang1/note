//
//  ExpressNormalViewController.swift
//
//
//  Created by 梁慧广 on 16/3/30.
//
//

import UIKit

class ExpressNormalView1Controller: UIViewController,UITextFieldDelegate{
    
    var gbView1: UIImageView?
    var gbView2: UIImageView?
    var gbView3: UIImageView?
    var smallimage1: UIImageView?
    var smallimage2: UIImageView?
    var smallimage3: UIImageView?
    var smallimage4: UIImageView?
    var smallimage5: UIImageView?
    var smallimage6: UIImageView?
    var smallimage7: UIImageView?
    var lineImage1: UIImageView?
    var lineImage2: UIImageView?
    var lineImage3: UIImageView?
    var lineImage4: UIImageView?
    var lineImage5: UIImageView?
    var lineImage6: UIImageView?
    var regionArr : NSArray?
    var text: UITextField?
    var stringYear: String?
    var stringMonth: String?
    var stringDay: String?
    var stringTime: String?
    var redBtn: UIButton?
    var questionButton: UIButton?
    var questionLabel: UILabel?
    var peopleLab: UILabel?
    var peopleLab1: UILabel?
    var peopleBtn: UIButton?
    var peopleBtn1: UIButton?
    var timeImageView: UIImageView?
    var timeLabel: UILabel?
    var gesture: UITapGestureRecognizer?
    var timepick: TimePicker?
    var yearnum: NSMutableArray?
    var note1: String?
    var monthnum: NSMutableArray?
    var note2: String?
    var daynum: NSMutableArray?
    var note3: String?
    var hournum: NSMutableArray?
    var note4: String?
    var placeChooseLabel: UILabel?
    var placeChooseLabel1: UILabel?
    var placeTextField1: UITextField?
    var placeTextField2: UITextField?
    var nameTextField1: UITextField?
    var nameTextField2: UITextField?
    var phoneTextField1: UITextField?
    var phoneTextField2: UITextField?
    var placeGestrue1: UITapGestureRecognizer?
    var placeGestrue2: UITapGestureRecognizer?
    var tapGestrue: UITapGestureRecognizer?
    var index:Int?
    var index1:Int?
    var nameArray:NSMutableArray?
    var phoneArray:NSMutableArray?
    var addressArray:NSMutableArray?
    var address2Array:NSMutableArray?
    var address3Array:NSMutableArray?
    var phone1:String?
    var name1:String?
    var address1:String?
    var address2:String?
    var address3:String?
    var phone11:String?
    var name11:String?
    var address11:String?
    var address12:String?
    var address13:String?
    var jiImage:UIImageView?
    var shouImage:UIImageView?
    var Name1Image:UIImageView?
    var Name2Image:UIImageView?
    var Phone1Image:UIImageView?
    var Phone2Image:UIImageView?
    var pro1:String?
    var pro2:String?
    var pro3:String?
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths.first! as! String
        }()
    
    var db: COpaquePointer = nil
    var stmt: COpaquePointer = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.index = NSUserDefaults.standardUserDefaults().valueForKey("rowNumber") as? Int
        self.index1 = NSUserDefaults.standardUserDefaults().valueForKey("rowNumber1") as? Int
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
        name11 = nameArray?.objectAtIndex(index1!) as? String
        phone11 = phoneArray?.objectAtIndex(index1!) as? String
        address11 = addressArray?.objectAtIndex(index1!) as? String
        address12 = address2Array?.objectAtIndex(index1!) as? String
        address13 = address3Array?.objectAtIndex(index1!) as? String
        NSLog("name11\(address2)")
        
        self.yearnum = NSUserDefaults.standardUserDefaults().valueForKey("year") as? NSMutableArray
        note1 = yearnum!.objectAtIndex(0) as? String
        self.monthnum = NSUserDefaults.standardUserDefaults().valueForKey("month") as? NSMutableArray
        note2 = monthnum!.objectAtIndex(0) as? String
        self.daynum = NSUserDefaults.standardUserDefaults().valueForKey("day") as? NSMutableArray
        note3 = daynum!.objectAtIndex(0) as? String
        self.hournum = NSUserDefaults.standardUserDefaults().valueForKey("hour") as? NSMutableArray
        note4 = hournum!.objectAtIndex(0) as? String
        
        
        self.title = "寄快递"
        self.view.backgroundColor = UIColor(red: 220/255, green:  220/255, blue:  220/255, alpha: 1)
        
        
        gbView1 = UIImageView(frame: CGRect(x: 0, y: 170, width: self.view.bounds.width, height: 160))
        gbView1?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(gbView1!)
        gbView2 = UIImageView(frame: CGRect(x: 0, y: 370, width: self.view.bounds.width, height: 160))
        gbView2?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(gbView2!)
        gbView3 = UIImageView(frame: CGRect(x: 0, y: 570, width: self.view.bounds.width, height: 95))
        gbView3?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(gbView3!)
        
        
        lineImage1 = UIImageView(frame: CGRect(x: 50, y: 210, width: self.view.bounds.width - 50, height: 1))
        lineImage1?.backgroundColor = UIColor(red: 220/255, green:  220/255, blue:  220/255, alpha: 1)
        self.view.addSubview(lineImage1!)
        lineImage2 = UIImageView(frame: CGRect(x: 0, y: 250, width: self.view.bounds.width, height: 1))
        lineImage2?.backgroundColor = UIColor(red: 220/255, green:  220/255, blue:  220/255, alpha: 1)
        self.view.addSubview(lineImage2!)
        lineImage3 = UIImageView(frame: CGRect(x: 0, y: 290, width: self.view.bounds.width, height: 1))
        lineImage3?.backgroundColor = UIColor(red: 220/255, green:  220/255, blue:  220/255, alpha: 1)
        self.view.addSubview(lineImage3!)
        lineImage4 = UIImageView(frame: CGRect(x: 50, y: 410, width: self.view.bounds.width - 50, height: 1))
        lineImage4?.backgroundColor = UIColor(red: 220/255, green:  220/255, blue:  220/255, alpha: 1)
        self.view.addSubview(lineImage4!)
        lineImage5 = UIImageView(frame: CGRect(x: 0, y: 450, width: self.view.bounds.width, height: 1))
        lineImage5?.backgroundColor = UIColor(red: 220/255, green:  220/255, blue:  220/255, alpha: 1)
        self.view.addSubview(lineImage5!)
        lineImage6 = UIImageView(frame: CGRect(x: 0, y: 490, width: self.view.bounds.width, height: 1))
        lineImage6?.backgroundColor = UIColor(red: 220/255, green:  220/255, blue:  220/255, alpha: 1)
        self.view.addSubview(lineImage6!)
        
        
        text = UITextField(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        text?.backgroundColor = UIColor.redColor()
        
        
        redBtn = UIButton(frame: CGRect(x: 20, y: 610, width: self.view.bounds.width - 40, height: 45))
        redBtn?.backgroundColor = UIColor.redColor()
        redBtn?.addTarget(self, action: "commitClick", forControlEvents: UIControlEvents.TouchDown)
        redBtn?.setTitle("我要寄件", forState: UIControlState.Normal)
        redBtn?.titleLabel?.font = UIFont.boldSystemFontOfSize(22)
        redBtn?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.view.addSubview(redBtn!)
        
        
        questionLabel = UILabel(frame: CGRect(x: 60, y: 580, width: 250, height: 20))
        questionLabel?.text = "寄件费参考：首重12元，续重8元"
        questionLabel?.textColor = UIColor.orangeColor()
        questionLabel?.font = UIFont.boldSystemFontOfSize(15)
        self.view.addSubview(questionLabel!)
        questionButton = UIButton(frame: CGRect(x: 290, y: 580, width: 20, height: 20))
        questionButton?.backgroundColor = UIColor.lightGrayColor()
        questionButton?.setTitle("?", forState: UIControlState.Normal)
        questionButton?.addTarget(self, action: "question", forControlEvents: UIControlEvents.TouchDown)
        questionButton?.layer.cornerRadius = 10
        self.view.addSubview(questionButton!)
        
        
        peopleLab = UILabel(frame: CGRect(x: 20, y: 140, width: 100, height: 20))
        peopleLab?.text = "寄件人信息"
        peopleLab?.textColor = UIColor.grayColor()
        peopleLab?.font = UIFont(name: "Heiti SC", size: 13)
        self.view.addSubview(peopleLab!)
        peopleLab = UILabel(frame: CGRect(x: 20, y: 340, width: 100, height: 20))
        peopleLab?.text = "收件人信息"
        peopleLab?.textColor = UIColor.grayColor()
        peopleLab?.font = UIFont(name: "Heiti SC", size: 13)
        self.view.addSubview(peopleLab!)
        peopleBtn = UIButton(frame: CGRect(x: 340, y: 140, width: 20, height: 20))
        peopleBtn?.addTarget(self, action: "address", forControlEvents: UIControlEvents.TouchDown)
        peopleBtn?.backgroundColor = UIColor.grayColor()
        peopleBtn?.setImage(UIImage(named: "place"), forState: UIControlState.Normal)
        self.view.addSubview(peopleBtn!)
        peopleBtn1 = UIButton(frame: CGRect(x: 340, y: 340, width: 20, height: 20))
        peopleBtn1?.addTarget(self, action: "address111", forControlEvents: UIControlEvents.TouchDown)
        peopleBtn1?.backgroundColor = UIColor.grayColor()
        peopleBtn1?.setImage(UIImage(named: "place"), forState: UIControlState.Normal)
        self.view.addSubview(peopleBtn1!)
        
        
        timeImageView = UIImageView(frame: CGRect(x: 0, y: 60, width: self.view.bounds.width, height: 60))
        timeImageView?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(timeImageView!)
        timeImageView?.userInteractionEnabled = true
        timeLabel = UILabel(frame: CGRect(x: 50, y: 75, width: 300, height: 30))
        timeLabel?.userInteractionEnabled = true
        self.timeLabel?.text = "时间选择：" + note1! + "-" + note2! + "-" + note3! + "-" + note4!
        self.view.addSubview(timeLabel!)
        gesture = UITapGestureRecognizer(target: self, action: "dropDown")
        self.timeLabel?.addGestureRecognizer(gesture!)
        
        
        
        placeChooseLabel = UILabel(frame: CGRect(x: 50, y: 175, width: self.view.bounds.width - 50, height: 30))
        placeChooseLabel?.text = self.address1
        placeChooseLabel?.userInteractionEnabled = true
        self.view.addSubview(placeChooseLabel!)
        placeGestrue1 = UITapGestureRecognizer(target: self, action: "placeChoose")
        self.placeChooseLabel?.addGestureRecognizer(placeGestrue1!)
        placeChooseLabel1 = UILabel(frame: CGRect(x: 50, y: 375, width: self.view.bounds.width - 50, height: 30))
        placeChooseLabel1?.text = self.address11
        placeChooseLabel1?.userInteractionEnabled = true
        self.view.addSubview(placeChooseLabel1!)
        placeGestrue2 = UITapGestureRecognizer(target: self, action: "placeChoose1")
        self.placeChooseLabel1?.addGestureRecognizer(placeGestrue2!)
        placeTextField1 = UITextField(frame: CGRect(x: 50, y: 215, width: self.view.bounds.width - 50, height: 30))
        placeTextField1?.placeholder = "补充详细地址"
        placeTextField1?.text = self.address2! + self.address3!
        placeTextField1?.addTarget(self, action: "TextFieldClick:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(placeTextField1!)
        placeTextField2 = UITextField(frame: CGRect(x: 50, y: 415, width: self.view.bounds.width - 50, height: 30))
        placeTextField2?.placeholder = "补充详细地址"
        placeTextField2?.text = self.address12! + self.address13!
        NSUserDefaults.standardUserDefaults().setValue(placeTextField2?.text, forKey: "RA")
        placeTextField2?.addTarget(self, action: "TextFieldClick1:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(placeTextField2!)
        nameTextField1 = UITextField(frame: CGRect(x: 50, y: 255, width: self.view.bounds.width - 50, height: 30))
        nameTextField1?.placeholder = "寄件人姓名"
        nameTextField1?.text = self.name1
        nameTextField1?.addTarget(self, action: "TextFieldClick2:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(nameTextField1!)
        nameTextField2 = UITextField(frame: CGRect(x: 50, y: 455, width: self.view.bounds.width - 50, height: 30))
        nameTextField2?.placeholder = "收件人姓名"
        nameTextField2?.text = self.name11
        NSUserDefaults.standardUserDefaults().setValue(nameTextField2?.text, forKey: "RN")
        nameTextField2?.addTarget(self, action: "TextFieldClick3:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(nameTextField2!)
        phoneTextField1 = UITextField(frame: CGRect(x: 50, y: 295, width: self.view.bounds.width - 50, height: 30))
        phoneTextField1?.placeholder = "寄件人电话"
        phoneTextField1?.text = self.phone1
        phoneTextField1?.keyboardType = UIKeyboardType.NumberPad
        phoneTextField1?.addTarget(self, action: "TextFieldClick4:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(phoneTextField1!)
        phoneTextField2 = UITextField(frame: CGRect(x: 50, y: 495, width: self.view.bounds.width - 50, height: 30))
        phoneTextField2?.keyboardType = UIKeyboardType.NumberPad
        phoneTextField2?.placeholder = "收件人电话"
        phoneTextField2?.text = self.phone11
        phoneTextField2?.addTarget(self, action: "TextFieldClick5:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(phoneTextField2!)
        
        
        placeTextField1?.delegate = self
        placeTextField2?.delegate = self
        nameTextField1?.delegate = self
        nameTextField2?.delegate = self
        phoneTextField1?.delegate = self
        phoneTextField2?.delegate = self
        tapGestrue = UITapGestureRecognizer(target: self, action: "click")
        self.view.addGestureRecognizer(tapGestrue!)
        
        
        jiImage = UIImageView(frame: CGRect(x: 20, y: 183, width: 20, height: 20))
        jiImage?.backgroundColor = UIColor.redColor()
        jiImage?.image = UIImage(named: "ji")
        self.view.addSubview(jiImage!)
        shouImage = UIImageView(frame: CGRect(x: 20, y: 383, width: 20, height: 20))
        shouImage?.backgroundColor = UIColor.redColor()
        shouImage?.image = UIImage(named: "shou")
        self.view.addSubview(shouImage!)
        Name1Image = UIImageView(frame: CGRect(x: 20, y: 263, width: 20, height: 20))
        Name1Image?.backgroundColor = UIColor.redColor()
        Name1Image?.image = UIImage(named: "name")
        self.view.addSubview(Name1Image!)
        Name2Image = UIImageView(frame: CGRect(x: 20, y: 463, width: 20, height: 20))
        Name2Image?.backgroundColor = UIColor.redColor()
        Name2Image?.image = UIImage(named: "name")
        self.view.addSubview(Name2Image!)
        Phone1Image = UIImageView(frame: CGRect(x: 20, y: 303, width: 20, height: 20))
        Phone1Image?.backgroundColor = UIColor.redColor()
        Phone1Image?.image = UIImage(named: "phone")
        self.view.addSubview(Phone1Image!)
        Phone2Image = UIImageView(frame: CGRect(x: 20, y: 503, width: 20, height: 20))
        Phone2Image?.backgroundColor = UIColor.redColor()
        Phone2Image?.image = UIImage(named: "phone")
        self.view.addSubview(Phone2Image!)
        
//        createDatabase()
//        createTable()
        //insertPrice("顺丰", addName1: "上海", addName2: "广西", price: 10.0)
        pro1 = NSUserDefaults.standardUserDefaults().valueForKey("pro1") as? String
        pro2 = NSUserDefaults.standardUserDefaults().valueForKey("pro2") as? String
        pro3 = NSUserDefaults.standardUserDefaults().valueForKey("addressExpress") as? String
        NSLog("pro1\(pro1)")
        NSLog("pro2\(pro2)")
        NSLog("pro3\(pro3)")
        //selectaddress1(pro2!, add2: pro1!)
    }
    func address()
    {
        self.navigationController?.pushViewController(NewAddress1ViewController(), animated: true)
    }
    func address111()
    {
        self.navigationController?.pushViewController(NewAddress2ViewController(), animated: true)
    }
    
    func click()
    {
        NSLog("1234")
        self.placeTextField1!.resignFirstResponder()
        self.placeTextField2!.resignFirstResponder()
        self.nameTextField1!.resignFirstResponder()
        self.nameTextField2!.resignFirstResponder()
        self.phoneTextField1!.resignFirstResponder()
        self.phoneTextField2!.resignFirstResponder()
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        var frame:CGRect = textField.frame
        var offset = frame.origin.y + 80 - (self.view.bounds.height - 216.0)
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
        NSLog("11")
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        NSLog("1")
        self.view.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
    }
    
    
    
    func question()
    {
        
        self.navigationController?.pushViewController(QuestionViewController(), animated: true)
    }
    
    
    func TextFieldClick(sender: UITextField)
    {
        sender.resignFirstResponder()
        
    }
    func TextFieldClick1(sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    func TextFieldClick2(sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    func TextFieldClick3(sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    func TextFieldClick4(sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    func TextFieldClick5(sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    
    
    
    func placeChoose1()//下
    {
        let addressPickerView:AddressChoicePickerView = AddressChoicePickerView.creatAddressChoicePickView();
        addressPickerView.show();
        addressPickerView.block = {
            (view:AddressChoicePickerView,obj:AreaObject) in
            self.placeChooseLabel1!.text = "";
            self.placeChooseLabel1!.text = obj.province!+" "+obj.city!+" "+obj.area!;
            
            NSUserDefaults.standardUserDefaults().setObject(obj.province, forKey: "pro1")
            return Void()
            
        };
    }
    func placeChoose()//上
    {
        let addressPickerView:AddressChoicePickerView = AddressChoicePickerView.creatAddressChoicePickView();
        addressPickerView.show();
        addressPickerView.block = {
            (view:AddressChoicePickerView,obj:AreaObject) in
            self.placeChooseLabel!.text = "";
            self.placeChooseLabel!.text = obj.province!+" "+obj.city!+" "+obj.area!;
            
            NSUserDefaults.standardUserDefaults().setObject(obj.province, forKey: "pro2")
            NSUserDefaults.standardUserDefaults().setObject(obj.province! + obj.city! + obj.area!, forKey: "addressExpress")
            return Void()
            
        };
    }
    
    
    func dropDown()
    {
        
        let timePickerView:TimePicker = TimePicker.creatAddressChoicePickView();
        timePickerView.show();
        
        
    }
    
    
    func commitClick()
    {
        var VC2 = PCommitViewController()
        
        self.navigationController?.pushViewController(VC2, animated: true)
    }
    
    
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



