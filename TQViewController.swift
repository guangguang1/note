//
//  TQViewController.swift
//
//
//  Created by 梁慧广 on 16/4/3.
//
//

import UIKit

class TQViewController: UIView {
    
    var starBackgroundView: UIView?
    var starForegroundView: UIView?
    var numberOfStar = 5
    var score:Float?
    var theCB: (cur: Float)->(Void)
    init(frame: CGRect, clb: (cur: Float)->(Void))
    {
        
        
        self.theCB = clb
        super.init(frame: frame)
        self.starBackgroundView = self.buidlStarViewWithImageName("backgroundStar")
        self.starForegroundView = self.buidlStarViewWithImageName("foregroundStar")
        self.addSubview(self.starBackgroundView!)
        self.addSubview(self.starForegroundView!)
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buidlStarViewWithImageName(imageName:NSString) -> UIView
    {
        var frame:CGRect = self.bounds
        var view: UIView = UIView(frame: frame)
        view.clipsToBounds = true
        var imageView: UIImageView?
        for (var i = 0; i < 5; i++)
        {
            imageView = UIImageView(image: UIImage(named: imageName as String))
            
            imageView?.frame = CGRectMake(CGFloat(i) * frame.size.width / 5.0, 0, frame.size.width / 5.0, frame.size.height)
            view.addSubview(imageView!)
        }
        
        
        return view
    }
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch:AnyObject in touches{
            var t: UITouch = touch as! UITouch
            var point: CGPoint = t.locationInView(self)
            var rect: CGRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
            if(CGRectContainsPoint(rect, point))
            {
                
                self.changeStarForegroundViewWithPoint(point)
            }
            
            
            
            
        }
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch:AnyObject in touches{
            var t: UITouch = touch as! UITouch
            var point: CGPoint = t.locationInView(self)
            var weekSelf: TQViewController = self
            UIView.transitionWithView(self.starForegroundView!, duration: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
                weekSelf.changeStarForegroundViewWithPoint(point)
                
                },
                completion:
                {
                    (finished:Bool) -> Void in
                    
            })
            
        }
        
    }
    
    func changeStarForegroundViewWithPoint(point:CGPoint)
    {
        var p:CGPoint = point
        if (p.x < 0)
        {
            p.x = 0;
        }
        else if (p.x > self.frame.size.width)
        {
            p.x = self.frame.size.width;
        }
        
        var str: NSString = NSString(format:"%0.2f",p.x / self.frame.size.width)
        score = str.floatValue
        p.x = CGFloat(score!) * self.frame.size.width
        self.starForegroundView?.frame = CGRectMake(0, 0, p.x, self.frame.size.height)
        // NSLog("score\(score)")
        self.theCB(cur: self.score!)
        
        
    }
}
