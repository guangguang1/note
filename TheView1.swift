//
//  TheView1.swift
//
//
//  Created by 梁慧广 on 16/4/4.
//
//

import UIKit

class TheView1: UIView {
    let kLineCount = 6
    let kLineWidth = CGFloat(2.0)
    //生成随机数的个数
    let kCharCount = 13
    let kFontSize = UIFont.boldSystemFontOfSize(30)
    var changeString:String? //验证码的字符串
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.layer.cornerRadius = 5.0   //设置layer圆角半径
        self.layer.masksToBounds = true //隐藏边界
        self.backgroundColor = UIColor.whiteColor() //一开始的label背景色
        self.getChangeCode()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getChangeCode()
    {
        //字符素材数组
        let changeArray:NSArray = ["0","1","2","3","4","5","6","7","8","9"]
        
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
        NSUserDefaults.standardUserDefaults().setObject(changeString, forKey: "num")
        print("快递单号：\(changeString)")
    }
    
    override func drawRect(rect: CGRect)
    {
        super.drawRect(rect)
        let randomBackColor = UIColor.greenColor()
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
            pX =  width + rect.size.width / CGFloat(NSString(string: changeString!).length)*CGFloat(i)
            pY = height - 25
            point = CGPointMake(pX!, pY!)
            let c = NSString(string: changeString!).characterAtIndex(i)
            
            let codeText:NSString? = NSString(format: "%C",c)
            //codeText!.drawAtPoint(point!, withAttributes: [NSFontAttributeName : kFontSize])
            codeText?.drawAtPoint(point!, withAttributes: [NSFontAttributeName : kFontSize , NSForegroundColorAttributeName : randomBackColor])//文字颜色为随机色
        }
        
        
    }
}
