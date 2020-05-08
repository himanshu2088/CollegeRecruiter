//
//  CompanyForgotPassVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 01/05/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField

class CompanyForgotPassVC: UIViewController {
    
    var emailArray = [String]()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    let emailTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let resetPassBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset Password", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 24.0)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5607843137, blue: 0.9843137255, alpha: 1)
        button.addTarget(self, action: #selector(resetPass), for: .touchUpInside)
        return button
    }()
    
    @objc func resetPass() {
        
        if emailTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter the email.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        spinner.startAnimating()
        
        Firestore.firestore().collection("company").getDocuments { (snapshot, error) in
            if let error = error {
                self.spinner.stopAnimating()
                print(error.localizedDescription)
            }
            let documents = snapshot?.documents
            for document in documents! {
                let data = document.data()
                let usedEmail = data["email"] as? String ?? ""
                self.emailArray.append(usedEmail)
            }
            if !self.emailArray.contains(self.emailTextField.text!) {
                self.spinner.stopAnimating()
                let alert = UIAlertController(title: "Error", message: "This email does not corresponds to our database. Please check your email.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
            else{
                Auth.auth().sendPasswordReset(withEmail: (self.emailTextField.text)!) { (error) in
                    if let error = error {
                        self.spinner.stopAnimating()
                        print("Error while sending reset link, \(error.localizedDescription)")
                        return
                    } else {
                        self.spinner.stopAnimating()
                        let alert = UIAlertController(title: "Success", message: "Password reset link has been sent to your Gmail. Please reset your password and then login.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                          let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyLoginVC") as? CompanyLoginVC
                          self.present(nextViewController!, animated:true, completion:nil)
                        })
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
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

        self.view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.isUserInteractionEnabled = true
        emailTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60.0).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        self.view.addSubview(resetPassBtn)
        resetPassBtn.translatesAutoresizingMaskIntoConstraints = false
        resetPassBtn.isUserInteractionEnabled = true
        resetPassBtn.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 15.0).isActive = true
        resetPassBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        resetPassBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
    }

}
