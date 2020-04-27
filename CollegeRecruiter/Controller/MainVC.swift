//
//  MainVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 27/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "College Recruitement App"
        label.font = UIFont(name: "Avenir-Medium", size: 25.0)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60.0).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        
    }

}
