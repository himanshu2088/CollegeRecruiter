//
//  ParticularJobVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 05/05/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase

class ParticularJobVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        label.text = "JOB PROFILE"
        label.font = UIFont(name: "Avenir-Medium", size: 18.0)
        label.textColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return label
    }()
    
    var documentId: String?
    let userId = Auth.auth().currentUser?.uid
    
    var jobSem = "Default"
    var jobCGPA = "Default"
    
    let keyArray = ["Company Name", "Job Title", "Job Description", "Job Requirements", "Job Responsibilities", "Salary", "Tenth %/CGPA", "Twelfth %/CGPA", "Graduation %/CGPA", "Semester"]

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
    
    let applyJobBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Apply for Job", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25.0)
        button.layer.cornerRadius = 8.0
        button.layer.shadowColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 1.0
        button.backgroundColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        button.tintColor = .white
        return button
    }()
    
    @objc func applyJob(_ sender : UIButton) {
        Firestore.firestore().collection("job").document(documentId!).getDocument { (snapshot, error) in
            self.spinner.startAnimating()
            let studentsApplied = snapshot?.data()!["studentsApplied"] as? Array<String>
            if studentsApplied?.contains(self.userId!) == true {
                self.spinner.stopAnimating()
                let alert = UIAlertController(title: "Error", message: "You have already applied for this job.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            } else {
                Firestore.firestore().collection("student").document(self.userId!).getDocument { (snapshot, error) in
                    
                    let studentSem = snapshot?.data()!["semester"] as? String
                    let studentCGPA = snapshot?.data()!["overallCGPA"] as? String
                    
                    if Float(studentSem!)! >= Float(self.jobSem)! && Float(studentCGPA!)! >= Float(self.jobCGPA)! {
                        Firestore.firestore().collection("job").document(self.documentId!).updateData([
                            "studentsApplied" : ["\(self.userId!)"]
                        ]) { (error) in
                            if let error = error {
                                self.spinner.stopAnimating()
                                print("Error applying for jobs,\(error.localizedDescription)")
                            }
                            self.spinner.stopAnimating()
                            let alert = UIAlertController(title: "Success", message: "You have successfully applied for this job.", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                                self.dismiss(animated: true, completion: nil)
                            })
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        self.spinner.stopAnimating()
                        let alert = UIAlertController(title: "Error", message: "You are not eligible for the job.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
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
            let nameData = data!["companyName"] as? String
            let titleData = data!["jobTitle"] as? String
            let descData = data!["jobdescription"] as? String
            let requirementData = data!["jobrequirements"] as? String
            let responsibilityData = data!["jobresponsibilities"] as? String
            let salaryData = data!["salary"] as? String
            let tenth = data!["tenthCGPA"] as? String
            let twelfth = data!["twelfthCGPA"] as? String
            let graduation = data!["graduationCGPA"] as? String
            let semester = data!["semester"] as? String
            
            self.jobSem = semester!
            self.jobCGPA = graduation!
            
            self.valueArray.insert(nameData!, at: 0)
            self.valueArray.insert(titleData!, at: 1)
            self.valueArray.insert(descData!, at: 2)
            self.valueArray.insert(requirementData!, at: 3)
            self.valueArray.insert(responsibilityData!, at: 4)
            self.valueArray.insert(salaryData!, at: 5)
            self.valueArray.insert(tenth!, at: 6)
            self.valueArray.insert(twelfth!, at: 7)
            self.valueArray.insert(graduation!, at: 8)
            self.valueArray.insert(semester!, at: 9)
            
            self.spinner.stopAnimating()
            
            self.view.addSubview(self.applyJobBtn)
            self.applyJobBtn.translatesAutoresizingMaskIntoConstraints = false
            self.applyJobBtn.isUserInteractionEnabled = true
            self.applyJobBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80.0).isActive = true
            self.applyJobBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.applyJobBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            self.applyJobBtn.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
            self.applyJobBtn.addTarget(self, action: #selector(self.applyJob(_:)), for: .touchUpInside)
            
            self.view.addSubview(self.tableView)
            self.tableView.translatesAutoresizingMaskIntoConstraints = false
            self.tableView.isUserInteractionEnabled = true
            self.tableView.topAnchor.constraint(equalTo: self.applyJobBtn.bottomAnchor, constant: 10.0).isActive = true
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
