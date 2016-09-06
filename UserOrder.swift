//
//  UserOrder.swift
//  
//
//  Created by 梁慧广 on 16/4/19.
//
//

import UIKit

class UserOrder: NSObject {
    var UN: String?
    var ON: String?
    var RN:String?
    var RA:String?
    
    init(un: String,on: String,rn: String,ra: String) {
        self.UN = un
        self.ON = on
        self.RN = rn
        self.RA = ra
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(UN, forKey:"name")
        aCoder.encodeObject(ON, forKey:"number")
        aCoder.encodeObject(RN, forKey:"name1")
        aCoder.encodeObject(RA, forKey: "address")
    }
    
    required init(coder aDecoder: NSCoder)
    {
        UN = aDecoder.decodeObjectForKey("name") as? String
        ON = aDecoder.decodeObjectForKey("number") as? String
        RN = aDecoder.decodeObjectForKey("name1") as? String
        RA = aDecoder.decodeObjectForKey("address") as? String
    }
}
