//
//  MyJobsVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 05/05/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase

class MyJobsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myjobTitleArray = [String]()
    var myjobsCompanyArray = [String]()
    var myjobsSalaryArray = [String]()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "MyJobsCell", bundle: nil), forCellReuseIdentifier: "myJobsCell")
        tableView.rowHeight = 105.0
        tableView.allowsSelection = true
        tableView.backgroundColor = .white
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
        
        Firestore.firestore().collection("job").whereField("studentsApplied", arrayContains: (Auth.auth().currentUser?.uid)!).getDocuments { (snapshot, error) in
            let documents = snapshot?.documents
            for document in documents! {
                let jobTitle = document.data()["jobTitle"] as? String
                let jobsalary = document.data()["salary"] as? String
                let jobCompany = document.data()["companyName"] as? String
                self.myjobTitleArray.append(jobTitle!)
                self.myjobsSalaryArray.append(jobsalary!)
                self.myjobsCompanyArray.append(jobCompany!)
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
        return myjobTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "myJobsCell", for: indexPath) as? MyJobsCell {
            cell.myJobTitle.text = myjobTitleArray[indexPath.row]
            cell.myJobCompany.text = myjobsCompanyArray[indexPath.row]
            cell.myJobSalary.text = "Salary " + myjobsSalaryArray[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }

}