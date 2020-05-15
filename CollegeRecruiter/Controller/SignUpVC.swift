//
//  SignUpVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 24/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase

class SignUpVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        label.text = "SIGNUP"
        label.font = UIFont(name: "Avenir", size: 16.0)
        label.textColor = .lightGray
        return label
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    var emailArray = [String]()
    let genderData = ["Male", "Female"]
    let branchData = ["Computer Science", "Mechanical", "Civil", "Electronics and Communications"]
    
    let scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    let enrollmentTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Enrollment Number"
        return textField
    }()
    
    let admissionTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Admission Number"
        return textField
    }()
    
    let nameTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Name"
        return textField
    }()
    
    let fatherTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Father's Name"
        return textField
    }()
    
    let motherTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Mother's Name"
        return textField
    }()
    
    let branchTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Branch"
        return textField
    }()
    
    let batchTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Batch/Section"
        return textField
    }()
    
    let genderTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Gender"
        return textField
    }()
    
    let dobTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Date of Birth (dd/mm/yyyy)"
        return textField
    }()
    
    let categoryTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Category"
        return textField
    }()
    
    let emailTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let mobileTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Mobile Number"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let parentMobileTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Parent's Mobile Number"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let primaryAddressTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Primary Address"
        return textField
    }()
    
    let currentAddressTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Current Address"
        return textField
    }()
    
    let cityTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "City"
        return textField
    }()
    
    let passwordTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let confirmPasswordTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Confirm Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let nextBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20.0)
        button.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        button.layer.borderWidth = 1.0
        button.tintColor = .black
        button.addTarget(self, action: #selector(toNextPage), for: .touchUpInside)
        return button
    }()
    
    @objc func toNextPage() {

        guard let enrollment = enrollmentTextField.text, let admission = admissionTextField.text, let name = nameTextField.text, let fatherName = fatherTextField.text, let motherName = motherTextField.text, let branch = branchTextField.text, let batch = batchTextField.text, let gender = genderTextField.text, let dob = dobTextField.text, let category = categoryTextField.text, let email = emailTextField.text, let mobile = mobileTextField.text, let parentMobile = parentMobileTextField.text, let primaryAdd = primaryAddressTextField.text, let currentAdd = currentAddressTextField.text, let city = cityTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text else { return }
        
        if enrollment == "" || admission == "" || name == "" || fatherName == "" || motherName == "" || branch == "" || batch == "" || gender == "" || dob == "" || category == "" || email == "" || mobile == "" || parentMobile == "" || primaryAdd == "" || currentAdd == "" || city == "" || password == "" || confirmPassword == "" {
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
            Firestore.firestore().collection("student").getDocuments { (snapshot, error) in
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
                }
                else {
                    self.saveData()
                }

            }
        }

    }
    
    func saveData() {
        
        spinner.startAnimating()

         guard let enrollment = enrollmentTextField.text, let admission = admissionTextField.text, let name = nameTextField.text, let fatherName = fatherTextField.text, let motherName = motherTextField.text, let branch = branchTextField.text, let batch = batchTextField.text, let gender = genderTextField.text, let dob = dobTextField.text, let category = categoryTextField.text, let email = emailTextField.text, let mobile = mobileTextField.text, let parentMobile = parentMobileTextField.text, let primaryAdd = primaryAddressTextField.text, let currentAdd = currentAddressTextField.text, let city = cityTextField.text, let password = passwordTextField.text else { return }

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.spinner.stopAnimating()
                debugPrint("Error while creating user, \(error.localizedDescription)")
            }

            guard let userId = user?.user.uid else { return }
            Firestore.firestore().collection("student").document(userId).setData([
                "enrollmentNo" : enrollment,
                "admissionNo" : admission,
                "name" : name,
                "fatherName" : fatherName,
                "motherName" : motherName,
                "branch" : branch,
                "batch" : batch,
                "gender" : gender,
                "dob" : dob,
                "category" : category,
                "email" : email,
                "mobileNo" : mobile,
                "parentMobileNo" : parentMobile,
                "primaryAddress" : primaryAdd,
                "currentAddress" : currentAdd,
                "city" : city,
                "uniqueID" : "CS" + enrollment
                ], completion: { (error) in
                    if let error = error {
                        self.spinner.stopAnimating()
                        debugPrint(error.localizedDescription)
                        print("Error while creating user")
                    } else {
                        self.spinner.stopAnimating()
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EducationDetailsVC") as? EducationDetailsVC
                        self.present(nextViewController!, animated:true, completion:nil)
                    }
            }) 
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let branchPicker = UIPickerView()
        branchTextField.inputView = branchPicker
        branchPicker.delegate = self
        
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
        
        let genderPicker = UIPickerView()
        genderTextField.inputView = genderPicker
        genderPicker.delegate = self
        
        self.view.addSubview(scrollView)

        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        scrollView.addSubview(enrollmentTextField)
        enrollmentTextField.translatesAutoresizingMaskIntoConstraints = false
        enrollmentTextField.isUserInteractionEnabled = true
        enrollmentTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20.0).isActive = true
        enrollmentTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        enrollmentTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(admissionTextField)
        admissionTextField.translatesAutoresizingMaskIntoConstraints = false
        admissionTextField.isUserInteractionEnabled = true
        admissionTextField.topAnchor.constraint(equalTo: self.enrollmentTextField.bottomAnchor, constant: 10.0).isActive = true
        admissionTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        admissionTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.isUserInteractionEnabled = true
        nameTextField.topAnchor.constraint(equalTo: self.admissionTextField.bottomAnchor, constant: 10.0).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(fatherTextField)
        fatherTextField.translatesAutoresizingMaskIntoConstraints = false
        fatherTextField.isUserInteractionEnabled = true
        fatherTextField.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 10.0).isActive = true
        fatherTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        fatherTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(motherTextField)
        motherTextField.translatesAutoresizingMaskIntoConstraints = false
        motherTextField.isUserInteractionEnabled = true
        motherTextField.topAnchor.constraint(equalTo: self.fatherTextField.bottomAnchor, constant: 10.0).isActive = true
        motherTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        motherTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(branchTextField)
        branchTextField.translatesAutoresizingMaskIntoConstraints = false
        branchTextField.isUserInteractionEnabled = true
        branchTextField.topAnchor.constraint(equalTo: self.motherTextField.bottomAnchor, constant: 10.0).isActive = true
        branchTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        branchTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(batchTextField)
        batchTextField.translatesAutoresizingMaskIntoConstraints = false
        batchTextField.isUserInteractionEnabled = true
        batchTextField.topAnchor.constraint(equalTo: self.branchTextField.bottomAnchor, constant: 10.0).isActive = true
        batchTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        batchTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(genderTextField)
        genderTextField.translatesAutoresizingMaskIntoConstraints = false
        genderTextField.isUserInteractionEnabled = true
        genderTextField.topAnchor.constraint(equalTo: self.batchTextField.bottomAnchor, constant: 10.0).isActive = true
        genderTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        genderTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(dobTextField)
        dobTextField.translatesAutoresizingMaskIntoConstraints = false
        dobTextField.isUserInteractionEnabled = true
        dobTextField.topAnchor.constraint(equalTo: self.genderTextField.bottomAnchor, constant: 10.0).isActive = true
        dobTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        dobTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(categoryTextField)
        categoryTextField.translatesAutoresizingMaskIntoConstraints = false
        categoryTextField.isUserInteractionEnabled = true
        categoryTextField.topAnchor.constraint(equalTo: self.dobTextField.bottomAnchor, constant: 10.0).isActive = true
        categoryTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        categoryTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.isUserInteractionEnabled = true
        emailTextField.topAnchor.constraint(equalTo: self.categoryTextField.bottomAnchor, constant: 10.0).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(mobileTextField)
        mobileTextField.translatesAutoresizingMaskIntoConstraints = false
        mobileTextField.isUserInteractionEnabled = true
        mobileTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 10.0).isActive = true
        mobileTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        mobileTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(parentMobileTextField)
        parentMobileTextField.translatesAutoresizingMaskIntoConstraints = false
        parentMobileTextField.isUserInteractionEnabled = true
        parentMobileTextField.topAnchor.constraint(equalTo: self.mobileTextField.bottomAnchor, constant: 10.0).isActive = true
        parentMobileTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        parentMobileTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(primaryAddressTextField)
        primaryAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        primaryAddressTextField.isUserInteractionEnabled = true
        primaryAddressTextField.topAnchor.constraint(equalTo: self.parentMobileTextField.bottomAnchor, constant: 10.0).isActive = true
        primaryAddressTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        primaryAddressTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(currentAddressTextField)
        currentAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        currentAddressTextField.isUserInteractionEnabled = true
        currentAddressTextField.topAnchor.constraint(equalTo: self.primaryAddressTextField.bottomAnchor, constant: 10.0).isActive = true
        currentAddressTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        currentAddressTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(cityTextField)
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.isUserInteractionEnabled = true
        cityTextField.topAnchor.constraint(equalTo: self.currentAddressTextField.bottomAnchor, constant: 10.0).isActive = true
        cityTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        cityTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isUserInteractionEnabled = true
        passwordTextField.topAnchor.constraint(equalTo: self.cityTextField.bottomAnchor, constant: 10.0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.isUserInteractionEnabled = true
        confirmPasswordTextField.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 10.0).isActive = true
        confirmPasswordTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        confirmPasswordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true

        scrollView.addSubview(nextBtn)
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.isUserInteractionEnabled = true
        nextBtn.topAnchor.constraint(equalTo: self.confirmPasswordTextField.bottomAnchor, constant: 15.0).isActive = true
        nextBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30.0).isActive = true
        
    }
    
    //UIPickerView Functions For Gender Text Field
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if genderTextField.isEditing == true {
            return genderData.count
        }
        else if branchTextField.isEditing == true {
            return branchData.count
        }
        else {
            return branchData.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if genderTextField.isEditing == true {
            return genderData[row]
        }
        else if branchTextField.isEditing == true {
            return branchData[row]
        }
        else {
            return branchData[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if genderTextField.isEditing == true {
            genderTextField.text = genderData[row]
        }
        else if branchTextField.isEditing == true {
            branchTextField.text = branchData[row]
        }
    }

}
