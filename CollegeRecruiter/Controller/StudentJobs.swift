//
//  StudentJobs.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 05/05/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit

class StudentJobs: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    
    }
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var days: UILabel!
}
