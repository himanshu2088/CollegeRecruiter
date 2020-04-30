//
//  StudentSkillsDetailsVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 30/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase

class StudentSkillsDetailsVC: UIViewController {
    
    let currentUserUID = Auth.auth().currentUser?.uid
    let collectionRef = Firestore.firestore().collection("student")

    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    let skills: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 25.0)
        label.text = "Skills"
        label.numberOfLines = 3
        return label
    }()
    
    let internship: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 25.0)
        label.text = "Internship Details"
        label.numberOfLines = 3
        return label
    }()
    
    let skillsText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 6
        return label
    }()
    
    let internshipText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 6
        return label
    }()
    
    func getSkillsDetails() {
        spinner.startAnimating()
                
        collectionRef.document(currentUserUID!).getDocument { (snapshot, error) in
            let data = snapshot?.data()
            let skillsData = data!["skills"] as? String
            let internshipData = data!["internshipDetails"] as? String
            
            self.spinner.stopAnimating()
            
            self.skillsText.text = skillsData!
            self.internshipText.text = internshipData!
            
            self.view.addSubview(self.skills)
            self.skills.translatesAutoresizingMaskIntoConstraints = false
            self.skills.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60.0).isActive = true
            self.skills.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true

            self.view.addSubview(self.skillsText)
            self.skillsText.translatesAutoresizingMaskIntoConstraints = false
            self.skillsText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.skillsText.topAnchor.constraint(equalTo: self.skills.bottomAnchor, constant: 10.0).isActive = true
            self.skillsText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            
            self.view.addSubview(self.internship)
            self.internship.translatesAutoresizingMaskIntoConstraints = false
            self.internship.topAnchor.constraint(equalTo: self.skillsText.bottomAnchor, constant: 20.0).isActive = true
            self.internship.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true

            self.view.addSubview(self.internshipText)
            self.internshipText.translatesAutoresizingMaskIntoConstraints = false
            self.internshipText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.internshipText.topAnchor.constraint(equalTo: self.internship.bottomAnchor, constant: 10.0).isActive = true
            self.internshipText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        getSkillsDetails()
        
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
