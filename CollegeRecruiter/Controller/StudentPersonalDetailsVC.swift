//
//  StudentPersonalDetailsVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 30/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase

class StudentPersonalDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        label.text = "PERSONAL DETAILS"
        label.font = UIFont(name: "Avenir", size: 16.0)
        label.textColor = .lightGray
        return label
    }()
    
    let currentUserUID = Auth.auth().currentUser?.uid
    let collectionRef = Firestore.firestore().collection("student")

    let keyArray = ["Student Name", "Enrollment No", "Admission No", "Gender", "DOB", "Mobile No", "Category", "Branch", "Father's Name", "Mother's Name", "Parent's Mobile No", "Current Address", "Permanent Address", "City", "Aadhar No", "Passport Number"]

    var valueArray = [String]()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "StudentPersonalDetailsCell", bundle: nil), forCellReuseIdentifier: "studentPersonalDetailsCell")
        tableView.allowsSelection = false
        tableView.rowHeight = 150
        tableView.backgroundColor = .white
        return tableView
    }()
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
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
            
            self.valueArray.insert(nameData!, at: 0)
            self.valueArray.insert(enrollmentNoData!, at: 1)
            self.valueArray.insert(admissionNoData!, at: 2)
            self.valueArray.insert(genderData!, at: 3)
            self.valueArray.insert(dobData!, at: 4)
            self.valueArray.insert(mobileNoData!, at: 5)
            self.valueArray.insert(categoryData!, at: 6)
            self.valueArray.insert(branchData!, at: 7)
            self.valueArray.insert(fatherNameData!, at: 8)
            self.valueArray.insert(motherNameData!, at: 9)
            self.valueArray.insert(parentMobileNoData!, at: 10)
            self.valueArray.insert(currentAddressData!, at: 11)
            self.valueArray.insert(primaryAddressData!, at: 12)
            self.valueArray.insert(cityData!, at: 13)
            self.valueArray.insert(aadharNoData!, at: 14)
            self.valueArray.insert(passportNoData!, at: 15)
            
            self.spinner.stopAnimating()
            
            self.view.addSubview(self.tableView)
            self.tableView.translatesAutoresizingMaskIntoConstraints = false
            self.tableView.isUserInteractionEnabled = true
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 61.0).isActive = true
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "studentPersonalDetailsCell", for: indexPath) as? StudentPersonalDetailsCell {
            cell.key.text = keyArray[indexPath.row]
            cell.value.text = valueArray[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
     
}
