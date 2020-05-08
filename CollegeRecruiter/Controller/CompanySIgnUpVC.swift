//
//  CompanySignUpVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 27/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase

class CompanySignUpVC: UIViewController {
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    var emailArray = [String]()
    var studentEmailArray = [String]()
    
    let companyNameTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Company Name"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let addressTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Address"
        return textField
    }()
    
    let cityTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "City"
        return textField
    }()
    
    let contactTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Contact Number"
        return textField
    }()
    
    let emailTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Company Email"
        return textField
    }()
    
    let passwordTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Password"
        return textField
    }()
    
    let confirmPasswordTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Confirm Password"
        return textField
    }()
    
    let registerBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 24.0)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5607843137, blue: 0.9843137255, alpha: 1)
        button.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        return button
    }()
    
    @objc func registerUser() {
        guard let companyName = companyNameTextField.text, let address = addressTextField.text, let city = cityTextField.text, let contact = contactTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text else { return }
            
            if companyName == "" || address == "" || city == "" || contact == "" || email == "" || password == "" || confirmPassword == "" {
                let alert = UIAlertController(title: "Error", message: "Please enter all the fields to continue.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
            
            else if password != confirmPassword {
                let alert = UIAlertController(title: "Error", message: "Entered password and confirm password are not equal. Please write same details.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            else {
                Firestore.firestore().collection("company").getDocuments { (snapshot, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    let documents = snapshot?.documents
                    for document in documents! {
                        let data = document.data()
                        let usedEmail = data["email"] as? String ?? ""
                        self.emailArray.append(usedEmail)
                    }
                    if self.emailArray.contains(email) {
                        let alert = UIAlertController(title: "Error", message: "Email is already taken. Please try another one.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        Firestore.firestore().collection("student").getDocuments { (snapshot, error) in
                            if let error = error {
                                print(error.localizedDescription)
                            }
                            let documents = snapshot?.documents
                            for document in documents! {
                                let data = document.data()
                                let usedEmail = data["email"] as? String ?? ""
                                self.studentEmailArray.append(usedEmail)
                            }
                            if self.studentEmailArray.contains(email) {
                                let alert = UIAlertController(title: "Error", message: "Email is already taken. Please try another one.", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                self.saveData()
                            }

                        }
                    }

                }
                
            }

        }
        
        func saveData() {
            
            spinner.startAnimating()

             guard let companyName = companyNameTextField.text, let address = addressTextField.text, let city = cityTextField.text, let contact = contactTextField.text, let email = emailTextField.text, let password = passwordTextField.text else { return }

            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    self.spinner.stopAnimating()
                    debugPrint("Error while creating user, \(error.localizedDescription)")
                }

                guard let userId = user?.user.uid else { return }
                Firestore.firestore().collection("company").document(userId).setData([
                    "companyName" : companyName,
                    "address" : address,
                    "city" : city,
                    "email" : email,
                    "contact" : contact
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
                                  let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyLoginVC") as? CompanyLoginVC
                                  self.present(nextViewController!, animated:true, completion:nil)
                                })
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            })
                        }
                })
            }

        }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        self.view.addSubview(companyNameTextField)
        companyNameTextField.translatesAutoresizingMaskIntoConstraints = false
        companyNameTextField.isUserInteractionEnabled = true
        companyNameTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60.0).isActive = true
        companyNameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        companyNameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        self.view.addSubview(addressTextField)
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        addressTextField.isUserInteractionEnabled = true
        addressTextField.topAnchor.constraint(equalTo: self.companyNameTextField.bottomAnchor, constant: 10.0).isActive = true
        addressTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        addressTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        self.view.addSubview(cityTextField)
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.isUserInteractionEnabled = true
        cityTextField.topAnchor.constraint(equalTo: self.addressTextField.bottomAnchor, constant: 10.0).isActive = true
        cityTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        cityTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        self.view.addSubview(contactTextField)
        contactTextField.translatesAutoresizingMaskIntoConstraints = false
        contactTextField.isUserInteractionEnabled = true
        contactTextField.topAnchor.constraint(equalTo: self.cityTextField.bottomAnchor, constant: 10.0).isActive = true
        contactTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        contactTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        self.view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.isUserInteractionEnabled = true
        emailTextField.topAnchor.constraint(equalTo: self.contactTextField.bottomAnchor, constant: 10.0).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        self.view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isUserInteractionEnabled = true
        passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 10.0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        self.view.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.isUserInteractionEnabled = true
        confirmPasswordTextField.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 10.0).isActive = true
        confirmPasswordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        confirmPasswordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        self.view.addSubview(registerBtn)
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.isUserInteractionEnabled = true
        registerBtn.topAnchor.constraint(equalTo: self.confirmPasswordTextField.bottomAnchor, constant: 15.0).isActive = true
        registerBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        registerBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
    }
    
}
