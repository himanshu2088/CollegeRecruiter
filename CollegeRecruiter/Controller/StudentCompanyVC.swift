//
//  StudentCompanyVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 27/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase

class StudentCompanyVC: UIViewController {
    
    var studentEmailArray = [String]()
    var companyEmailArray = [String]()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "College "
        label.textColor = .black
        label.font = UIFont(name: "Noteworthy-Bold", size: 35.0)
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "Recruitment"
        label.textColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        label.font = UIFont(name: "Noteworthy-Bold", size: 35.0)
        return label
    }()
    
    let emailTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Email"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let passwordTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Password"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let loginBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOGIN", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25.0)
        button.layer.cornerRadius = 8.0
        button.layer.shadowColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 1.0
        button.backgroundColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        button.tintColor = .white
        return button
    }()
    
    @objc func login() {
        if emailTextField.text == "" || passwordTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please fill all the fields to continue login.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }

        spinner.startAnimating()
        
        guard let email = emailTextField.text , let password = passwordTextField.text else { return }
        
        Firestore.firestore().collection("company").getDocuments { (snapshot, error) in
            if let error = error {
                self.spinner.stopAnimating()
                print(error.localizedDescription)
            }
            let documents = snapshot?.documents
            for document in documents! {
                let data = document.data()
                let usedEmail = data["email"] as? String ?? ""
                self.companyEmailArray.append(usedEmail)
            }
            
        Firestore.firestore().collection("student").getDocuments { (snapshot, error) in
            if let error = error {
                self.spinner.stopAnimating()
                print(error.localizedDescription)
            }
            let documents = snapshot?.documents
            for document in documents! {
                let data = document.data()
                let usedEmail = data["email"] as? String ?? ""
                self.studentEmailArray.append(usedEmail)
            }
        }
            
            if self.companyEmailArray.contains(email) {
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if (user != nil) {
                        let currentUser = Auth.auth().currentUser
                        switch currentUser?.isEmailVerified {
                        case true:
                            self.spinner.stopAnimating()
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyMainVC") as? CompanyMainVC
                            self.present(nextViewController!, animated:true, completion:nil)
                        case false:
                            currentUser?.sendEmailVerification(completion: { (error) in
                                if let error = error {
                                    self.spinner.stopAnimating()
                                    print("Error while sending email verification, \(error.localizedDescription)")
                                }
                                self.spinner.stopAnimating()
                                let alert = UIAlertController(title: "Error", message: "Please verify your email first. We have sent an email verification link in your Gmail account.", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            })
                        default:
                            print("verified")
                        }
                    } else {
                        self.spinner.stopAnimating()
                        let alert = UIAlertController(title: "Error", message: "Incorrect Password. Please try again.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            } else if self.studentEmailArray.contains(email) {
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if (user != nil) {
                        let currentUser = Auth.auth().currentUser
                        switch currentUser?.isEmailVerified {
                        case true:
                            self.spinner.stopAnimating()
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainVC") as? MainVC
                            self.present(nextViewController!, animated:true, completion:nil)
                        case false:
                            currentUser?.sendEmailVerification(completion: { (error) in
                                if let error = error {
                                    self.spinner.stopAnimating()
                                    print("Error while sending email verification, \(error.localizedDescription)")
                                }
                                self.spinner.stopAnimating()
                                let alert = UIAlertController(title: "Error", message: "Please verify your email first. We have sent an email verification link in your Gmail account.", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            })
                        default:
                            print("verified")
                        }
                    } else {
                        self.spinner.stopAnimating()
                        let alert = UIAlertController(title: "Error", message: "Incorrect Password. Please try again.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            } else {
                self.spinner.stopAnimating()
                let alert = UIAlertController(title: "Error", message: "This email do not corresponds to our databse. Please check your email and try again.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    let forgotPassBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 18.0)
        button.tintColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return button
    }()
    
    @objc func forgotPass() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyForgotPassVC") as? CompanyForgotPassVC
        self.present(nextViewController!, animated:true, completion:nil)
    }
    
    let signUplabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account? "
        label.font = UIFont(name: "Avenir", size: 18.0)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let signUpBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Signup here", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 18.0)
        button.tintColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return button
    }()
    
//    @objc func toCompanyLoginVC() {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyLoginVC") as? CompanyLoginVC
//        self.present(nextViewController!, animated:true, completion:nil)
//    }
//
//    @objc func toStudentLoginVC() {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
//        self.present(nextViewController!, animated:true, completion:nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100.0).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -100.0).isActive = true
        
        self.view.addSubview(label2)
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0.0).isActive = true
        label2.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 0.0).isActive = true
        
        self.view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20.0).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
      
        self.view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20.0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        self.view.addSubview(forgotPassBtn)
        forgotPassBtn.translatesAutoresizingMaskIntoConstraints = false
        forgotPassBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20.0).isActive = true
        forgotPassBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        forgotPassBtn.addTarget(self, action: #selector(forgotPass), for: .touchUpInside)

        self.view.addSubview(loginBtn)
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.topAnchor.constraint(equalTo: forgotPassBtn.bottomAnchor, constant: 20.0).isActive = true
        loginBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        loginBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)

        self.view.addSubview(signUplabel)
        signUplabel.translatesAutoresizingMaskIntoConstraints = false
        signUplabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30.0).isActive = true
        signUplabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -60.0).isActive = true

        self.view.addSubview(signUpBtn)
        signUpBtn.translatesAutoresizingMaskIntoConstraints = false
        signUpBtn.centerYAnchor.constraint(equalTo: signUplabel.centerYAnchor, constant: 0.0).isActive = true
        signUpBtn.leadingAnchor.constraint(equalTo: signUplabel.trailingAnchor, constant: 0.0).isActive = true
        
        
    }

}
