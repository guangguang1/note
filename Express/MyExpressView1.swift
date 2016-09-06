//
//  MyExpressView.swift
//
//
//  Created by 梁慧广 on 16/4/5.
//
//

import UIKit

class MyExpressView1: UIView {
    
    
    var nameArray:NSMutableArray?
    var orderArray:NSMutableArray?
    var name1Array:NSMutableArray?
    var addNameArray:NSMutableArray?
    var timeArray:NSMutableArray?
    var stateArray:NSMutableArray?
    var priceArray:NSMutableArray?
    var orderArray1:NSArray
    var name:String?
    var order:String?
    var name1:String?
    var add:String?
    var time:String?
    var state:String?
    var price:String?
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths.first! as! String
        }()
    
    var db: COpaquePointer = nil
    var stmt: COpaquePointer = nil
    //let theArr: NSArray
    var theCB: (cur: Int)->(Void)
    var curValue: Int?
    init(frame: CGRect, isAutoHeight: Bool = false, clb: (cur: Int)->(Void)) {
        self.nameArray = NSUserDefaults.standardUserDefaults().valueForKey("OrderUsername") as? NSMutableArray
        self.orderArray = NSUserDefaults.standardUserDefaults().valueForKey("OrderNumber") as? NSMutableArray
        self.name1Array = NSUserDefaults.standardUserDefaults().valueForKey("Name1") as? NSMutableArray
        self.addNameArray = NSUserDefaults.standardUserDefaults().valueForKey("Add") as? NSMutableArray
        self.timeArray = NSUserDefaults.standardUserDefaults().valueForKey("Time") as? NSMutableArray
        
        self.stateArray = NSUserDefaults.standardUserDefaults().valueForKey("State") as? NSMutableArray
        self.priceArray = NSUserDefaults.standardUserDefaults().valueForKey("Price") as? NSMutableArray
        NSLog("priceArray\(priceArray)")
        orderArray1 = orderArray?.copy() as! NSArray
        self.theCB = clb
        super.init(frame: frame)
        isAutoHeight ? self.myView() : self.markViews()
        self.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func myView()
    {
        
        var curOriginX: CGFloat = 0.0
        var curOriginY: CGFloat = 10.0
        var lastView: UIView?
        var i = 0
        var j = 0
        NSLog("orderArray1.count\(orderArray1.count)")
        for j = 0; j < orderArray1.count; j++ {
            let tap = UITapGestureRecognizer.init(target: self, action: Selector("click1:"))
            let tap1 = UITapGestureRecognizer.init(target: self, action: Selector("click2:"))
            let imageView = UIImageView.init(frame:CGRectMake(curOriginX, curOriginY, self.frame.width, self.frame.height - 30))
            imageView.tag = i
            imageView.backgroundColor = UIColor.whiteColor()
            imageView.userInteractionEnabled = true
            imageView.addGestureRecognizer(tap)
            let line1 = UIImageView.init(frame:CGRectMake(0, 0, self.frame.width, 1))
            line1.backgroundColor = UIColor.lightGrayColor()
            
            
            
            let label1 = UILabel.init(frame:CGRectMake(10, 10, 200, 20))
            label1.backgroundColor = UIColor.grayColor()
            time = timeArray?.objectAtIndex(i) as? String
            NSLog("time\(time)")
            label1.text = time
            
            
            
            let label2 = UILabel.init(frame:CGRectMake(280, 10, 100, 20))
            label2.backgroundColor = UIColor.grayColor()
            state = stateArray?.objectAtIndex(i) as? String
            label2.text = state
            
            
            let image = UIImageView.init(frame:CGRectMake(10, 40, 20, 20))
            image.backgroundColor = UIColor.grayColor()
            
            
            
            let label3 = UILabel.init(frame:CGRectMake(50, 40, 60, 20))
            label3.backgroundColor = UIColor.grayColor()
            name1 = name1Array?.objectAtIndex(i) as? String
            label3.text = name1
            
            
            let label4 = UILabel.init(frame:CGRectMake(120, 40, 200, 20))
            label4.backgroundColor = UIColor.grayColor()
            add = addNameArray?.objectAtIndex(i) as? String
            label4.text = add
            
            
            let label5 = UILabel.init(frame:CGRectMake(10, 70, 90, 20))
            label5.backgroundColor = UIColor.grayColor()
            label5.text = "订单编号："
            let label6 = UILabel.init(frame:CGRectMake(105, 70, 150, 20))
            label6.backgroundColor = UIColor.grayColor()
            order = orderArray?.objectAtIndex(i) as? String
            label6.text = order
            
            
            
            let label8 = UILabel.init(frame:CGRectMake(300, 70, 100, 20))
            //label8.backgroundColor = UIColor.grayColor()
            price = priceArray?.objectAtIndex(i) as? String
            label8.text = price
            
            
            let line2 = UIImageView.init(frame:CGRectMake(0, 99, self.frame.width, 1))
            line2.backgroundColor = UIColor.lightGrayColor()
            imageView.addSubview(label1)
            imageView.addSubview(label2)
            imageView.addSubview(label3)
            imageView.addSubview(label4)
            imageView.addSubview(label5)
            imageView.addSubview(label6)
            imageView.addSubview(label8)
            imageView.addSubview(image)
            imageView.addSubview(line1)
            imageView.addSubview(line2)
            
            NSLog("curOriginY\(curOriginY)")
            
            let imageView1 = UIImageView.init(frame:CGRectMake(curOriginX, curOriginY + 100, self.frame.width, 30))
            imageView1.backgroundColor = UIColor.whiteColor()
            imageView1.tag = (i + 1) * 100
            imageView1.userInteractionEnabled = true
            imageView1.addGestureRecognizer(tap1)
            let label7 = UILabel.init(frame:CGRectMake(250, 5, 100, 20))
            label7.backgroundColor = UIColor.grayColor()
            label7.text = "评价订单"
            let line3 = UIImageView.init(frame:CGRectMake(0, 29, self.frame.width, 1))
            line3.backgroundColor = UIColor.lightGrayColor()
            imageView1.addSubview(label7)
            imageView1.addSubview(line3)
            
            
            
            self.addSubview(imageView1)
            self.addSubview(imageView)
            curOriginX = 0
            curOriginY += self.frame.height + 20
            i++
            
            
        }
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, curOriginY + self.frame.height)
        
        
        
    }
    
    func click(sender: UIButton)
    {
        self.selectRadio((sender.tag))
        NSLog("sender.tag\(sender.tag)")
    }
    
    func markViews()
    {
        
    }
    func selectRadio(theCur: Int)
    {
        
        self.curValue = theCur
        self.theCB(cur: self.curValue!)
        NSLog("self.curValue\(self.curValue)")
        NSUserDefaults.standardUserDefaults().setObject(self.curValue, forKey: "curValue")
        
        
    }
    
    func click1(sender: UITapGestureRecognizer)
    {
        self.selectRadio((sender.view?.tag)!)
        
    }
    func click2(sender: UITapGestureRecognizer)
    {
        self.selectRadio((sender.view?.tag)!)
        
    }
    
    
    
}
