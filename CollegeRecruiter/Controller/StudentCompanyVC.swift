//
//  StudentCompanyVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 27/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit

class StudentCompanyVC: UIViewController {
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "HOME"
        label.font = UIFont(name: "Avenir", size: 16.0)
        label.textColor = .lightGray
        return label
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "College \nRecruitment"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Avenir-Medium", size: 33.0)
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "employee.png")
        return view
    }()
    
    let imageView2: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cap.png")
        return view
    }()
    
    let companyBtn: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(toCompanyLoginVC), for: .touchUpInside)
        button.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        button.layer.borderWidth = 1.0
        button.setTitle("Log in as company", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 22.0)
        button.tintColor = .black
        return button
    }()
    
    @objc func toCompanyLoginVC() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyLoginVC") as? CompanyLoginVC
        self.present(nextViewController!, animated:true, completion:nil)
    }
    
    let studentBtn: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20.0)
        button.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        button.layer.borderWidth = 1.0
        button.setTitle("Log in as student", for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(toStudentLoginVC), for: .touchUpInside)
        return button
    }()
    
    @objc func toStudentLoginVC() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        self.present(nextViewController!, animated:true, completion:nil)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60.0).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        
        self.view.addSubview(profileLabel)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20.0).isActive = true
        profileLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80.0).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        
        self.view.addSubview(companyBtn)
        companyBtn.translatesAutoresizingMaskIntoConstraints = false
        companyBtn.isUserInteractionEnabled = true
        companyBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 30.0).isActive = true
        companyBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        companyBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        companyBtn.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        companyBtn.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.companyBtn.leadingAnchor, constant: 20.0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.companyBtn.centerYAnchor, constant: 0.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        self.view.addSubview(studentBtn)
        studentBtn.translatesAutoresizingMaskIntoConstraints = false
        studentBtn.isUserInteractionEnabled = true
        studentBtn.topAnchor.constraint(equalTo: companyBtn.bottomAnchor, constant: 20.0).isActive = true
        studentBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        studentBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        studentBtn.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        studentBtn.addSubview(imageView2)
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        imageView2.leadingAnchor.constraint(equalTo: self.studentBtn.leadingAnchor, constant: 25.0).isActive = true
        imageView2.centerYAnchor.constraint(equalTo: self.studentBtn.centerYAnchor, constant: 0.0).isActive = true
        imageView2.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        imageView2.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
    }

}
