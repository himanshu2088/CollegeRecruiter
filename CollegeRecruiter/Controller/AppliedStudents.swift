//
//  AppliedStudents.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 05/05/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit

class AppliedStudents: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        studentImage.clipsToBounds = true
        studentImage.layer.cornerRadius = 30.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentSkills: UILabel!
    @IBOutlet weak var studentImage: UIButton!
    
}
