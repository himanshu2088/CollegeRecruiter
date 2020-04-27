//
//  StudentCompanyVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 27/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit

class StudentCompanyVC: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "College Recruitement App"
        label.font = UIFont(name: "Avenir-Medium", size: 25.0)
        return label
    }()
    
    let orLabel: UILabel = {
        let label = UILabel()
        label.text = "Or"
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
        
    let companyBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Company Login", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 25.0)
        button.tintColor = .black
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(toCompanyLoginVC), for: .touchUpInside)
        return button
    }()
    
    @objc func toCompanyLoginVC() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyLoginVC") as? CompanyLoginVC
        self.present(nextViewController!, animated:true, completion:nil)
    }
    
    let studentBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Student Login", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 25.0)
        button.tintColor = .black
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(toStudentLoginVC), for: .touchUpInside)
        return button
    }()
    
    @objc func toStudentLoginVC() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        self.present(nextViewController!, animated:true, completion:nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60.0).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true

        self.view.addSubview(companyBtn)
        companyBtn.translatesAutoresizingMaskIntoConstraints = false
        companyBtn.isUserInteractionEnabled = true
        companyBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50.0).isActive = true
        companyBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        companyBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        self.view.addSubview(orLabel)
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        orLabel.isUserInteractionEnabled = false
        orLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0.0).isActive = true
        orLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        
        self.view.addSubview(studentBtn)
        studentBtn.translatesAutoresizingMaskIntoConstraints = false
        studentBtn.isUserInteractionEnabled = true
        studentBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 50.0).isActive = true
        studentBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        studentBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
    }

}
