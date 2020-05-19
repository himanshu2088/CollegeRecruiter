//
//  ParticularStudentVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 06/05/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase

class ParticularStudentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        label.text = "PROFILE"
        label.font = UIFont(name: "Avenir", size: 16.0)
        label.textColor = #colorLiteral(red: 1, green: 0.1019607843, blue: 0.1490196078, alpha: 1)
        return label
    }()
    
    var documentId: String?
    
    let keyArray = ["Name", "Enrollment No", "DOB", "Gender", "Mobile", "Email", "Skills", "Graduation Pass Year", "Education Gap", "Internship Details", "Total back", "Tenth CGPA/%", "Twelfth CGPA/%", "1st Sem SGPA", "2st Sem SGPA", "3st Sem SGPA", "4st Sem SGPA", "5st Sem SGPA", "6st Sem SGPA", "7st Sem SGPA", "8st Sem SGPA"]
    
    var valueArray = [String]()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "AppliedStudentsDataCell", bundle: nil), forCellReuseIdentifier: "appliedStudentsDataCell")
        tableView.allowsSelection = false
        tableView.rowHeight = 150
        tableView.backgroundColor = .white
        return tableView
    }()
    
    let sendMailBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Mail", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20.0)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.1019607843, blue: 0.1490196078, alpha: 1)
        button.tintColor = .white
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
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
        
        spinner.startAnimating()

        Firestore.firestore().collection("student").document(documentId!).getDocument { (snapshot, error) in
            let data = snapshot?.data()
            let name = data!["name"] as? String
            let enrollmentNo = data!["enrollmentNo"] as? String
            let dob = data!["dob"] as? String
            let gender = data!["gender"] as? String
            let mobile = data!["mobileNo"] as? String
            let email = data!["email"] as? String
            let skills = data!["skills"] as? String
            let graduationPassYear = data!["graduationPassingYear"] as? String
            let internship = data!["internshipDetails"] as? String
            let educationGap = data!["educationGap"] as? String
            let totalBack = data!["totalBack"] as? String
            let tenth = data!["tenthPercentage"] as? String
            let twelfth = data!["twelCGPA"] as? String
            let firstSem = data!["semOne"] as? String
            let secondSem = data!["semtwo"] as? String
            let thirdSem = data!["semThree"] as? String
            let fourthSem = data!["semFour"] as? String
            let fifthSem = data!["semFive"] as? String
            let sixthSem = data!["semSix"] as? String
            let seventhSem = data!["semSeven"] as? String
            let eighthSem = data!["semEight"] as? String
            
            self.valueArray.insert(name!, at: 0)
            self.valueArray.insert(enrollmentNo!, at: 1)
            self.valueArray.insert(dob!, at: 2)
            self.valueArray.insert(gender!, at: 3)
            self.valueArray.insert(mobile!, at: 4)
            self.valueArray.insert(email!, at: 5)
            self.valueArray.insert(skills!, at: 6)
            self.valueArray.insert(graduationPassYear!, at: 7)
            self.valueArray.insert(internship!, at: 8)
            self.valueArray.insert(educationGap!, at: 9)
            self.valueArray.insert(totalBack!, at: 10)
            self.valueArray.insert(tenth!, at: 11)
            self.valueArray.insert(twelfth!, at: 12)
            self.valueArray.insert(firstSem!, at: 13)
            self.valueArray.insert(secondSem!, at: 14)
            self.valueArray.insert(thirdSem!, at: 15)
            self.valueArray.insert(fourthSem!, at: 16)
            self.valueArray.insert(fifthSem!, at: 17)
            self.valueArray.insert(sixthSem!, at: 18)
            self.valueArray.insert(seventhSem!, at: 19)
            self.valueArray.insert(eighthSem!, at: 20)
            
            
            self.spinner.stopAnimating()
            
            self.view.addSubview(self.sendMailBtn)
            self.sendMailBtn.translatesAutoresizingMaskIntoConstraints = false
            self.sendMailBtn.isUserInteractionEnabled = true
            self.sendMailBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80.0).isActive = true
            self.sendMailBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.sendMailBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.sendMailBtn.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
            
            self.view.addSubview(self.tableView)
            self.tableView.translatesAutoresizingMaskIntoConstraints = false
            self.tableView.isUserInteractionEnabled = true
            self.tableView.topAnchor.constraint(equalTo: self.sendMailBtn.bottomAnchor, constant: 10.0).isActive = true
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "appliedStudentsDataCell", for: indexPath) as? AppliedStudentsDataCell {
            cell.key.text = keyArray[indexPath.row]
            cell.value.text = valueArray[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }

}
