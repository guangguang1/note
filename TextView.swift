//
//  TextView.swift
//
//
//  Created by 梁慧广 on 16/4/7.
//
//

import UIKit

class TextView: UITextView ,UITextViewDelegate{
    var placeholder : NSString? {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    //占位文字颜色
    var placeholderColor : UIColor?
    
    override internal var text: String! {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    //    func textViewDidChangeSelection(textView: UITextView)
    //    {
    //        selectItem = UIMenuItem(title: "选中", action: "select")
    //        cancelItem = UIMenuItem(title: "取消", action: "cancel")
    //        var Items = [selectItem,cancelItem]
    //        share?.menuItems == Items as? AnyObject
    //
    //    }
    override internal var font: UIFont?{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange", name: UITextViewTextDidChangeNotification, object: self)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func textDidChange(){
        self.setNeedsDisplay()
        
    }
    //
    //    override func canBecomeFirstResponder() -> Bool {
    //        return true
    //    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        
        
        return false
        
    }
    override func drawRect(rect: CGRect) {
        
        if self.hasText(){ return};
        
        var attributes : Dictionary<String,AnyObject> = [NSFontAttributeName:self.font!]
        attributes[NSForegroundColorAttributeName] = (self.placeholderColor == nil) ? (self.placeholderColor) : (UIColor.greenColor())//如何定义字典！！！
        
        let x : CGFloat = 5
        let width = rect.size.width - 2 * x
        let y : CGFloat = 8
        let height = rect.size.width - 2 * y
        
        let placeholderRect = CGRectMake(x, y, width, height)
        self.placeholder!.drawInRect(placeholderRect, withAttributes: attributes)
        
    }
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool
    {
        return true
    }
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
}
