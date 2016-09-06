//
//  NewAddressTableViewCell.swift
//  
//
//  Created by 梁慧广 on 16/4/8.
//
//

import UIKit

class NewAddressTableViewCell: UITableViewCell {

    var lab: UILabel?
    var lab1: UILabel?
    var lab2: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        lab = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
        self.addSubview(lab!)
        
        lab1 = UILabel(frame: CGRect(x: 210, y: 10, width: 155, height: 20))
        self.addSubview(lab1!)
        
        lab2 = UILabel(frame: CGRect(x: 10, y: 40, width: 280, height: 40))
        self.addSubview(lab2!)
    }
 
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
