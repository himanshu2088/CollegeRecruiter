//
//  StudentEducationalDetailsVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 30/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase

class StudentEducationalDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        label.text = "EDUCATIONAL DETAILS"
        label.font = UIFont(name: "Avenir-Medium", size: 18.0)
        label.textColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return label
    }()
    
    let currentUserUID = Auth.auth().currentUser?.uid
    let collectionRef = Firestore.firestore().collection("student")

    let keyArray = ["10th Board Name", "10th School Name", "10th %/CGPA", "10th Passing Year", "12th Board", "12th School", "12th Passing State", "12th Passing Year", "12th CGPA/%", "Graduation Passing Year", "Education Gap", "Number of Active Back", "Name of subjects with Active Backs", "Number of Total Backs", "Sem 1 SGPA", "Sem 2 SGPA", "Sem 3 SGPA", "Sem 4 SGPA", "Sem 5 SGPA", "Sem 6 SGPA", "Sem 7 SGPA", "Sem 8 SGPA", "Overall Graduation CGPA"]

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
            
        self.valueArray.insert(studentTenthBoard!, at: 0)
        self.valueArray.insert(studentTenthSchool!, at: 1)
        self.valueArray.insert(studentTenthCGPA!, at: 2)
        self.valueArray.insert(studentTenthPassYear!, at: 3)
        self.valueArray.insert(studentTwelBoard!, at: 4)
        self.valueArray.insert(studentTwelSchool!, at: 5)
        self.valueArray.insert(studentTwelPassState!, at: 6)
        self.valueArray.insert(studentTwelPassYear!, at: 7)
        self.valueArray.insert(studentTwelCGPA!, at: 8)
        self.valueArray.insert(studentGraduationPassYear!, at: 9)
        self.valueArray.insert(studentEducationGap!, at: 10)
        self.valueArray.insert(studentActiveBack!, at: 11)
        self.valueArray.insert(studentSubjectBack!, at: 12)
        self.valueArray.insert(studentTotalBack!, at: 13)
        self.valueArray.insert(studentSem1!, at: 14)
        self.valueArray.insert(studentSem2!, at: 15)
        self.valueArray.insert(studentSem3!, at: 16)
        self.valueArray.insert(studentSem4!, at: 17)
        self.valueArray.insert(studentSem5!, at: 18)
        self.valueArray.insert(studentSem6!, at: 19)
        self.valueArray.insert(studentSem7!, at: 20)
        self.valueArray.insert(studentSem8!, at: 21)
        self.valueArray.insert(studentOverallCGPA!, at: 22)
                    
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.isUserInteractionEnabled = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70.0).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        
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
