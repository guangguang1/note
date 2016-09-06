//
//  CancelTableViewCell.swift
//
//
//  Created by 梁慧广 on 16/4/4.
//
//

import UIKit

class CancelTableViewCell: UITableViewCell {
    
    var lab: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        lab = UILabel(frame: CGRect(x: 120, y: 0, width: 100, height: 44))
        lab?.textAlignment = NSTextAlignment.Center
        self.addSubview(lab!)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
