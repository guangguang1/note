//
//  Evalution.swift
//  
//
//  Created by 梁慧广 on 16/5/11.
//
//

import UIKit

class Evalution: NSObject {
    var UserName:String?
    var Score:String?
    var Detail:String?
    var Num:String?
    init(name: String,score: String,detail: String,num: String) {
        self.UserName = name
        self.Score = score
        self.Detail = detail
        self.Num = num
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(UserName, forKey:"name")
        aCoder.encodeObject(Score, forKey:"score")
        aCoder.encodeObject(Detail, forKey:"detail")
        aCoder.encodeObject(Num, forKey: "num")
    }
    
    required init(coder aDecoder: NSCoder)
    {
        UserName = aDecoder.decodeObjectForKey("name") as? String
        Score = aDecoder.decodeObjectForKey("score") as? String
        Detail = aDecoder.decodeObjectForKey("detail") as? String
        Num = aDecoder.decodeObjectForKey("num") as? String
    }
}
