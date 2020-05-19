//
//  CompanyPostedJobsVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 07/05/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase

class CompanyPostedJobsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        label.text = "POSTED JOBS"
        label.font = UIFont(name: "Avenir", size: 16.0)
        label.textColor = #colorLiteral(red: 1, green: 0.1019607843, blue: 0.1490196078, alpha: 1)
        return label
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    var jobsArray = [String]()
    var jobsDescriptionArray = [String]()
    var jobsDocumentIdArray = [String]()
    var jobTime = [Int]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "JobsCell", bundle: nil), forCellReuseIdentifier: "jobsCell")
        tableView.rowHeight = 137.0
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        return tableView
    }()

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
        
        let currentDate = Date()
        
        Firestore.firestore().collection("job").whereField("companyEmail", isEqualTo: (Auth.auth().currentUser?.email)!).getDocuments { (snapshot, error) in
            let documents = snapshot?.documents
            for document in documents! {
                let documentId = document.documentID
                let jobTitle = document.data()["jobTitle"] as? String
                let jobDescription = document.data()["jobdescription"] as? String
                let jobTime = document.data()["time"] as? Timestamp
                
                let diff = Calendar.current.dateComponents([.day], from: (jobTime?.dateValue())!, to: currentDate)
                
                let daysLeft = (diff.day)!
                
                self.jobTime.append(daysLeft)
                self.jobsDocumentIdArray.append(documentId)
                self.jobsArray.append(jobTitle!)
                self.jobsDescriptionArray.append(jobDescription!)
            }

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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "jobsCell", for: indexPath) as? JobsCell {
            cell.jobTitle.text = jobsArray[indexPath.row]
            cell.jobDescription.text = jobsDescriptionArray[indexPath.row]
            if jobTime[indexPath.row] > 0 {
                cell.day.text = "Posted " + "\(jobTime[indexPath.row])" + " day ago"
            } else {
                cell.day.text = "Posted today"
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AppliedStudentsVC") as? AppliedStudentsVC
        nextViewController?.documentId = jobsDocumentIdArray[indexPath.row]
        self.present(nextViewController!, animated:true, completion:nil)
    }

}
