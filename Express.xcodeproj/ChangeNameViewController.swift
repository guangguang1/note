//
//  ChangeNameViewController.swift
//
//
//  Created by 梁慧广 on 16/4/4.
//
//

import UIKit

class ChangeNameViewController: UIViewController {
    
    var lab: UILabel?
    var text: UITextField?
    var bgImageView: UIImageView?
    var bgImageView1: UIImageView?
    var bgImageView2: UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "修改用户名"
        bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        bgImageView?.image = UIImage(named: "10")
        self.view.addSubview(bgImageView!)
        self.navigationItem.title = "登录"
        bgImageView1 = UIImageView(frame: CGRect(x: 31, y: 112, width: 310, height: 310))
        bgImageView1?.image = UIImage(named: "注册1")
        bgImageView1?.layer.cornerRadius = 50
        self.view.addSubview(bgImageView1!)
        lab = UILabel(frame: CGRect(x: 39, y: 157, width: 150, height: 21))
        lab?.text = "请输入新用户名:"
        lab?.font = UIFont(name: "Arial", size: 15)
        lab?.textColor = UIColor.blackColor()
        //lab?.backgroundColor = UIColor.redColor()
        self.view.addSubview(lab!)
        
        text = UITextField(frame: CGRect(x: 39, y: 190, width: 200, height: 40))
        text?.font = UIFont(name: "Arial", size: 20)
        text?.addTarget(self, action: "textClick:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(text!)
        
        
        bgImageView2 = UIImageView(frame: CGRect(x: 36, y: 233, width: 300, height: 2))
        bgImageView2?.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(bgImageView2!)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func textClick(sender: UITextField)
    {
        sender.resignFirstResponder()
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
