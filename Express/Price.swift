//
//  Price.swift
//  
//
//  Created by 梁慧广 on 16/4/14.
//
//

import UIKit

class Price: NSObject {
    var CopName: String?
    var addName1: String?
    var addName2: String?
    var price: Int?
    var extraPrice: Int?
    init(CopName: String,addName1: String,addName2: String,price: Int,extraPrice: Int)
    {
        self.CopName = CopName
        self.addName1 = addName1
        self.addName2 = addName2
        self.price = price
        self.extraPrice = extraPrice
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(CopName, forKey: "name")
        aCoder.encodeObject(addName1, forKey: "add1")
        aCoder.encodeObject(addName2, forKey: "add2")
        aCoder.encodeObject(price, forKey: "price")
        aCoder.encodeObject(extraPrice, forKey: "extraPrice")
        
    }
    required init(coder aDecoder: NSCoder)
    {
        CopName = aDecoder.decodeObjectForKey("name") as? String
        addName1 = aDecoder.decodeObjectForKey("add1") as? String
        addName2 = aDecoder.decodeObjectForKey("add2") as? String
        price = aDecoder.decodeObjectForKey("price") as? Int
        extraPrice = aDecoder.decodeObjectForKey("extraPrice") as? Int
    }
}
