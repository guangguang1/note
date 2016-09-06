//
//  aaa.swift
//  
//
//  Created by 梁慧广 on 16/4/19.
//
//

import UIKit

class aaa: NSObject {
    var name: String?
    var num: String?
    var name1: String?
    var address: String?
    var time: String?
    var state: String?
    var price: String?
    init(name: String,num: String,name1: String,address: String,time: String,state: String,price: String)
    {
        self.name = name
        self.num = num
        self.name1 = name1
        self.address = address
        self.time = time
        self.state = state
        self.price = price
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(num, forKey: "num")
        aCoder.encodeObject(name1, forKey: "name1")
        aCoder.encodeObject(address, forKey: "address")
        aCoder.encodeObject(time, forKey: "time")
        aCoder.encodeObject(state, forKey: "state")
        aCoder.encodeObject(price, forKey: "price")
        
    }
    required init(coder aDecoder: NSCoder)
    {
        name = aDecoder.decodeObjectForKey("name") as? String
        num = aDecoder.decodeObjectForKey("num") as? String
        name1 = aDecoder.decodeObjectForKey("name1") as? String
        address = aDecoder.decodeObjectForKey("address") as? String
        time = aDecoder.decodeObjectForKey("time") as? String
        state = aDecoder.decodeObjectForKey("state") as? String
        price = aDecoder.decodeObjectForKey("price") as? String
    }

}
