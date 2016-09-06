//
//  Address.swift
//  
//
//  Created by 梁慧广 on 16/4/14.
//
//

import UIKit

class Address: NSObject {
    var name: String?
    var SHname: String?
    var SHphone: String?
    var SHaddress1: String?
    var SHaddress2: String?
    var SHaddress3: String?
    init(name: String,SHname: String,SHphone: String,SHaddress1: String,SHaddress2: String,SHaddress3: String)
    {
        
        self.name = name
        self.SHname = SHname
        self.SHphone = SHphone
        self.SHaddress1 = SHaddress1
        self.SHaddress2 = SHaddress2
        self.SHaddress3 = SHaddress3
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(SHname, forKey: "SHname")
        aCoder.encodeObject(SHphone, forKey: "SHphone")
        aCoder.encodeObject(SHaddress1, forKey: "SHaddress1")
        aCoder.encodeObject(SHaddress2, forKey: "SHaddress2")
        aCoder.encodeObject(SHaddress3, forKey: "SHaddress3")
    }
    required init(coder aDecoder: NSCoder)
    {
        name = aDecoder.decodeObjectForKey("name") as? String
        SHname = aDecoder.decodeObjectForKey("SHname") as? String
        SHphone = aDecoder.decodeObjectForKey("SHphone") as? String
        SHaddress1 = aDecoder.decodeObjectForKey("SHaddress1") as? String
        SHaddress2 = aDecoder.decodeObjectForKey("SHaddress2") as? String
        SHaddress3 = aDecoder.decodeObjectForKey("SHaddress3") as? String
    }

}
