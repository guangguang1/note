//
//  AddressChoicePickerView1.swift
//  
//
//  Created by 梁慧广 on 16/4/9.
//
//

import UIKit

class AddressChoicePickerView1: UIView,UIPickerViewDataSource,UIPickerViewDelegate {
    

    typealias AddressChoicePickerViewBlock = (view:AddressChoicePickerView1,obj:AreaObject)->()
    @IBOutlet weak var contentViewHegithCons: NSLayoutConstraint!
    @IBOutlet weak var pickView: UIPickerView!
    var locate:AreaObject1? = AreaObject1()
    //区域 数组
    var  regionArr: NSArray?
    //省 数组
    var  provinceArr: NSArray?
    //城市 数组
    var  cityArr: NSArray?
    //区县 数组
    var  areaArr: NSArray?
    //街道 数组
    var  streetArr: NSArray?
    
    var block:AddressChoicePickerViewBlock?
    
    //这里有待修改
    
    class func creatAddressChoicePickView()->AddressChoicePickerView1{
        let v :AddressChoicePickerView1 =  (NSBundle.mainBundle().loadNibNamed("AddressChoicePickerView1", owner: nil, options: nil).first as? AddressChoicePickerView1)!;
        v.frame = UIScreen.mainScreen().bounds
        v.pickView.delegate = v;
        v.pickView.dataSource = v;
        v.regionArr = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("AreaPlist1.plist", ofType: nil)!)
        v.provinceArr = v.regionArr!.firstObject!.objectForKey("provinces") as? NSArray;
        
        v.cityArr = v.provinceArr!.firstObject!.objectForKey("cities") as? NSArray;
        v.areaArr = v.cityArr!.firstObject!.objectForKey("areas") as? NSArray;
        v.streetArr = v.areaArr!.firstObject!.objectForKey("streets") as? NSArray;
        
        v.locate!.region = v.regionArr!.firstObject!.objectForKey("region") as? String;
        v.locate!.province = v.provinceArr!.firstObject!.objectForKey("province") as? String;
        v.locate!.city = v.cityArr!.firstObject!.objectForKey("city") as? String;
        v.locate!.area = v.areaArr!.firstObject!.objectForKey("arear") as? String;
        if (v.streetArr!.count > 0)
        {
            v.locate!.street = v.streetArr?.firstObject as? String;
        }
        else
        {
            v.locate!.street = "";
        }
        v.customView();
        var  plistPath = NSBundle.mainBundle().pathForResource("AreaPlist1", ofType: "plist")
        NSLog("path\(plistPath)")
        return v;
    }
    
    
    func customView(){
        self.contentViewHegithCons.constant = 0;
        self.layoutIfNeeded();
    }
    
    
    //MARK: - action
    @IBAction func finishAction(sender: UIButton) {
        if(self.block != nil){
            //self.block!(view: self,obj: self.locate!);
        }
        self.hide()
    }
    
    @IBAction func cancelAction(sender: UIButton) {
        self.hide()
    }
    
    //MARK: - function
    func show(){
        let w:UIWindow? = UIApplication.sharedApplication().keyWindow;
        let topView:UIView? = w!.subviews.first as? UIView;
        topView!.addSubview(self);
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.contentViewHegithCons.constant = 250.0;
            self.layoutIfNeeded();
        });
        
    }
    
    func hide(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.alpha = 0;
            self.contentViewHegithCons.constant = 0;
            self.layoutIfNeeded();
            }) { (Bool yes) -> Void in
                if yes{
                    self.removeFromSuperview();
                }
        };
        
    }
    
    //MARK: - UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 5;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        switch (component) {
        case 0:
            return self.regionArr!.count;
            
        case 1:
            return self.provinceArr!.count;
            
        case 2:
            return self.cityArr!.count;
            
        case 3:
            return self.areaArr!.count;
            
        case 4:
            return self.streetArr!.count;

        default:
            return 0;
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        switch (component) {
        case 0:
            return self.regionArr!.objectAtIndex(row).objectForKey("region") as? String;
        case 1:
            return self.provinceArr!.objectAtIndex(row).objectForKey("province") as? String;
        case 2:
            return self.cityArr!.objectAtIndex(row).objectForKey("city") as? String;
        case 3:
            return self.areaArr!.objectAtIndex(row).objectForKey("area") as? String;
        case 4:
            return self.streetArr!.objectAtIndex(row) as? String;
        default:
            return  "";
            
        }
    }
    
    //MARK: - UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var l:UILabel? = view as? UILabel;
        if(l == nil ){
            l = UILabel();
            l?.minimumScaleFactor = 8.0;
            l?.textAlignment = .Center;
            l?.backgroundColor = UIColor.clearColor();
            l?.font = UIFont.systemFontOfSize(15);
            l?.adjustsFontSizeToFitWidth = true;
        }
        l?.text = self.pickerView(pickView, titleForRow: row, forComponent: component);
        return l!;
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(component == 0){
            
            self.provinceArr = self.regionArr!.objectAtIndex(row).objectForKey("provinces") as? NSArray;
            self.pickView.reloadComponent(1);
            self.pickView.selectRow(0, inComponent: 1, animated: true);
            
            self.cityArr = self.provinceArr!.objectAtIndex(0).objectForKey("cities") as? NSArray;
            self.pickView.reloadComponent(2);
            self.pickView.selectRow(0, inComponent: 2, animated: true);
            
            self.areaArr = self.cityArr?.objectAtIndex(0).objectForKey("areas") as? NSArray;
            self.pickView.reloadComponent(3);
            self.pickView.selectRow(0, inComponent: 3, animated: true);
            
            self.streetArr = self.areaArr?.objectAtIndex(0).objectForKey("streets") as? NSArray;
            self.pickView.reloadComponent(4);
            self.pickView.selectRow(0, inComponent: 4, animated: true);
            
            self.locate!.region = self.regionArr!.objectAtIndex(row).objectForKey("region") as? String;
            self.locate!.province = self.provinceArr!.objectAtIndex(row).objectForKey("province") as? String;
            self.locate!.city = self.cityArr?.objectAtIndex(0).objectForKey("city") as? String;
            self.locate!.area = self.areaArr?.objectAtIndex(0).objectForKey("area") as? String;
            
            if(self.streetArr!.count > 0){
                self.locate!.street = self.streetArr?.firstObject as? String;
            }else{
                self.locate!.street = "";
            }
            
        }else if(component == 1){
            self.cityArr = self.provinceArr!.objectAtIndex(row).objectForKey("cities") as? NSArray;
            self.pickView.reloadComponent(2);
            self.pickView.selectRow(0, inComponent: 2, animated: true);
            
            self.areaArr = self.cityArr!.objectAtIndex(0).objectForKey("areas") as? NSArray;
            self.pickView.reloadComponent(3);
            self.pickView.selectRow(0, inComponent: 3, animated: true);
            
            self.streetArr = self.areaArr?.objectAtIndex(0).objectForKey("streets") as? NSArray;
            self.pickView.reloadComponent(4);
            self.pickView.selectRow(0, inComponent: 4, animated: true);

            
            self.locate!.province = self.provinceArr?.objectAtIndex(row).objectForKey("province") as? String;
            self.locate!.city = self.cityArr!.objectAtIndex(0).objectForKey("city") as? String;
            self.locate!.area = self.areaArr?.objectAtIndex(0).objectForKey("area") as? String;
            
            if(self.streetArr!.count > 0){
                self.locate!.street = self.streetArr!.firstObject as? String;
            }else{
                self.locate!.street = "";
            }
            
        }
        else if(component == 2){
            self.areaArr = self.cityArr!.objectAtIndex(row).objectForKey("areas") as? NSArray;
            self.pickView.reloadComponent(3);
            self.pickView.selectRow(0, inComponent: 3, animated: true);
            
            self.streetArr = self.areaArr?.objectAtIndex(0).objectForKey("streets") as? NSArray;
            self.pickView.reloadComponent(4);
            self.pickView.selectRow(0, inComponent: 4, animated: true);
            
            self.locate!.city = self.cityArr?.objectAtIndex(0).objectForKey("city") as? String;
            self.locate!.area = self.areaArr?.objectAtIndex(0).objectForKey("area") as? String;
            
            if(self.streetArr!.count > 0){
                self.locate!.street = self.streetArr!.firstObject as? String;
            }else{
                self.locate!.street = "";
            }
            
        }
        else if(component == 3){
            self.streetArr = self.areaArr?.objectAtIndex(0).objectForKey("streets") as? NSArray;
            self.pickView.reloadComponent(4);
            self.pickView.selectRow(0, inComponent: 4, animated: true);
            
            self.locate!.area = self.areaArr?.objectAtIndex(0).objectForKey("area") as? String;

            if(self.streetArr!.count > 0){
                self.locate!.street = self.streetArr!.firstObject as? String;
            }else{
                self.locate!.street = "";
            }
        }
        else if(component == 4)
        {
            if(self.streetArr!.count > 0){
                self.locate!.street = self.streetArr!.firstObject as? String;
            }else{
                self.locate!.street = "";
            }

        }
    }
    

}
