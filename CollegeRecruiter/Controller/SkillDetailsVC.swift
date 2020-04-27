//
//  SkillDetailsVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 26/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase

class SkillDetailsVC: UIViewController {
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    let scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    let label: UILabel = {
        let label = UILabel()
        label.text = "Experience Details"
        label.font = UIFont(name: "Avenir-Medium", size: 30.0)
        return label
    }()
    
    let skillsTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Skills"
        return textField
    }()
    
    let internshipDetailsTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Internship Details"
        return textField
    }()
    
    let aadharNumberTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Aadhar Number"
        return textField
    }()
    
    let passportNumberTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Passport Number"
        return textField
    }()
    
    let finishBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 20.0)
        button.tintColor = .black
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        return button
    }()
    
    @objc func registerUser() {
        guard let skills = skillsTextField.text, let internshipDetails = internshipDetailsTextField.text, let aadharNumber = aadharNumberTextField.text, let passportNumber = passportNumberTextField.text else { return }
        
        if skills == "" || internshipDetails == "" || aadharNumber == "" || passportNumber == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter all the fields to continue.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        else {
            spinner.stopAnimating()
            guard let userId = Auth.auth().currentUser?.uid else { return }
            Firestore.firestore().collection("student").document(userId).updateData([
                "skills" : skills,
                "internshipDetails" : internshipDetails,
                "aadharNumber" : aadharNumber,
                "passportNumber" : passportNumber
                ], completion: { (error) in
                    if let error = error {
                        self.spinner.stopAnimating()
                        debugPrint(error.localizedDescription)
                        print("Error while creating user")
                    } else {
                        let currentUser = Auth.auth().currentUser
                        currentUser?.sendEmailVerification(completion: { (error) in
                            if let error = error {
                                self.spinner.stopAnimating()
                                print("Error while sending email verification, \(error.localizedDescription)")
                            }
                            self.spinner.stopAnimating()
                            let alert = UIAlertController(title: "Success", message: "Account created successfully. Check your Gmail to verify your account. An email verification link is sent there.", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                              let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                              let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainVC") as? MainVC
                              self.present(nextViewController!, animated:true, completion:nil)
                            })
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        })
                        
                    }
            })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(scrollView)

        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        scrollView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30.0).isActive = true
        label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0.0).isActive = true

        scrollView.addSubview(skillsTextField)
        skillsTextField.translatesAutoresizingMaskIntoConstraints = false
        skillsTextField.isUserInteractionEnabled = true
        skillsTextField.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 15.0).isActive = true
        skillsTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        skillsTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(internshipDetailsTextField)
        internshipDetailsTextField.translatesAutoresizingMaskIntoConstraints = false
        internshipDetailsTextField.isUserInteractionEnabled = true
        internshipDetailsTextField.topAnchor.constraint(equalTo: self.skillsTextField.bottomAnchor, constant: 10.0).isActive = true
        internshipDetailsTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        internshipDetailsTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(aadharNumberTextField)
        aadharNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        aadharNumberTextField.isUserInteractionEnabled = true
        aadharNumberTextField.topAnchor.constraint(equalTo: self.internshipDetailsTextField.bottomAnchor, constant: 10.0).isActive = true
        aadharNumberTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        aadharNumberTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(passportNumberTextField)
        passportNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        passportNumberTextField.isUserInteractionEnabled = true
        passportNumberTextField.topAnchor.constraint(equalTo: self.aadharNumberTextField.bottomAnchor, constant: 10.0).isActive = true
        passportNumberTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        passportNumberTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(finishBtn)
        finishBtn.translatesAutoresizingMaskIntoConstraints = false
        finishBtn.isUserInteractionEnabled = true
        finishBtn.topAnchor.constraint(equalTo: self.passportNumberTextField.bottomAnchor, constant: 15.0).isActive = true
        finishBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0.0).isActive = true
        finishBtn.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
        finishBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        finishBtn.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30.0).isActive = true
    }

}


//let currentUser = Auth.auth().currentUser
//currentUser?.sendEmailVerification(completion: { (error) in
//    if let error = error {
//        print("Error while sending email verification, \(error.localizedDescription)")
//    }
//    let alert = UIAlertController(title: "Success", message: "Account created successfully. Check your Gmail to verify your account. An email verification link is sent there.", preferredStyle: .alert)
//    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//    alert.addAction(action)
//    self.present(alert, animated: true, completion: nil)
//})
