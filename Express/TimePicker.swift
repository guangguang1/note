//
//  TimePicker.swift
//
//
//  Created by 梁慧广 on 16/3/30.
//
//

import UIKit

class TimePicker: UIView,UIPickerViewDataSource,UIPickerViewDelegate {
    
    typealias TimeChoicePickerViewBlock = (view:TimePicker,obj:AreaObject)->()
    @IBOutlet var contentViewHeightCons: NSLayoutConstraint!
    @IBOutlet var pickerView: UIPickerView!
    var year = ["2016","2017","2018"]
    var month = ["1","2","3"]
    var day = ["1","2","3","4","5","6"]
    var time1 = ["9:00-11:00","11:00-13:00","13:00-15:00"]
    var block: TimeChoicePickerViewBlock?
    var stringYear: String?
    var stringMonth: String?
    var stringDay: String?
    var stringTime: String?
    var express: ExpressNormalView1Controller?
    
    
    
    var tempNoteArray1: NSArray?
    var mutableNoteArray1: NSMutableArray?
    var textstring1: NSString?
    var textstring2: NSString?
    var textstring3: NSString?
    var textstring4: NSString?
    var tempDateArray1: NSArray?
    var mutableDateArray1: NSMutableArray?
    var tempDetailArray1: NSArray?
    var mutableDetailArray1: NSMutableArray?
    var tempHourArray1: NSArray?
    var mutableHourArray1: NSMutableArray?
    
    
    class func creatAddressChoicePickView()->TimePicker{
        let v :TimePicker =  (NSBundle.mainBundle().loadNibNamed("TimeChoicePickerView", owner: nil, options: nil).first as? TimePicker)!;
        v.frame = UIScreen.mainScreen().bounds
        v.pickerView.delegate = v;
        v.pickerView.dataSource = v;
        return v;
    }
    
    
    @IBAction func cancel111(sender: UIButton) {
        self.hidden = true
    }
    @IBAction func confirm(sender: UIButton) {
        self.hidden = true
        
        tempNoteArray1 = NSUserDefaults.standardUserDefaults().objectForKey("year") as? NSArray
        mutableNoteArray1 = tempNoteArray1?.mutableCopy() as? NSMutableArray
        mutableNoteArray1 = ["1"]
        textstring1 = (self.stringYear)
        mutableNoteArray1?.insertObject(textstring1!, atIndex: 0)
        NSUserDefaults.standardUserDefaults().setObject(mutableNoteArray1, forKey: "year")
        NSUserDefaults.standardUserDefaults().synchronize()
        express?.yearnum = mutableNoteArray1
        
        
        tempDateArray1 = NSUserDefaults.standardUserDefaults().objectForKey("month") as? NSArray
        mutableDateArray1 = tempDateArray1?.mutableCopy() as? NSMutableArray
        mutableDateArray1 = ["1"]
        textstring2 = (self.stringMonth)
        mutableDateArray1?.insertObject(textstring2!, atIndex: 0)
        NSUserDefaults.standardUserDefaults().setObject(mutableDateArray1, forKey: "month")
        NSUserDefaults.standardUserDefaults().synchronize()
        express?.monthnum = mutableDateArray1
        
        
        
        tempDetailArray1 = NSUserDefaults.standardUserDefaults().objectForKey("day") as? NSArray
        mutableDetailArray1 = tempDetailArray1?.mutableCopy() as? NSMutableArray
        mutableDetailArray1 = ["1"]
        textstring3 = (self.stringDay)
        mutableDetailArray1?.insertObject(textstring3!, atIndex: 0)
        NSUserDefaults.standardUserDefaults().setObject(mutableDetailArray1, forKey: "day")
        NSUserDefaults.standardUserDefaults().synchronize()
        express?.daynum = mutableDetailArray1
        
        tempHourArray1 = NSUserDefaults.standardUserDefaults().objectForKey("hour") as? NSArray
        mutableHourArray1 = tempHourArray1?.mutableCopy() as? NSMutableArray
        mutableHourArray1 = ["1"]
        mutableHourArray1 = ["2015"]
        textstring4 = (self.stringTime)
        mutableHourArray1?.insertObject(textstring4!, atIndex: 0)
        NSUserDefaults.standardUserDefaults().setObject(mutableHourArray1, forKey: "hour")
        NSUserDefaults.standardUserDefaults().synchronize()
        express?.hournum = mutableHourArray1
        
        
        
    }
    
    
    func show(){
        let w:UIWindow? = UIApplication.sharedApplication().keyWindow;
        let topView:UIView? = w!.subviews.first as? UIView;
        topView!.addSubview(self);
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.contentViewHeightCons.constant = 250.0;
            self.layoutIfNeeded();
        });
        
    }
    
    func create()
    {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 4
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if component == 0
        {
            return year.count
        }
        else if component == 1
        {
            return month.count
        }
        else if component == 2
        {
            return day.count
        }
        else
        {
            return time1.count
        }
        
    }
    
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0
        {
            
            stringYear = year[row]
            
        }
        else if component == 1
        {
            stringMonth = month[row]
            
        }
        else if component == 2
        {
            stringDay = day[row]
        }
        else
        {
            stringTime = time1[row]
            NSLog("\( stringTime )")
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == 0
        {
            return year[row]
        }
        else if component == 1
        {
            return month[row]
        }
        else if component == 2
        {
            return day[row]
        }
        else
        {
            return time1[row]
        }
        
    }
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0
        {
            return 70
        }
        else if component == 1
        {
            return 60
        }
        else if component == 2
        {
            return 50
        }
        else
        {
            return 140
        }
        
    }
    
    
}
