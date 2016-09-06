//
//  ViewController.swift
//  Express
//
//  Created by 梁慧广 on 16/4/8.
//  Copyright (c) 2016年 梁慧广. All rights reserved.
//

import UIKit

class ViewController:UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func click1(sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
        NSLog("123")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

