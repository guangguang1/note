//
//  NewAddress1ViewController.swift
//  
//
//  Created by 梁慧广 on 16/4/9.
//
//

import UIKit

class NewAddress1ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var table:UITableView?
    var nameArray:NSMutableArray?
    var phoneArray:NSMutableArray?
    var addressArray:NSMutableArray?
    var address1Array:NSMutableArray?
    var address2Array:NSMutableArray?
    var phone1:String?
    var address1:String?
    var address2:String?
    var address3:String?
    var name1:String?
    var rightBtn: UIBarButtonItem?
    var num1:Int?
    
    override func viewWillAppear(animated: Bool)
    {
        
        super.viewWillAppear(animated)
        self.nameArray = NSUserDefaults.standardUserDefaults().valueForKey("name2") as? NSMutableArray
        self.phoneArray = NSUserDefaults.standardUserDefaults().objectForKey("phone2") as? NSMutableArray
        self.addressArray = NSUserDefaults.standardUserDefaults().objectForKey("address2") as? NSMutableArray
        self.address1Array = NSUserDefaults.standardUserDefaults().objectForKey("address22") as? NSMutableArray
        self.address2Array = NSUserDefaults.standardUserDefaults().objectForKey("address222") as? NSMutableArray
        self.table?.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的地址1"
        self.view.backgroundColor = UIColor.whiteColor()

        
        //num1 = (self.nameArray?.count)! * 100
        //table = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: CGFloat(num1!)))
        
        
        self.nameArray = NSUserDefaults.standardUserDefaults().valueForKey("name2") as? NSMutableArray
        self.phoneArray = NSUserDefaults.standardUserDefaults().objectForKey("phone2") as? NSMutableArray
        self.addressArray = NSUserDefaults.standardUserDefaults().objectForKey("address2") as? NSMutableArray
        self.address1Array = NSUserDefaults.standardUserDefaults().objectForKey("address22") as? NSMutableArray
        self.address2Array = NSUserDefaults.standardUserDefaults().objectForKey("address222") as? NSMutableArray
        NSLog("self.nameArray\(self.nameArray)")
        NSLog("self.phoneArray\(self.phoneArray)")
        NSLog("self.addressArray\(self.addressArray)")
        NSLog("self.address1Array\(self.address1Array)")
        NSLog("self.address2Array\(self.address2Array)")
        num1 = (self.nameArray!.count) * 120
        table = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: CGFloat(num1!)))
        table?.delegate = self
        table?.dataSource = self
        table?.rowHeight = 90
        self.view.addSubview(table!)
        
        
        
        
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.nameArray?.count)!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cellid = "sundy"
        var cell : NewAddressTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellid) as? NewAddressTableViewCell
        if(cell == nil)
        {
            cell = NewAddressTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellid)
        }
        name1 = nameArray?.objectAtIndex(indexPath.row) as? String
        phone1 = phoneArray?.objectAtIndex(indexPath.row) as? String
        address1 = addressArray?.objectAtIndex(indexPath.row) as? String
        address2 = address1Array?.objectAtIndex(indexPath.row) as? String
        address3 = address2Array?.objectAtIndex(indexPath.row) as? String
        cell?.lab?.text = name1
        cell?.lab1?.text = phone1
        cell?.lab2?.text = address1! + " " +  address2! + " " + address3!
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var VC2 = ExpressNormalView1Controller()
         NSUserDefaults.standardUserDefaults().setObject(indexPath.row, forKey: "rowNumber")
        self.navigationController?.pushViewController(VC2, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
