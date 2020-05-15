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
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "back.png"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    @objc func back(_ sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "RESET PASSWORD"
        label.font = UIFont(name: "Avenir", size: 16.0)
        label.textColor = .lightGray
        return label
    }()
    
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
        button.setTitle("RESET PASSWORD", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20.0)
        button.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        button.layer.borderWidth = 1.0
        button.tintColor = .black
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
        
        self.view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.isUserInteractionEnabled = true
        backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20.0).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        backButton.addTarget(self, action: #selector(back(_:)), for: .allEvents)
        
        self.view.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60.0).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        
        self.view.addSubview(profileLabel)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20.0).isActive = true
        profileLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        self.view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.isUserInteractionEnabled = true
        emailTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100.0).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        self.view.addSubview(resetPassBtn)
        resetPassBtn.translatesAutoresizingMaskIntoConstraints = false
        resetPassBtn.isUserInteractionEnabled = true
        resetPassBtn.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 25.0).isActive = true
        resetPassBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        resetPassBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        resetPassBtn.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }

}
