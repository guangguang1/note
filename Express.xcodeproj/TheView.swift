//
//  TheView.swift
//
//
//  Created by 梁慧广 on 16/3/31.
//
//

import UIKit

class TheView: UIView {
    var changeString:String? //验证码的字符串
    
    let kLineCount = 6
    let kLineWidth = CGFloat(2.0)
    //生成随机数的个数
    let kCharCount = 5
    //随机生成字体的大小
    let kFontSize = UIFont.systemFontOfSize(CGFloat(arc4random() % 5) + 18)
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        let randomColor:UIColor = UIColor(red: CGFloat(CGFloat(random())/CGFloat(RAND_MAX)), green: CGFloat(CGFloat(random())/CGFloat(RAND_MAX)), blue: CGFloat(CGFloat(random())/CGFloat(RAND_MAX)), alpha: 0.2)
        //随机色
        self.layer.cornerRadius = 5.0   //设置layer圆角半径
        self.layer.masksToBounds = true //隐藏边界
        self.backgroundColor = UIColor.whiteColor() //一开始的label背景色
        
        self.getChangeCode()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.getChangeCode()
    }
    
    func getChangeCode()
    {
        //字符素材数组
        let changeArray:NSArray = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        
        self.changeString = ""
        //随机从数组中选取需要个数的字符，然后拼接为一个字符串
        for(var i=0;i<kCharCount;i++)
        {
            let index = Int(arc4random())%(changeArray.count - 1)
            //生成一个数组里面的随机数随机
            let getStr: AnyObject = changeArray.objectAtIndex(index)
            self.changeString = self.changeString! + (getStr as! String)
            //就相当于 += ,可是+=用不了
        }
        print("验证码：\(changeString)")
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        getChangeCode()
        setNeedsDisplay()
    }
    
    
    
    
    override func drawRect(rect: CGRect)
    {
        super.drawRect(rect)
        let randomBackColor = UIColor(red: CGFloat(CGFloat(random())/CGFloat(RAND_MAX)), green: CGFloat(CGFloat(random())/CGFloat(RAND_MAX)), blue: CGFloat(CGFloat(random())/CGFloat(RAND_MAX)), alpha: 1.0)
        //self.backgroundColor = randomBackColor  背景为随机色
        self.backgroundColor = UIColor.whiteColor()  //背景为白色
        //获得要显示验证码字符串，根据长度，计算每个字符显示的大概位置
        let str = NSString(string: "S")
        //        let font = UIFont.systemFontOfSize(20)
        let size = str.sizeWithAttributes([NSFontAttributeName : kFontSize])
        let width = rect.size.width / CGFloat(NSString(string: changeString!).length) - size.width
        let height = rect.size.height - size.height
        var point:CGPoint?
        var pX:CGFloat?
        var pY:CGFloat?
        
        
        
        //每个字体的文字的宽度和高度
        for(var i=0;i<NSString(string: changeString!).length;i++)
        {
            pX = CGFloat(arc4random()) % width + rect.size.width / CGFloat(NSString(string: changeString!).length)*CGFloat(i)
            pY = CGFloat(arc4random()) % height
            point = CGPointMake(pX!, pY!)
            let c = NSString(string: changeString!).characterAtIndex(i)
            
            let codeText:NSString? = NSString(format: "%C",c)
            //codeText!.drawAtPoint(point!, withAttributes: [NSFontAttributeName : kFontSize])
            codeText?.drawAtPoint(point!, withAttributes: [NSFontAttributeName : kFontSize , NSForegroundColorAttributeName : randomBackColor])//文字颜色为随机色
        }
        
        
        
        
        //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
        let context :CGContext = UIGraphicsGetCurrentContext()!
        //设置画线宽度
        CGContextSetLineWidth(context, kLineWidth)
        for(var i=0;i<kLineCount;i++)
        {
            //绘制干扰的彩色直线
            let randomLineColor = UIColor(red: CGFloat(CGFloat(random())/CGFloat(RAND_MAX)), green: CGFloat(CGFloat(random())/CGFloat(RAND_MAX)), blue: CGFloat(CGFloat(random())/CGFloat(RAND_MAX)), alpha: 0.5)
            CGContextSetStrokeColorWithColor(context, randomLineColor.CGColor)
            //设置线的起点
            pX = CGFloat(arc4random()) % rect.size.width
            pY = CGFloat(arc4random()) % rect.size.height
            CGContextMoveToPoint(context, pX!, pY!)
            //设置线终点
            pX = CGFloat(arc4random()) % rect.size.width
            pY = CGFloat(arc4random()) % rect.size.height
            CGContextAddLineToPoint(context, pX!, pY!)
            //画线
            CGContextStrokePath(context)
        }
        //画点   跟画直线差不多，只不过它们之间的距离就相差1！
        for(var i=0;i<kLineCount*6;i++)
        {
            let randomLineColor = UIColor(red: CGFloat(CGFloat(random())/CGFloat(RAND_MAX)), green: CGFloat(CGFloat(random())/CGFloat(RAND_MAX)), blue: CGFloat(CGFloat(random())/CGFloat(RAND_MAX)), alpha: 0.5)
            CGContextSetStrokeColorWithColor(context, randomLineColor.CGColor)
            
            pX = CGFloat(arc4random()) % rect.size.width
            pY = CGFloat(arc4random()) % rect.size.height
            CGContextMoveToPoint(context, pX!, pY!)
            CGContextAddLineToPoint(context, (pX! + 1), (pY! + 1))
            CGContextStrokePath(context)
            
            
        }
    }
    
}
