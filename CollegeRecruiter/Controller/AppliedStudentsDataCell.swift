//
//  AppliedStudentsDataCell.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 06/05/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit

class AppliedStudentsDataCell: UITableViewCell {
    
    let value: UILabel = {
        let value = UILabel()
        value.font = UIFont(name: "Avenir", size: 18.0)
        value.numberOfLines = 8
        return value
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let width = self.contentView.frame.width/2 - 10

        self.contentView.addSubview(value)
        value.translatesAutoresizingMaskIntoConstraints = false
        value.isUserInteractionEnabled = false
        value.centerYAnchor.constraint(equalTo: self.key.centerYAnchor, constant: 0.0).isActive = true
        value.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5.0).isActive = true
        value.widthAnchor.constraint(equalToConstant: width).isActive = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBOutlet weak var key: UILabel!
    
}

