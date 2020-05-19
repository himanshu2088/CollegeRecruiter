//
//  JobsCell.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 04/05/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit

class JobsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobDescription: UILabel!
    @IBOutlet weak var day: UILabel!
}
