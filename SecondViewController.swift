//
//  SecondViewController.swift
//  快递
//
//  Created by 梁慧广 on 16/3/30.
//  Copyright (c) 2016年 梁慧广. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var table: UITableView?
    var table1: UITableView?
    var title2 = ["我的订单","我的评价","我的地址"]
    var title3 = ["关于我们","意见反馈","检查更新"]
    var imageView: UIImageView?
    var imageView1: UIImageView?
    var nameLabel: UILabel?
    var tapGesture: UITapGestureRecognizer?
    var login:LoginViewController?
    var db: COpaquePointer = nil
    var stmt: COpaquePointer = nil
    var password1: NSString?
    var noteArray:NSMutableArray?
    var note1: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fullPath: String =   NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent("currentImage.png")
        
        self.navigationItem.title = "我的"
        self.view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 66, width: self.view.bounds.width, height: 134))
        imageView?.backgroundColor = UIColor(red: 70/255, green: 155/255, blue: 125/255, alpha: 1)
        imageView?.userInteractionEnabled = true
        self.view.addSubview(imageView!)
        
        
        tapGesture = UITapGestureRecognizer(target: self, action: "setting")
        self.imageView?.addGestureRecognizer(tapGesture!)
        
        imageView1 = UIImageView(frame: CGRect(x: 155, y: 83, width: 70, height: 70))
        imageView1?.backgroundColor = UIColor.grayColor()
        imageView1?.image = UIImage(contentsOfFile: fullPath)
        imageView1?.layer.cornerRadius = 35
        imageView1?.layer.masksToBounds = true
        imageView?.image = note1
        self.view?.addSubview(imageView1!)
        
        
        
        
        
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 160, width: self.view.bounds.width, height: 30))
        nameLabel?.textAlignment = NSTextAlignment.Center
        self.nameLabel?.text = NSUserDefaults.standardUserDefaults().valueForKey("UserName") as? String
        self.view.addSubview(nameLabel!)
        
        table = UITableView(frame: CGRect(x: 0, y: 230, width: self.view.bounds.width, height: 165))
        table?.rowHeight = 55
        table?.delegate = self
        table?.dataSource = self
        self.view.addSubview(table!)
        table1 = UITableView(frame: CGRect(x: 0, y: 420, width: self.view.bounds.width, height: 165))
        table1?.rowHeight = 55
        table1?.delegate = self
        table1?.dataSource = self
        self.view.addSubview(table1!)
        login?.findPassword333()
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if(tableView == table)
        {
            return title2.count
        }
        else
        {
            return title3.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cellid1 = "sundy"
        var cell1 : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellid1) as? UITableViewCell
        if(cell1 == nil)
        {
            cell1 = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellid1)
        }
        var cellid2 = "sundy"
        var cell2 : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellid2) as? UITableViewCell
        if(cell2 == nil)
        {
            cell2 = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellid2)
        }
        if(tableView == table)
        {
            cell1?.textLabel?.text = title2[indexPath.row]
            cell1?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell1!
        }
        else
        {
            cell2?.textLabel?.text = title3[indexPath.row]
            cell2?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell2!
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(tableView == table)
        {
            if(indexPath.row == 0)
            {
                self.navigationController?.pushViewController(MyExpressViewController(), animated: true)
            }
            else if(indexPath.row == 1)
            {
                self.navigationController?.pushViewController(MyEvaluateViewController(), animated: true)
            }
            else
            {
                self.navigationController?.pushViewController(NewAddressViewController(), animated: true)
            }
            
        }
        else
        {
            if(indexPath.row == 0)
            {
                self.navigationController?.pushViewController(AboutUsViewController(), animated: true)
            }
            else if(indexPath.row == 1)
            {
                self.navigationController?.pushViewController(CommentViewController(), animated: true)
            }
            else
            {
                self.navigationController?.pushViewController(UpdateViewController(), animated: true)
            }
            
        }
    }
    func setting()
    {
        self.navigationController?.pushViewController(SettingViewController1(), animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension SecondViewController
{
    
}



