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
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    var jobsArray = [String]()
    var jobsDescriptionArray = [String]()
    var jobsDocumentIdArray = [String]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "JobsCell", bundle: nil), forCellReuseIdentifier: "jobsCell")
        tableView.rowHeight = 117.0
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
                        
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        spinner.startAnimating()
        
        
        Firestore.firestore().collection("job").whereField("companyEmail", isEqualTo: (Auth.auth().currentUser?.email)!).getDocuments { (snapshot, error) in
            let documents = snapshot?.documents
            for document in documents! {
                let documentId = document.documentID
                let jobTitle = document.data()["jobTitle"] as? String
                let jobDescription = document.data()["jobdescription"] as? String
                self.jobsDocumentIdArray.append(documentId)
                self.jobsArray.append(jobTitle!)
                self.jobsDescriptionArray.append(jobDescription!)
            }

            self.spinner.stopAnimating()

            self.view.addSubview(self.tableView)
            self.tableView.translatesAutoresizingMaskIntoConstraints = false
            self.tableView.isUserInteractionEnabled = true
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60.0).isActive = true
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
