//
//  MyExpressViewController.swift
//  
//
//  Created by 梁慧广 on 16/5/11.
//
//

import UIKit

class MyExpressViewController: UIViewController
{
    
var scrol: UIScrollView?
var i = 0
var orderArray:NSMutableArray?
var orderArray1:NSArray?

override func viewDidLoad() {
    super.viewDidLoad()
    self.orderArray = NSUserDefaults.standardUserDefaults().valueForKey("OrderNumber") as? NSMutableArray
    orderArray1 = orderArray?.copy() as? NSArray
    self.view.backgroundColor = UIColor.whiteColor()
    self.navigationItem.title = "订单"
    var num = 180 * orderArray1!.count
    var num1 = 30 * orderArray1!.count
    scrol = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height:CGFloat(num)))
    scrol?.contentSize = CGSize(width: (self.view.bounds.width), height: CGFloat(num) + CGFloat(num1))
        self.view.addSubview(scrol!)
    
    let zjr = MyExpressView1.init(frame: CGRectMake(0, 0, self.view.bounds.width, 130),isAutoHeight: true) { (cur) -> (Void) in
        if(cur > 99)
        {
            self.navigationController?.pushViewController(StarViewController(), animated: true)
        }
        else
        {
            self.navigationController?.pushViewController(OrderViewController(), animated: true)
        }
        
    }
    scrol?.addSubview(zjr)
    
    
}


override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

}
