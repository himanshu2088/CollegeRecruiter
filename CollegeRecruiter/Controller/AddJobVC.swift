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

class AddJobVC: UIViewController {
    
    var companyName: String!
    
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
        textField.keyboardType = .numberPad
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
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 24.0)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5607843137, blue: 0.9843137255, alpha: 1)
        button.addTarget(self, action: #selector(postJob), for: .touchUpInside)
        return button
    }()
    
    @objc func postJob() {

        guard let title = titleTextField.text, let description = descriptionTextField.text, let requirements = requirementsTextField.text, let responsibilities = responsibilitiesTextField.text, let salary = salaryTextField.text, let tenthCGPA = tenthCGPATextField.text, let twelfthCGPA = twelfthCGPATextField.text, let graduationCGPA = graduationCGPATextField.text, let companyEmail = Auth.auth().currentUser?.email, let branch = branchTextField.text else { return }
        
        let currentDateTime = Date()

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
                "time" : currentDateTime
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
        
        collectionRef.document(currentUserUID!).getDocument { (snapshot, error) in
            let data = snapshot?.data()
            let nameData = data!["companyName"] as? String
            self.companyName = nameData!
        }

        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        self.view.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.isUserInteractionEnabled = true
        titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 70.0).isActive = true
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
    }
    

}
