//
//  AddJobVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 03/05/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField

class AddJobVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        label.text = "ADD JOB"
        label.font = UIFont(name: "Avenir-Medium", size: 18.0)
        label.textColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return label
    }()
    
    var companyName: String!
    let branchData = ["Computer Science", "Mechanical", "Civil", "Electronics and Communications"]
    let semesterData = ["7", "8"]
    
    let currentUserUID = Auth.auth().currentUser?.uid
    let collectionRef = Firestore.firestore().collection("company")
    
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
    
    let titleTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Job Title*"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let descriptionTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Job Description"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let requirementsTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Job Requirements*"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let responsibilitiesTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        textField.placeholder = "Job Responsibilities"
        return textField
    }()
    
    let branchTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Branch*"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let salaryTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Salary Range"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let semesterTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Semester*"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let tenthCGPATextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "10th CGPA/%"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let twelfthCGPATextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "12/Diploma CGPA/%"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let graduationCGPATextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Graduation CGPA/%*"
        textField.selectedTitleColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return textField
    }()
    
    let postBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("POST JOB", for: .normal)
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

        guard let title = titleTextField.text, let description = descriptionTextField.text, let requirements = requirementsTextField.text, let responsibilities = responsibilitiesTextField.text, let salary = salaryTextField.text, let semester = semesterTextField.text, let tenthCGPA = tenthCGPATextField.text, let twelfthCGPA = twelfthCGPATextField.text, let graduationCGPA = graduationCGPATextField.text, let companyEmail = Auth.auth().currentUser?.email, let branch = branchTextField.text else { return }
        
        if title == "" || requirements == "" || graduationCGPA == "" || branch == "" || semester == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter all the fields to continue.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else {
            spinner.startAnimating()
            Firestore.firestore().collection("job").addDocument(data: [
                "companyName" : companyName,
                "companyEmail" : companyEmail,
                "jobTitle" : title,
                "jobdescription" : description,
                "jobrequirements" : requirements,
                "jobresponsibilities" : responsibilities,
                "branch" : branch,
                "salary" : salary,
                "semester" : semester,
                "tenthCGPA" : tenthCGPA,
                "twelfthCGPA" : twelfthCGPA,
                "graduationCGPA" : graduationCGPA,
                "studentsApplied" : [],
                "time" : FieldValue.serverTimestamp()
            ]) { (error) in
                if let error = error {
                    print("Error setting job data in firestore, \(error.localizedDescription)")
                } else {
                    self.spinner.stopAnimating()
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyMainVC") as? CompanyMainVC
                    self.present(nextViewController!, animated:true, completion:nil)
                }
            }
            
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let branchPicker = UIPickerView()
        branchTextField.inputView = branchPicker
        branchPicker.delegate = self
        
        let semesterPicker = UIPickerView()
        semesterTextField.inputView = semesterPicker
        semesterPicker.delegate = self
        
        collectionRef.document(currentUserUID!).getDocument { (snapshot, error) in
            let data = snapshot?.data()
            let nameData = data!["companyName"] as? String
            self.companyName = nameData!
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
        
        self.view.addSubview(scrollView)

        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true

        scrollView.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.isUserInteractionEnabled = true
        titleTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0.0).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(descriptionTextField)
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.isUserInteractionEnabled = true
        descriptionTextField.topAnchor.constraint(equalTo: self.titleTextField.bottomAnchor, constant: 10.0).isActive = true
        descriptionTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        descriptionTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(requirementsTextField)
        requirementsTextField.translatesAutoresizingMaskIntoConstraints = false
        requirementsTextField.isUserInteractionEnabled = true
        requirementsTextField.topAnchor.constraint(equalTo: self.descriptionTextField.bottomAnchor, constant: 10.0).isActive = true
        requirementsTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        requirementsTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(responsibilitiesTextField)
        responsibilitiesTextField.translatesAutoresizingMaskIntoConstraints = false
        responsibilitiesTextField.isUserInteractionEnabled = true
        responsibilitiesTextField.topAnchor.constraint(equalTo: self.requirementsTextField.bottomAnchor, constant: 10.0).isActive = true
        responsibilitiesTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        responsibilitiesTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(branchTextField)
        branchTextField.translatesAutoresizingMaskIntoConstraints = false
        branchTextField.isUserInteractionEnabled = true
        branchTextField.topAnchor.constraint(equalTo: self.responsibilitiesTextField.bottomAnchor, constant: 10.0).isActive = true
        branchTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        branchTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(salaryTextField)
        salaryTextField.translatesAutoresizingMaskIntoConstraints = false
        salaryTextField.isUserInteractionEnabled = true
        salaryTextField.topAnchor.constraint(equalTo: self.branchTextField.bottomAnchor, constant: 10.0).isActive = true
        salaryTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        salaryTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(semesterTextField)
        semesterTextField.translatesAutoresizingMaskIntoConstraints = false
        semesterTextField.isUserInteractionEnabled = true
        semesterTextField.topAnchor.constraint(equalTo: self.salaryTextField.bottomAnchor, constant: 10.0).isActive = true
        semesterTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        semesterTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(tenthCGPATextField)
        tenthCGPATextField.translatesAutoresizingMaskIntoConstraints = false
        tenthCGPATextField.isUserInteractionEnabled = true
        tenthCGPATextField.topAnchor.constraint(equalTo: self.semesterTextField.bottomAnchor, constant: 10.0).isActive = true
        tenthCGPATextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        tenthCGPATextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(twelfthCGPATextField)
        twelfthCGPATextField.translatesAutoresizingMaskIntoConstraints = false
        twelfthCGPATextField.isUserInteractionEnabled = true
        twelfthCGPATextField.topAnchor.constraint(equalTo: self.tenthCGPATextField.bottomAnchor, constant: 10.0).isActive = true
        twelfthCGPATextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        twelfthCGPATextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(graduationCGPATextField)
        graduationCGPATextField.translatesAutoresizingMaskIntoConstraints = false
        graduationCGPATextField.isUserInteractionEnabled = true
        graduationCGPATextField.topAnchor.constraint(equalTo: self.twelfthCGPATextField.bottomAnchor, constant: 10.0).isActive = true
        graduationCGPATextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        graduationCGPATextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(postBtn)
        postBtn.translatesAutoresizingMaskIntoConstraints = false
        postBtn.isUserInteractionEnabled = true
        postBtn.topAnchor.constraint(equalTo: self.graduationCGPATextField.bottomAnchor, constant: 15.0).isActive = true
        postBtn.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
        postBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        postBtn.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30.0).isActive = true
        postBtn.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    //UIPickerView Functions For Gender Text Field
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if semesterTextField.isEditing == true {
            return semesterData.count
        }
        else if branchTextField.isEditing == true {
            return branchData.count
        }
        else {
            return branchData.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if semesterTextField.isEditing == true {
            return semesterData[row]
        }
        else if branchTextField.isEditing == true {
            return branchData[row]
        }
        else {
            return branchData[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if semesterTextField.isEditing == true {
            semesterTextField.text = semesterData[row]
        }
        else if branchTextField.isEditing == true {
            branchTextField.text = branchData[row]
        }
        else {
            branchTextField.text = branchData[row]
        }
    }

}
