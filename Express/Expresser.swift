//
//  Expresser.swift
//  
//
//  Created by 梁慧广 on 16/4/16.
//
//

import UIKit

class Expresser: NSObject {
    var ExpresserName: String?
    var ExpresserPhone: Int?
    var copName: String?
    var addName1: String?
    var score: Double?
    
    init(ExpresserName: String,ExpresserPhone: Int,copName: String,addName1: String, score: Double)
    {
        
        self.ExpresserName = ExpresserName
        self.ExpresserPhone = ExpresserPhone
        self.copName = copName
        self.addName1 = addName1
        self.score = score
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(ExpresserName, forKey: "ExpresserName")
        aCoder.encodeObject(ExpresserPhone, forKey: "ExpresserPhone")
        aCoder.encodeObject(copName, forKey: "copName")
        aCoder.encodeObject(addName1, forKey: "addName1")
        aCoder.encodeObject(score, forKey: "score")
        
    }
    required init(coder aDecoder: NSCoder)
    {
        ExpresserName = aDecoder.decodeObjectForKey("ExpresserName") as? String
        ExpresserPhone = aDecoder.decodeObjectForKey("ExpresserPhone") as? Int
        copName = aDecoder.decodeObjectForKey("copName") as? String
        addName1 = aDecoder.decodeObjectForKey("addName1") as? String
        score = aDecoder.decodeObjectForKey("score") as? Double
    }

}
