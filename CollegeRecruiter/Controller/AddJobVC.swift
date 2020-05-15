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
        label.font = UIFont(name: "Avenir", size: 16.0)
        label.textColor = .lightGray
        return label
    }()
    
    var companyName: String!
    let branchData = ["Computer Science", "Mechanical", "Civil", "Electronics and Communications"]
    
    let currentUserUID = Auth.auth().currentUser?.uid
    let collectionRef = Firestore.firestore().collection("company")
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    let titleTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Job Title"
        return textField
    }()
    
    let descriptionTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Job Description"
        return textField
    }()
    
    let requirementsTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Job Requirements"
        return textField
    }()
    
    let responsibilitiesTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Job Responsibilities"
        return textField
    }()
    
    let branchTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Branch"
        
//        asdasdasd
        return textField
    }()
    
    let salaryTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Salary Range"
        return textField
    }()
    
    let tenthCGPATextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "10th CGPA/%"
        return textField
    }()
    
    let twelfthCGPATextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "12/Diploma CGPA/%"
        return textField
    }()
    
    let graduationCGPATextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Graduation CGPA/%"
        return textField
    }()
    
    let postBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("POST JOB", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20.0)
        button.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        button.layer.borderWidth = 1.0
        button.tintColor = .black
        button.addTarget(self, action: #selector(postJob), for: .touchUpInside)
        return button
    }()
    
    @objc func postJob() {

        guard let title = titleTextField.text, let description = descriptionTextField.text, let requirements = requirementsTextField.text, let responsibilities = responsibilitiesTextField.text, let salary = salaryTextField.text, let tenthCGPA = tenthCGPATextField.text, let twelfthCGPA = twelfthCGPATextField.text, let graduationCGPA = graduationCGPATextField.text, let companyEmail = Auth.auth().currentUser?.email, let branch = branchTextField.text else { return }
        
        if title == "" || description == "" || requirements == "" || responsibilities == "" || salary == "" || tenthCGPA == "" || twelfthCGPA == "" || graduationCGPA == "" || branch == "" {
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

        self.view.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.isUserInteractionEnabled = true
        titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80.0).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        view.addSubview(descriptionTextField)
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.isUserInteractionEnabled = true
        descriptionTextField.topAnchor.constraint(equalTo: self.titleTextField.bottomAnchor, constant: 10.0).isActive = true
        descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        descriptionTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        view.addSubview(requirementsTextField)
        requirementsTextField.translatesAutoresizingMaskIntoConstraints = false
        requirementsTextField.isUserInteractionEnabled = true
        requirementsTextField.topAnchor.constraint(equalTo: self.descriptionTextField.bottomAnchor, constant: 10.0).isActive = true
        requirementsTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        requirementsTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        view.addSubview(responsibilitiesTextField)
        responsibilitiesTextField.translatesAutoresizingMaskIntoConstraints = false
        responsibilitiesTextField.isUserInteractionEnabled = true
        responsibilitiesTextField.topAnchor.constraint(equalTo: self.requirementsTextField.bottomAnchor, constant: 10.0).isActive = true
        responsibilitiesTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        responsibilitiesTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        view.addSubview(branchTextField)
        branchTextField.translatesAutoresizingMaskIntoConstraints = false
        branchTextField.isUserInteractionEnabled = true
        branchTextField.topAnchor.constraint(equalTo: self.responsibilitiesTextField.bottomAnchor, constant: 10.0).isActive = true
        branchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        branchTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        view.addSubview(salaryTextField)
        salaryTextField.translatesAutoresizingMaskIntoConstraints = false
        salaryTextField.isUserInteractionEnabled = true
        salaryTextField.topAnchor.constraint(equalTo: self.branchTextField.bottomAnchor, constant: 10.0).isActive = true
        salaryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        salaryTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        view.addSubview(tenthCGPATextField)
        tenthCGPATextField.translatesAutoresizingMaskIntoConstraints = false
        tenthCGPATextField.isUserInteractionEnabled = true
        tenthCGPATextField.topAnchor.constraint(equalTo: self.salaryTextField.bottomAnchor, constant: 10.0).isActive = true
        tenthCGPATextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        tenthCGPATextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        view.addSubview(twelfthCGPATextField)
        twelfthCGPATextField.translatesAutoresizingMaskIntoConstraints = false
        twelfthCGPATextField.isUserInteractionEnabled = true
        twelfthCGPATextField.topAnchor.constraint(equalTo: self.tenthCGPATextField.bottomAnchor, constant: 10.0).isActive = true
        twelfthCGPATextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        twelfthCGPATextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        view.addSubview(graduationCGPATextField)
        graduationCGPATextField.translatesAutoresizingMaskIntoConstraints = false
        graduationCGPATextField.isUserInteractionEnabled = true
        graduationCGPATextField.topAnchor.constraint(equalTo: self.twelfthCGPATextField.bottomAnchor, constant: 10.0).isActive = true
        graduationCGPATextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        graduationCGPATextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        view.addSubview(postBtn)
        postBtn.translatesAutoresizingMaskIntoConstraints = false
        postBtn.isUserInteractionEnabled = true
        postBtn.topAnchor.constraint(equalTo: self.graduationCGPATextField.bottomAnchor, constant: 15.0).isActive = true
        postBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        postBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        postBtn.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    //UIPickerView Functions For Gender Text Field
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return branchData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return branchData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            branchTextField.text = branchData[row]
    }

}
