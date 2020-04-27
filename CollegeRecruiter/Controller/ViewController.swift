//
//  ViewController.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 24/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase

class ViewController: UIViewController {
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    var emailArray = [String]()
    var id: String?
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Student Login"
        label.font = UIFont(name: "Avenir-Medium", size: 25.0)
        return label
    }()
    
    let emailTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let passwordTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let loginBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 20.0)
        button.tintColor = .black
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return button
    }()
    
    @objc func signIn() {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please fill all the fields to continue login.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }

        spinner.startAnimating()
        
        guard let email = emailTextField.text , let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.spinner.stopAnimating()
                debugPrint("Error signing in, \(error.localizedDescription)")
            }
            
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
                let alert = UIAlertController(title: "Error", message: "Incorrect Email or Password. Please write correct email or password to sign in.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }

        
    }
    
    let signOutlabel: UILabel = {
        let label = UILabel()
        label.text = "New User?"
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let signUpBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 20.0)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(toSignUpVC), for: .touchUpInside)
        return button
    }()
    
    @objc func toSignUpVC() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
        self.present(nextViewController!, animated:true, completion:nil)
    }
    
    let forgotPassBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 20.0)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(toForgotPass), for: .touchUpInside)
        return button
    }()
    
    @objc func toForgotPass() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ForgotPassVC") as? ForgotPassVC
        self.present(nextViewController!, animated:true, completion:nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30.0).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        
        self.view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.isUserInteractionEnabled = true
        emailTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -80.0).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        self.view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isUserInteractionEnabled = true
        passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 10.0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        self.view.addSubview(loginBtn)
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.isUserInteractionEnabled = true
        loginBtn.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 15.0).isActive = true
        loginBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        loginBtn.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        self.view.addSubview(signOutlabel)
        signOutlabel.translatesAutoresizingMaskIntoConstraints = false
        signOutlabel.isUserInteractionEnabled = true
        signOutlabel.topAnchor.constraint(equalTo: self.loginBtn.bottomAnchor, constant: 15.0).isActive = true
        signOutlabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -40.0).isActive = true
        
        self.view.addSubview(signUpBtn)
        signUpBtn.translatesAutoresizingMaskIntoConstraints = false
        signUpBtn.isUserInteractionEnabled = true
        signUpBtn.topAnchor.constraint(equalTo: self.loginBtn.bottomAnchor, constant: 8.0).isActive = true
        signUpBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 50.0).isActive = true
        
        self.view.addSubview(forgotPassBtn)
        forgotPassBtn.translatesAutoresizingMaskIntoConstraints = false
        forgotPassBtn.isUserInteractionEnabled = true
        forgotPassBtn.topAnchor.constraint(equalTo: self.signOutlabel.bottomAnchor, constant: 15.0).isActive = true
        forgotPassBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        
    }


}

////
////  EmployeeCompanyVC.swift
////  CollegeRecruiter
////
////  Created by Himanshu Joshi on 27/04/20.
////  Copyright © 2020 Himanshu Joshi. All rights reserved.
////
//
//import UIKit
//
//class EmployeeCompanyVC: UIViewController {
//    
//    let companyBtn: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Company Login", for: .normal)
//        button.titleLabel?.font = UIFont(name: "Avenir", size: 25.0)
//        button.tintColor = .black
//        button.backgroundColor = .lightGray
////        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
//        return button
//    }()
//    
//    let Btn: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Student Login", for: .normal)
//        button.titleLabel?.font = UIFont(name: "Avenir", size: 25.0)
//        button.tintColor = .black
//        button.backgroundColor = .lightGray
////        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.view.addSubview(companyBtn)
//        companyBtn.translatesAutoresizingMaskIntoConstraints = false
//        companyBtn.isUserInteractionEnabled = true
//        companyBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100.0).isActive = true
//        companyBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
//        companyBtn.trailingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -20.0).isActive = true
//        
//    }
//
//}

