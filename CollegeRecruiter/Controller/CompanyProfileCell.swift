//
//  CompanyProfileCell.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 07/05/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit

class CompanyProfileCell: UITableViewCell {

    let value: UILabel = {
        let label = UILabel()
        label.numberOfLines = 8
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        let width = self.contentView.frame.width/2 - 10
        
        self.contentView.addSubview(value)
        value.translatesAutoresizingMaskIntoConstraints = false
        value.centerYAnchor.constraint(equalTo: self.key.centerYAnchor, constant: 0.0).isActive = true
        value.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5.0).isActive = true
        value.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBOutlet weak var key: UILabel!
    
}
