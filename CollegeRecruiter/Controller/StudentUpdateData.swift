//
//  StudentUpdateData.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 20/05/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase

class StudentUpdateData: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var fileUrl: URL?
    var fileExtension: String?
    var resume: String?
    
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
        label.text = "UPDATE DATA"
        label.font = UIFont(name: "Avenir-Medium", size: 18.0)
        label.textColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return label
    }()

    let semesterData = ["7", "8"]
    
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
    
    let imageView: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 55.0
        button.clipsToBounds = true
        return button
    }()
    
    let internshipTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Internship Details"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let skillsTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Skills"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let totalBackTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Number of Total Backlogs"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let activeBackTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        textField.placeholder = "Number of Active Backlogs"
        return textField
    }()
    
    let subjectBackTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Name of Subjects with Current Backlogs"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let overallCGPATextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Overall CGPA"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let semesterTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Semester"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let semOneTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Semester 1 SGPA"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let semTwoTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Semester 2 SGPA"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let semThreeTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Semester 3 SGPA"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let semFourTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Semester 4 SGPA"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let semFiveTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Semester 5 SGPA"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let semSixTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Semester 6 SGPA"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let semSevenTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Semester 7 SGPA"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let semEightTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Semester 8 SGPA"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
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
    
    let postBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("UPDATE DATA", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25.0)
        button.layer.cornerRadius = 8.0
        button.layer.shadowColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 1.0
        button.backgroundColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        button.tintColor = .white
        button.addTarget(self, action: #selector(postJob), for: .touchUpInside)
        return button
    }()
    
    @objc func postJob() {

        guard let internship = internshipTextField.text, let skills = skillsTextField.text, let totalBack = totalBackTextField.text, let activeBack = activeBackTextField.text, let subjectBack = subjectBackTextField.text, let semester = semesterTextField.text, let overallCGPA = overallCGPATextField.text, let semOne = semOneTextField.text, let semTwo = semTwoTextField.text, let semThree = semThreeTextField.text, let semFour = semFourTextField.text, let semFive = semFiveTextField.text, let semSix = semSixTextField.text, let semSeven = semSevenTextField.text, let semEight = semEightTextField.text else { return }
        
        spinner.startAnimating()
        
        let userId = Auth.auth().currentUser?.uid
        
        let storageRef = Storage.storage().reference().child(userId! + ".jpg")
        if let uploadData = self.imageView.currentImage!.jpegData(compressionQuality: 0.1) {
            storageRef.putData(uploadData, metadata: nil) { (metaData, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                storageRef.downloadURL { (url, error) in
                    let profileImageUrl = (url?.absoluteString)!
                    
                    Firestore.firestore().collection("student").document(userId!).updateData([
                        "internshipDetails" : internship,
                        "skills" : skills,
                        "totalBack" : totalBack,
                        "activeBack" : activeBack,
                        "subjectBack" : subjectBack,
                        "semester" : semester,
                        "overallCGPA" : overallCGPA,
                        "semOne" : semOne,
                        "semtwo" : semTwo,
                        "semThree" : semThree,
                        "semFour" : semFour,
                        "semFive" : semFive,
                        "semSix" : semSix,
                        "semSeven" : semSeven,
                        "semEight" : semEight,
                        "profileImageUrl" : profileImageUrl
                    ]) { (error) in
                        if let error = error {
                            self.spinner.stopAnimating()
                            print("Error updating student data, \(error)")
                        }
                        else {
                            let userId = Auth.auth().currentUser?.uid
                            
                            if self.fileUrl == nil {
                                Firestore.firestore().collection("student").document(userId!).updateData([
                                    "resumeUrl" : self.resume
                                    ], completion: { (error) in
                                        if let error = error {
                                            self.spinner.stopAnimating()
                                            debugPrint(error.localizedDescription)
                                            print("Error while creating user")
                                        } else {
                                            self.dismiss(animated: true, completion: nil)
                                        }
                                })
                            } else {
                                let storageRef = Storage.storage().reference().child(userId! + "." + self.fileExtension!)
                                
                                storageRef.putFile(from: self.fileUrl!, metadata: nil) { (metaData, error) in
                                    if let error = error {
                                        print(error.localizedDescription)
                                        return
                                    }
                                    storageRef.downloadURL { (url, error) in
                                        let resumeUrl = url?.absoluteString
                                        Firestore.firestore().collection("student").document(userId!).updateData([
                                            "resumeUrl" : resumeUrl
                                            ], completion: { (error) in
                                                if let error = error {
                                                    self.spinner.stopAnimating()
                                                    debugPrint(error.localizedDescription)
                                                    print("Error while creating user")
                                                } else {
                                                    self.dismiss(animated: true, completion: nil)
                                                }
                                        })
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let semesterPicker = UIPickerView()
        semesterTextField.inputView = semesterPicker
        semesterPicker.delegate = self
        
        spinner.startAnimating()
        
        let userId = Auth.auth().currentUser?.uid
        
        Firestore.firestore().collection("student").document(userId!).getDocument { (snapshot, error) in
            let data = snapshot?.data()
            let internship = data!["internshipDetails"] as? String
            let skills = data!["skills"] as? String
            let totalBack = data!["totalBack"] as? String
            let activeBack = data!["activeBack"] as? String
            let subjectBack = data!["subjectBack"] as? String
            let semester = data!["semester"] as? String
            let overall = data!["overallCGPA"] as? String
            let one = data!["semOne"] as? String
            let two = data!["semtwo"] as? String
            let three = data!["semThree"] as? String
            let four = data!["semFour"] as? String
            let five = data!["semFive"] as? String
            let six = data!["semSix"] as? String
            let seven = data!["semSeven"] as? String
            let eight = data!["semEight"] as? String
            let photoUrl = data!["profileImageUrl"] as? String
            let resumeUrl = data!["resumeUrl"] as? String
            
            self.resume = resumeUrl
            
            let url = URL(string: photoUrl!)
            if url != nil {
                let data = try? Data(contentsOf: url!)
                if data != nil {
                    self.imageView.setImage(UIImage(data: data!), for: .normal)
                }
            }
            
            self.spinner.stopAnimating()
            
            self.view.addSubview(self.scrollView)
            self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80.0).isActive = true
            self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
            
            self.scrollView.addSubview(self.imageView)
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
            self.imageView.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
            self.imageView.heightAnchor.constraint(equalToConstant: 110.0).isActive = true
            self.imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0.0).isActive = true
            self.imageView.addTarget(self, action: #selector(self.handleProfileImageView(_:)), for: .touchUpInside)

            self.scrollView.addSubview(self.internshipTextField)
            self.internshipTextField.translatesAutoresizingMaskIntoConstraints = false
            self.internshipTextField.isUserInteractionEnabled = true
            self.internshipTextField.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 30.0).isActive = true
            self.internshipTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.internshipTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.internshipTextField.text = internship!
            
            self.scrollView.addSubview(self.skillsTextField)
            self.skillsTextField.translatesAutoresizingMaskIntoConstraints = false
            self.skillsTextField.isUserInteractionEnabled = true
            self.skillsTextField.topAnchor.constraint(equalTo: self.internshipTextField.bottomAnchor, constant: 10.0).isActive = true
            self.skillsTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.skillsTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.skillsTextField.text = skills!
            
            self.scrollView.addSubview(self.totalBackTextField)
            self.totalBackTextField.translatesAutoresizingMaskIntoConstraints = false
            self.totalBackTextField.isUserInteractionEnabled = true
            self.totalBackTextField.topAnchor.constraint(equalTo: self.skillsTextField.bottomAnchor, constant: 10.0).isActive = true
            self.totalBackTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.totalBackTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.totalBackTextField.text = totalBack!
            
            self.scrollView.addSubview(self.activeBackTextField)
            self.activeBackTextField.translatesAutoresizingMaskIntoConstraints = false
            self.activeBackTextField.isUserInteractionEnabled = true
            self.activeBackTextField.topAnchor.constraint(equalTo: self.totalBackTextField.bottomAnchor, constant: 10.0).isActive = true
            self.activeBackTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.activeBackTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.activeBackTextField.text = activeBack!
            
            self.scrollView.addSubview(self.subjectBackTextField)
            self.subjectBackTextField.translatesAutoresizingMaskIntoConstraints = false
            self.subjectBackTextField.isUserInteractionEnabled = true
            self.subjectBackTextField.topAnchor.constraint(equalTo: self.activeBackTextField.bottomAnchor, constant: 10.0).isActive = true
            self.subjectBackTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.subjectBackTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.subjectBackTextField.text = subjectBack!
            
            self.scrollView.addSubview(self.overallCGPATextField)
            self.overallCGPATextField.translatesAutoresizingMaskIntoConstraints = false
            self.overallCGPATextField.isUserInteractionEnabled = true
            self.overallCGPATextField.topAnchor.constraint(equalTo: self.subjectBackTextField.bottomAnchor, constant: 10.0).isActive = true
            self.overallCGPATextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.overallCGPATextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.overallCGPATextField.text = overall!
            
            self.scrollView.addSubview(self.semesterTextField)
            self.semesterTextField.translatesAutoresizingMaskIntoConstraints = false
            self.semesterTextField.isUserInteractionEnabled = true
            self.semesterTextField.topAnchor.constraint(equalTo: self.overallCGPATextField.bottomAnchor, constant: 10.0).isActive = true
            self.semesterTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.semesterTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.semesterTextField.text = semester!
            
            self.scrollView.addSubview(self.semOneTextField)
            self.semOneTextField.translatesAutoresizingMaskIntoConstraints = false
            self.semOneTextField.isUserInteractionEnabled = true
            self.semOneTextField.topAnchor.constraint(equalTo: self.semesterTextField.bottomAnchor, constant: 10.0).isActive = true
            self.semOneTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.semOneTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.semOneTextField.text = one!
            
            self.scrollView.addSubview(self.semTwoTextField)
            self.semTwoTextField.translatesAutoresizingMaskIntoConstraints = false
            self.semTwoTextField.isUserInteractionEnabled = true
            self.semTwoTextField.topAnchor.constraint(equalTo: self.semOneTextField.bottomAnchor, constant: 10.0).isActive = true
            self.semTwoTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.semTwoTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.semTwoTextField.text = two!
            
            self.scrollView.addSubview(self.semThreeTextField)
            self.semThreeTextField.translatesAutoresizingMaskIntoConstraints = false
            self.semThreeTextField.isUserInteractionEnabled = true
            self.semThreeTextField.topAnchor.constraint(equalTo: self.semTwoTextField.bottomAnchor, constant: 10.0).isActive = true
            self.semThreeTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.semThreeTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.semThreeTextField.text = three!
            
            self.scrollView.addSubview(self.semFourTextField)
            self.semFourTextField.translatesAutoresizingMaskIntoConstraints = false
            self.semFourTextField.isUserInteractionEnabled = true
            self.semFourTextField.topAnchor.constraint(equalTo: self.semThreeTextField.bottomAnchor, constant: 10.0).isActive = true
            self.semFourTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.semFourTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.semFourTextField.text = four!
            
            self.scrollView.addSubview(self.semFiveTextField)
            self.semFiveTextField.translatesAutoresizingMaskIntoConstraints = false
            self.semFiveTextField.isUserInteractionEnabled = true
            self.semFiveTextField.topAnchor.constraint(equalTo: self.semFourTextField.bottomAnchor, constant: 10.0).isActive = true
            self.semFiveTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.semFiveTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.semFiveTextField.text = five!
            
            self.scrollView.addSubview(self.semSixTextField)
            self.semSixTextField.translatesAutoresizingMaskIntoConstraints = false
            self.semSixTextField.isUserInteractionEnabled = true
            self.semSixTextField.topAnchor.constraint(equalTo: self.semFiveTextField.bottomAnchor, constant: 10.0).isActive = true
            self.semSixTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.semSixTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.semSixTextField.text = six!
            
            self.scrollView.addSubview(self.semSevenTextField)
            self.semSevenTextField.translatesAutoresizingMaskIntoConstraints = false
            self.semSevenTextField.isUserInteractionEnabled = true
            self.semSevenTextField.topAnchor.constraint(equalTo: self.semSixTextField.bottomAnchor, constant: 10.0).isActive = true
            self.semSevenTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.semSevenTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.semSevenTextField.text = seven!
            
            self.scrollView.addSubview(self.semEightTextField)
            self.semEightTextField.translatesAutoresizingMaskIntoConstraints = false
            self.semEightTextField.isUserInteractionEnabled = true
            self.semEightTextField.topAnchor.constraint(equalTo: self.semSevenTextField.bottomAnchor, constant: 10.0).isActive = true
            self.semEightTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.semEightTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.semEightTextField.text = eight!
            
            self.scrollView.addSubview(self.resumeLabel)
            self.resumeLabel.translatesAutoresizingMaskIntoConstraints = false
            self.resumeLabel.isUserInteractionEnabled = false
            self.resumeLabel.topAnchor.constraint(equalTo: self.semEightTextField.bottomAnchor, constant: 15.0).isActive = true
            self.resumeLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            
            self.scrollView.addSubview(self.uploadBtn)
            self.uploadBtn.translatesAutoresizingMaskIntoConstraints = false
            self.uploadBtn.isUserInteractionEnabled = true
            self.uploadBtn.centerYAnchor.constraint(equalTo: self.resumeLabel.centerYAnchor, constant: 0.0).isActive = true
            self.uploadBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.uploadBtn.addTarget(self, action: #selector(self.handleResume(_:)), for: .touchUpInside)
            
            self.scrollView.addSubview(self.postBtn)
            self.postBtn.translatesAutoresizingMaskIntoConstraints = false
            self.postBtn.isUserInteractionEnabled = true
            self.postBtn.topAnchor.constraint(equalTo: self.resumeLabel.bottomAnchor, constant: 25.0).isActive = true
            self.postBtn.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.postBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.postBtn.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -30.0).isActive = true
            self.postBtn.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
            
        }
    
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
        
    }
    
    //UIPickerView Functions For Gender Text Field
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return semesterData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return semesterData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        semesterTextField.text = semesterData[row]
    }

}

extension StudentUpdateData : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func handleProfileImageView(_ sender : UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            selectedImageFromPicker = originalImage
        }

        if let selectedImage = selectedImageFromPicker {
            imageView.setImage(selectedImage, for: .normal)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension StudentUpdateData: UIDocumentPickerDelegate {
    
    @objc func handleResume(_ sender : UIButton) {
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
