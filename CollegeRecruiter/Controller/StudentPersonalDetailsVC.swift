//
//  StudentPersonalDetailsVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 30/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase

class StudentPersonalDetailsVC: UIViewController {
    
    let currentUserUID = Auth.auth().currentUser?.uid
    let collectionRef = Firestore.firestore().collection("student")

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
    
    let admissionNo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Admission No."
        label.numberOfLines = 2
        return label
    }()
    
    let enrollmentNo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Enrollment No."
        label.numberOfLines = 2
        return label
    }()
    
    let branch: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Branch"
        return label
    }()
    
    let mobile: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Mobile No."
        label.numberOfLines = 2
        return label
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Name"
        return label
    }()
    
    let aadharNo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Aadhar No."
        label.numberOfLines = 2
        return label
    }()

    let category: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Category"
        return label
    }()

    let city: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "City"
        return label
    }()

    let currentAddress: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Current Address"
        label.numberOfLines = 2
        return label
    }()
    
    let primaryAddress: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Primary Address"
        label.numberOfLines = 2
        return label
    }()
    
    let dob: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Date of Birth"
        label.numberOfLines = 2
        return label
    }()

    let fatherName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Father's Name"
        label.numberOfLines = 2
        return label
    }()

    let motherName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Mother's Name"
        label.numberOfLines = 2
        return label
    }()
    
    let passportNo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Passport No."
        label.numberOfLines = 2
        return label
    }()

    let gender: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Gender"
        return label
    }()

    let parentMobileNo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Parent's Mobile No."
        label.numberOfLines = 2
        return label
    }()
    
    let admissionNoText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    let enrollmentNoText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    let branchText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 4
        return label
    }()
    
    let mobileText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    let nameText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    let aadharNoText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 2
        return label
    }()

    let categoryText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 2
        return label
    }()

    let cityText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 2
        return label
    }()

    let currentAddressText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 5
        return label
    }()
    
    let primaryAddressText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 5
        return label
    }()
    
    let dobText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()

    let fatherNameText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 2
        return label
    }()

    let motherNameText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    let passportNoText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 2
        return label
    }()

    let genderText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()

    let parentMobileNoText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    func getDetails() {
        spinner.startAnimating()
                
        collectionRef.document(currentUserUID!).getDocument { (snapshot, error) in
            let data = snapshot?.data()
            let nameData = data!["name"] as? String
            let admissionNoData = data!["admissionNo"] as? String
            let branchData = data!["branch"] as? String
            let mobileNoData = data!["mobileNo"] as? String
            let aadharNoData = data!["aadharNumber"] as? String
            let categoryData = data!["category"] as? String
            let cityData = data!["city"] as? String
            let currentAddressData = data!["currentAddress"] as? String
            let dobData = data!["dob"] as? String
            let fatherNameData = data!["fatherName"] as? String
            let motherNameData = data!["motherName"] as? String
            let genderData = data!["gender"] as? String
            let parentMobileNoData = data!["parentMobileNo"] as? String
            let passportNoData = data!["passportNumber"] as? String
            let primaryAddressData = data!["primaryAddress"] as? String
            let enrollmentNoData = data!["enrollmentNo"] as? String
            
            self.spinner.stopAnimating()
            
            self.nameText.text = nameData!
            self.admissionNoText.text = admissionNoData!
            self.branchText.text = branchData!
            self.mobileText.text = mobileNoData!
            self.aadharNoText.text = aadharNoData!
            self.categoryText.text = categoryData!
            self.cityText.text = cityData!
            self.mobileText.text = mobileNoData!
            self.parentMobileNoText.text = parentMobileNoData!
            self.fatherNameText.text = fatherNameData!
            self.motherNameText.text = motherNameData!
            self.primaryAddressText.text = primaryAddressData!
            self.currentAddressText.text = currentAddressData!
            self.enrollmentNoText.text = enrollmentNoData!
            self.dobText.text = dobData!
            self.genderText.text = genderData!
            self.passportNoText.text = passportNoData!
            
            self.view.addSubview(self.scrollView)
            self.scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60.0).isActive = true
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
            
            self.scrollView.addSubview(self.name)
            self.name.translatesAutoresizingMaskIntoConstraints = false
            self.name.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0.0).isActive = true
            self.name.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.name.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true
            
            self.scrollView.addSubview(self.admissionNo)
            self.admissionNo.translatesAutoresizingMaskIntoConstraints = false
            self.admissionNo.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.admissionNo.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 30.0).isActive = true
            self.admissionNo.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true
            
            self.scrollView.addSubview(self.enrollmentNo)
            self.enrollmentNo.translatesAutoresizingMaskIntoConstraints = false
            self.enrollmentNo.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.enrollmentNo.topAnchor.constraint(equalTo: self.admissionNo.bottomAnchor, constant: 10.0).isActive = true
            self.enrollmentNo.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.branch)
            self.branch.translatesAutoresizingMaskIntoConstraints = false
            self.branch.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.branch.topAnchor.constraint(equalTo: self.enrollmentNo.bottomAnchor, constant: 30.0).isActive = true

            self.scrollView.addSubview(self.mobile)
            self.mobile.translatesAutoresizingMaskIntoConstraints = false
            self.mobile.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.mobile.topAnchor.constraint(equalTo: self.branch.bottomAnchor, constant: 30.0).isActive = true

            self.scrollView.addSubview(self.aadharNo)
            self.aadharNo.translatesAutoresizingMaskIntoConstraints = false
            self.aadharNo.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.aadharNo.topAnchor.constraint(equalTo: self.mobile.bottomAnchor, constant: 10.0).isActive = true
            self.aadharNo.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.category)
            self.category.translatesAutoresizingMaskIntoConstraints = false
            self.category.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.category.topAnchor.constraint(equalTo: self.aadharNo.bottomAnchor, constant: 10.0).isActive = true

            self.scrollView.addSubview(self.city)
            self.city.translatesAutoresizingMaskIntoConstraints = false
            self.city.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.city.topAnchor.constraint(equalTo: self.category.bottomAnchor, constant: 10.0).isActive = true

            self.scrollView.addSubview(self.currentAddress)
            self.currentAddress.translatesAutoresizingMaskIntoConstraints = false
            self.currentAddress.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.currentAddress.topAnchor.constraint(equalTo: self.city.bottomAnchor, constant: 40.0).isActive = true
            self.currentAddress.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.dob)
            self.dob.translatesAutoresizingMaskIntoConstraints = false
            self.dob.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.dob.topAnchor.constraint(equalTo: self.currentAddress.bottomAnchor, constant: 40.0).isActive = true
            self.dob.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.fatherName)
            self.fatherName.translatesAutoresizingMaskIntoConstraints = false
            self.fatherName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.fatherName.topAnchor.constraint(equalTo: self.dob.bottomAnchor, constant: 30.0).isActive = true
            self.fatherName.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.motherName)
            self.motherName.translatesAutoresizingMaskIntoConstraints = false
            self.motherName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.motherName.topAnchor.constraint(equalTo: self.fatherName.bottomAnchor, constant: 30.0).isActive = true
            self.motherName.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.gender)
            self.gender.translatesAutoresizingMaskIntoConstraints = false
            self.gender.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.gender.topAnchor.constraint(equalTo: self.motherName.bottomAnchor, constant: 30.0).isActive = true

            self.scrollView.addSubview(self.parentMobileNo)
            self.parentMobileNo.translatesAutoresizingMaskIntoConstraints = false
            self.parentMobileNo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.parentMobileNo.topAnchor.constraint(equalTo: self.gender.bottomAnchor, constant: 10.0).isActive = true
            self.parentMobileNo.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.passportNo)
            self.passportNo.translatesAutoresizingMaskIntoConstraints = false
            self.passportNo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.passportNo.topAnchor.constraint(equalTo: self.parentMobileNo.bottomAnchor, constant: 10.0).isActive = true
            self.passportNo.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.primaryAddress)
            self.primaryAddress.translatesAutoresizingMaskIntoConstraints = false
            self.primaryAddress.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.primaryAddress.topAnchor.constraint(equalTo: self.passportNo.bottomAnchor, constant: 40.0).isActive = true
            self.primaryAddress.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -60.0).isActive = true
            self.primaryAddress.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true
            
            
            self.scrollView.addSubview(self.nameText)
            self.nameText.translatesAutoresizingMaskIntoConstraints = false
            self.nameText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.nameText.centerYAnchor.constraint(equalTo: self.name.centerYAnchor, constant: 0.0).isActive = true
            self.nameText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.admissionNoText)
            self.admissionNoText.translatesAutoresizingMaskIntoConstraints = false
            self.admissionNoText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.admissionNoText.centerYAnchor.constraint(equalTo: self.admissionNo.centerYAnchor, constant: 0.0).isActive = true
            self.admissionNoText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.enrollmentNoText)
            self.enrollmentNoText.translatesAutoresizingMaskIntoConstraints = false
            self.enrollmentNoText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.enrollmentNoText.centerYAnchor.constraint(equalTo: self.enrollmentNo.centerYAnchor, constant: 0.0).isActive = true
            self.enrollmentNoText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.branchText)
            self.branchText.translatesAutoresizingMaskIntoConstraints = false
            self.branchText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.branchText.centerYAnchor.constraint(equalTo: self.branch.centerYAnchor, constant: 0.0).isActive = true
            self.branchText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.mobileText)
            self.mobileText.translatesAutoresizingMaskIntoConstraints = false
            self.mobileText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.mobileText.centerYAnchor.constraint(equalTo: self.mobile.centerYAnchor, constant: 0.0).isActive = true
            self.mobileText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.aadharNoText)
            self.aadharNoText.translatesAutoresizingMaskIntoConstraints = false
            self.aadharNoText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.aadharNoText.centerYAnchor.constraint(equalTo: self.aadharNo.centerYAnchor, constant: 0.0).isActive = true
            self.aadharNoText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.categoryText)
            self.categoryText.translatesAutoresizingMaskIntoConstraints = false
            self.categoryText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.categoryText.centerYAnchor.constraint(equalTo: self.category.centerYAnchor, constant: 0.0).isActive = true
            self.categoryText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.cityText)
            self.cityText.translatesAutoresizingMaskIntoConstraints = false
            self.cityText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.cityText.centerYAnchor.constraint(equalTo: self.city.centerYAnchor, constant: 0.0).isActive = true
            self.cityText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.currentAddressText)
            self.currentAddressText.translatesAutoresizingMaskIntoConstraints = false
            self.currentAddressText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.currentAddressText.centerYAnchor.constraint(equalTo: self.currentAddress.centerYAnchor, constant: 0.0).isActive = true
            self.currentAddressText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.dobText)
            self.dobText.translatesAutoresizingMaskIntoConstraints = false
            self.dobText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.dobText.centerYAnchor.constraint(equalTo: self.dob.centerYAnchor, constant: 0.0).isActive = true
            self.dobText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.fatherNameText)
            self.fatherNameText.translatesAutoresizingMaskIntoConstraints = false
            self.fatherNameText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.fatherNameText.centerYAnchor.constraint(equalTo: self.fatherName.centerYAnchor, constant: 0.0).isActive = true
            self.fatherNameText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.motherNameText)
            self.motherNameText.translatesAutoresizingMaskIntoConstraints = false
            self.motherNameText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.motherNameText.centerYAnchor.constraint(equalTo: self.motherName.centerYAnchor, constant: 0.0).isActive = true
            self.motherNameText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.genderText)
            self.genderText.translatesAutoresizingMaskIntoConstraints = false
            self.genderText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.genderText.centerYAnchor.constraint(equalTo: self.gender.centerYAnchor, constant: 0.0).isActive = true
            self.genderText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.parentMobileNoText)
            self.parentMobileNoText.translatesAutoresizingMaskIntoConstraints = false
            self.parentMobileNoText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.parentMobileNoText.centerYAnchor.constraint(equalTo: self.parentMobileNo.centerYAnchor, constant: 0.0).isActive = true
            self.parentMobileNoText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.passportNoText)
            self.passportNoText.translatesAutoresizingMaskIntoConstraints = false
            self.passportNoText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.passportNoText.centerYAnchor.constraint(equalTo: self.passportNo.centerYAnchor, constant: 0.0).isActive = true
            self.passportNoText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.primaryAddressText)
            self.primaryAddressText.translatesAutoresizingMaskIntoConstraints = false
            self.primaryAddressText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.primaryAddressText.centerYAnchor.constraint(equalTo: self.primaryAddress.centerYAnchor, constant: 0.0).isActive = true
            self.primaryAddressText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        getDetails()
        
        let width = self.view.frame.width
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 50))
        self.view.addSubview(navigationBar);
        let navigationItem = UINavigationItem(title: "My Profile")
        let backBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = backBtn
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
