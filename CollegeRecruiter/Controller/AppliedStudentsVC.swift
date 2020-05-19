//
//  AppliedStudentsVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 05/05/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase

class AppliedStudentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        label.text = "STUDENTS APPLIED"
        label.font = UIFont(name: "Avenir", size: 16.0)
        label.textColor = #colorLiteral(red: 1, green: 0.1019607843, blue: 0.1490196078, alpha: 1)
        return label
    }()
    
    var documentId: String?
    var appliedStudentIdArray = [String]()
    
    var studentNameArray = [String]()
    var skillsArray = [String]()
    var documentidArray = [String]()

    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "AppliedStudents", bundle: nil), forCellReuseIdentifier: "appliedStudents")
        tableView.rowHeight = 99.0
        tableView.allowsSelection = true
        tableView.backgroundColor = .white
        return tableView
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
        
        Firestore.firestore().collection("job").document(documentId!).getDocument { (snapshot, error) in
            let data = snapshot?.data()
            let appliedStudents = (data!["studentsApplied"] as? [String])!
            self.appliedStudentIdArray = appliedStudents
            
            for student in self.appliedStudentIdArray {
                Firestore.firestore().collection("student").document(student).getDocument { (snapshot, error) in
                    let data = snapshot?.data()
                    let id = snapshot?.documentID
                    let studentName = data!["name"] as? String
                    let studentSkills = data!["skills"] as? String
                    self.studentNameArray.append(studentName!)
                    self.skillsArray.append(studentSkills!)
                    self.documentidArray.append(id!)
                    
                    self.spinner.stopAnimating()
                    
                    self.view.addSubview(self.tableView)
                    self.tableView.translatesAutoresizingMaskIntoConstraints = false
                    self.tableView.isUserInteractionEnabled = true
                    self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80.0).isActive = true
                    self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
                    self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
                    self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "appliedStudents", for: indexPath) as? AppliedStudents {
            cell.studentName.text = studentNameArray[indexPath.row]
            cell.studentSkills.text = skillsArray[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ParticularStudentVC") as? ParticularStudentVC
        nextViewController?.documentId = documentidArray[indexPath.row]
        self.present(nextViewController!, animated:true, completion:nil)
    }
    
}



//girish.joshi21972@gmail.com
