//
//  UserMessage.swift
//  
//
//  Created by 梁慧广 on 16/4/8.
//
//

import UIKit

class UserMessage: NSObject,NSCoding {
    var userName: String?
    var userPassword: String?
    var userQuestion: String?
    var userAnswer: String?
    init(username: String,userpassword: String,userquestion: String,useranswer: String)
    {
        NSLog("aaa")
        self.userName = username
        self.userPassword = userpassword
        self.userQuestion = userquestion
        self.userAnswer = useranswer
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(userName, forKey: "name")
        aCoder.encodeObject(userPassword, forKey: "password")
        aCoder.encodeObject(userQuestion, forKey: "question")
        aCoder.encodeObject(userAnswer, forKey: "answwer")
    }
    required init(coder aDecoder: NSCoder)
    {
        userName = aDecoder.decodeObjectForKey("name") as? String
        userPassword = aDecoder.decodeObjectForKey("password") as? String
        userQuestion = aDecoder.decodeObjectForKey("question") as? String
        userAnswer = aDecoder.decodeObjectForKey("answwer") as? String
    }
    
}
