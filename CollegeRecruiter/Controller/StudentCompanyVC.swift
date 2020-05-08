//
//  StudentCompanyVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 27/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit

class StudentCompanyVC: UIViewController {
    
    let orLabel: UILabel = {
        let label = UILabel()
        label.text = "Or"
        label.font = UIFont(name: "Avenir-Medium", size: 20.0)
        return label
    }()
        
    let companyBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Company Login", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 25.0)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5607843137, blue: 0.9843137255, alpha: 1)
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
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 25.0)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5607843137, blue: 0.9843137255, alpha: 1)
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
        
        self.view.addSubview(orLabel)
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        orLabel.isUserInteractionEnabled = false
        orLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0.0).isActive = true
        orLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        
        self.view.addSubview(companyBtn)
        companyBtn.translatesAutoresizingMaskIntoConstraints = false
        companyBtn.isUserInteractionEnabled = true
        companyBtn.bottomAnchor.constraint(equalTo: orLabel.topAnchor, constant: -20.0).isActive = true
        companyBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        companyBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        self.view.addSubview(studentBtn)
        studentBtn.translatesAutoresizingMaskIntoConstraints = false
        studentBtn.isUserInteractionEnabled = true
        studentBtn.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 20.0).isActive = true
        studentBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        studentBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
    }

}
