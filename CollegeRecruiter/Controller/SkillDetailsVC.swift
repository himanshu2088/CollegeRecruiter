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
    
    var fileUrl: URL?
    var fileExtension: String?
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "EXPERIENCE DETAILS"
        label.font = UIFont(name: "Avenir-Medium", size: 18.0)
        label.textColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return label
    }()
    
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
        label.textColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        label.font = UIFont(name: "Avenir-Medium", size: 30.0)
        return label
    }()
    
    let skillsTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Skills*"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let internshipDetailsTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Internship Details"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let aadharNumberTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Aadhar Number"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let passportNumberTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        textField.placeholder = "Passport Number"
        return textField
    }()
    
    let resumeLabel: UILabel = {
        let label = UILabel()
        label.text = "Upload Resume"
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Medium", size: 20.0)
        return label
    }()
    
    let uploadBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("upload", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 20.0)
        button.tintColor = .systemBlue
        return button
    }()
    
    let finishBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN UP", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25.0)
        button.layer.cornerRadius = 8.0
        button.layer.shadowColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 1.0
        button.backgroundColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        button.tintColor = .white
        button.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        return button
    }()
    
    @objc func registerUser() {
        guard let skills = skillsTextField.text, let internshipDetails = internshipDetailsTextField.text, let aadharNumber = aadharNumberTextField.text, let passportNumber = passportNumberTextField.text else { return }
        
        if skills == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter all the mandatory fields.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        else {
            spinner.startAnimating()
            
            let userId = Auth.auth().currentUser?.uid
            
            if fileUrl == nil {
                Firestore.firestore().collection("student").document(userId!).updateData([
                    "skills" : skills,
                    "internshipDetails" : internshipDetails,
                    "aadharNumber" : aadharNumber,
                    "passportNumber" : passportNumber,
                    "resumeUrl" : ""
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
                                    self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                                })
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            })
                            
                        }
                })
            } else {
                let storageRef = Storage.storage().reference().child(userId! + "." + fileExtension!)
                
                storageRef.putFile(from: fileUrl!, metadata: nil) { (metaData, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    storageRef.downloadURL { (url, error) in
                        let resumeUrl = url?.absoluteString
                        Firestore.firestore().collection("student").document(userId!).updateData([
                            "skills" : skills,
                            "internshipDetails" : internshipDetails,
                            "aadharNumber" : aadharNumber,
                            "passportNumber" : passportNumber,
                            "resumeUrl" : resumeUrl
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
                                            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                                        })
                                        alert.addAction(action)
                                        self.present(alert, animated: true, completion: nil)
                                    })
                                    
                                }
                        })
                    }
                }
            }
            
        }
        
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

        self.view.addSubview(scrollView)

        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        scrollView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20.0).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true

        scrollView.addSubview(skillsTextField)
        skillsTextField.translatesAutoresizingMaskIntoConstraints = false
        skillsTextField.isUserInteractionEnabled = true
        skillsTextField.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 20.0).isActive = true
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
        
        scrollView.addSubview(resumeLabel)
        resumeLabel.translatesAutoresizingMaskIntoConstraints = false
        resumeLabel.isUserInteractionEnabled = false
        resumeLabel.topAnchor.constraint(equalTo: self.passportNumberTextField.bottomAnchor, constant: 15.0).isActive = true
        resumeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        
        scrollView.addSubview(uploadBtn)
        uploadBtn.translatesAutoresizingMaskIntoConstraints = false
        uploadBtn.isUserInteractionEnabled = true
        uploadBtn.centerYAnchor.constraint(equalTo: self.resumeLabel.centerYAnchor, constant: 0.0).isActive = true
        uploadBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        uploadBtn.addTarget(self, action: #selector(handleProfileImageView(_:)), for: .touchUpInside)
        
        scrollView.addSubview(finishBtn)
        finishBtn.translatesAutoresizingMaskIntoConstraints = false
        finishBtn.isUserInteractionEnabled = true
        finishBtn.topAnchor.constraint(equalTo: self.resumeLabel.bottomAnchor, constant: 25.0).isActive = true
        finishBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        finishBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        finishBtn.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        finishBtn.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30.0).isActive = true
    }

}

extension SkillDetailsVC: UIDocumentPickerDelegate {
    
    @objc func handleProfileImageView(_ sender : UIButton) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let fileURLParts = url.path.components(separatedBy: "/")
        fileUrl = url
        let fileName = fileURLParts.last
        let filenameParts = fileName?.components(separatedBy: ".")
        fileExtension = filenameParts![1]
        uploadBtn.setTitle(fileName, for: .normal)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}
