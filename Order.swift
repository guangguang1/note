//
//  Order.swift
//  
//
//  Created by 梁慧广 on 16/4/19.
//
//

import UIKit

class Order: NSObject {
    var userName1: String?
    var orderNum: String?
    var receiverName: String?
    var receiverAddress: String?
//    var time1: String?
//    var state:String?
//    var price:String?
    init(userName: String,orderNum: String,receiverName: String,receiverAddress: String)
        //time: String,state: String,price: String)
    {
        self.userName1 = userName
        self.orderNum = orderNum
        self.receiverName = receiverName
        self.receiverAddress = receiverAddress
//        self.time1 = time
//        self.state = state
//        self.price = price
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(userName1, forKey: "userName")
        aCoder.encodeObject(orderNum, forKey: "orderNum")
        aCoder.encodeObject(receiverName, forKey: "receiverName")
        aCoder.encodeObject(receiverAddress, forKey: "receiverAddress")
//        aCoder.encodeObject(time1, forKey: "time")
//        aCoder.encodeObject(state, forKey: "state")
//        aCoder.encodeObject(price, forKey: "price")
        
    }
    required init(coder aDecoder: NSCoder)
    {
        userName1 = aDecoder.decodeObjectForKey("userName") as? String
        orderNum = aDecoder.decodeObjectForKey("orderNum") as? String
        receiverName = aDecoder.decodeObjectForKey("receiverName") as? String
        receiverAddress = aDecoder.decodeObjectForKey("receiverAddress") as? String
//        time1 = aDecoder.decodeObjectForKey("time") as? String
//        state = aDecoder.decodeObjectForKey("state") as? String
//        price = aDecoder.decodeObjectForKey("price") as? String

    }

}
