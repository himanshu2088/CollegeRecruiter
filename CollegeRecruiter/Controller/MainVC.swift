//
//  MainVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 27/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController {
    
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let currentUserUID = Auth.auth().currentUser?.uid
    let collectionRef = Firestore.firestore().collection("student")
    
    let homeView: UIView = {
        let view = UIView()
        return view
    }()
    
    let profileView: UIView = {
        let view = UIView()
        return view
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    var menuOut = false
        
    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 30.0)
        return label
    }()
    
    let admissionNo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Admission No."
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
        return label
    }()
    
    let admissionNoText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    let branchText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    let mobileText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func menuTap(_ sender: UIButton) {
        if menuOut == false {
            leading.constant = 250
            trailing.constant = -250
            menuOut = true
        } else {
            leading.constant = 0
            trailing.constant = 0
            menuOut = false
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
        }
    }
    
    @IBAction func homeBtnPressed(_ sender: UIButton) {
        
        leading.constant = 0
        trailing.constant = 0
        
        self.profileView.removeFromSuperview()
        self.view2.addSubview(homeView)
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        homeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        homeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        homeView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50.0).isActive = true
        homeView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        
        self.homeView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.homeView.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.homeView.centerXAnchor).isActive = true
        
        spinner.startAnimating()
        
        collectionRef.document(currentUserUID!).getDocument { (snapshot, error) in
            let data = snapshot?.data()
            let nameData = data!["name"] as? String
            let admissionNoData = data!["admissionNo"] as? String
            let branchData = data!["branch"] as? String
            let mobileNo = data!["mobileNo"] as? String
            
            self.spinner.stopAnimating()
            self.name.text = nameData!
            self.nameLabel.text = nameData!
            self.admissionNoText.text = admissionNoData!
            self.mobileText.text = mobileNo!
            self.branchText.text = "B.Tech " + branchData!
            
            self.homeView.addSubview(self.name)
            self.name.translatesAutoresizingMaskIntoConstraints = false
            self.name.centerXAnchor.constraint(equalTo: self.homeView.centerXAnchor, constant: 0.0).isActive = true
            self.name.centerYAnchor.constraint(equalTo: self.homeView.centerYAnchor, constant: -100.0).isActive = true
            
            self.homeView.addSubview(self.admissionNo)
            self.admissionNo.translatesAutoresizingMaskIntoConstraints = false
            self.admissionNo.leadingAnchor.constraint(equalTo: self.homeView.leadingAnchor, constant: 20.0).isActive = true
            self.admissionNo.centerYAnchor.constraint(equalTo: self.homeView.centerYAnchor, constant: 20.0).isActive = true
            
            self.homeView.addSubview(self.branch)
            self.branch.translatesAutoresizingMaskIntoConstraints = false
            self.branch.leadingAnchor.constraint(equalTo: self.homeView.leadingAnchor, constant: 20.0).isActive = true
            self.branch.topAnchor.constraint(equalTo: self.admissionNo.bottomAnchor, constant: 35.0).isActive = true
            
            self.homeView.addSubview(self.mobile)
            self.mobile.translatesAutoresizingMaskIntoConstraints = false
            self.mobile.leadingAnchor.constraint(equalTo: self.homeView.leadingAnchor, constant: 20.0).isActive = true
            self.mobile.topAnchor.constraint(equalTo: self.branch.bottomAnchor, constant: 35.0).isActive = true
            
            self.homeView.addSubview(self.mobileText)
            self.mobileText.translatesAutoresizingMaskIntoConstraints = false
            self.mobileText.trailingAnchor.constraint(equalTo: self.homeView.trailingAnchor, constant: -20.0).isActive = true
            self.mobileText.centerYAnchor.constraint(equalTo: self.mobile.centerYAnchor, constant: 0.0).isActive = true
            self.mobileText.widthAnchor.constraint(equalToConstant: 160.0).isActive = true
            
            self.homeView.addSubview(self.admissionNoText)
            self.admissionNoText.translatesAutoresizingMaskIntoConstraints = false
            self.admissionNoText.trailingAnchor.constraint(equalTo: self.homeView.trailingAnchor, constant: -20.0).isActive = true
            self.admissionNoText.centerYAnchor.constraint(equalTo: self.admissionNo.centerYAnchor, constant: 0.0).isActive = true
            self.admissionNoText.widthAnchor.constraint(equalToConstant: 160.0).isActive = true
            
            self.homeView.addSubview(self.branchText)
            self.branchText.translatesAutoresizingMaskIntoConstraints = false
            self.branchText.trailingAnchor.constraint(equalTo: self.homeView.trailingAnchor, constant: -20.0).isActive = true
            self.branchText.centerYAnchor.constraint(equalTo: self.branch.centerYAnchor, constant: 0.0).isActive = true
            self.branchText.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
            self.branchText.widthAnchor.constraint(equalToConstant: 160.0).isActive = true
            
        }
        
    }
    
    @IBAction func profileBtnPressed(_ sender: UIButton) {
        leading.constant = 0
        trailing.constant = 0
    }
    
    @IBAction func jobsBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func myJobsBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func feedback(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            let mobileNo = data!["mobileNo"] as? String
            
            self.spinner.stopAnimating()
            self.name.text = nameData!
            self.nameLabel.text = nameData!
            self.admissionNoText.text = admissionNoData!
            self.mobileText.text = mobileNo!
            self.branchText.text = "B.Tech " + branchData!
            
            self.view2.addSubview(self.name)
            self.name.translatesAutoresizingMaskIntoConstraints = false
            self.name.centerXAnchor.constraint(equalTo: self.view2.centerXAnchor, constant: 0.0).isActive = true
            self.name.centerYAnchor.constraint(equalTo: self.view2.centerYAnchor, constant: -100.0).isActive = true
            
            self.view2.addSubview(self.admissionNo)
            self.admissionNo.translatesAutoresizingMaskIntoConstraints = false
            self.admissionNo.leadingAnchor.constraint(equalTo: self.view2.leadingAnchor, constant: 20.0).isActive = true
            self.admissionNo.centerYAnchor.constraint(equalTo: self.view2.centerYAnchor, constant: 20.0).isActive = true
            
            self.view2.addSubview(self.branch)
            self.branch.translatesAutoresizingMaskIntoConstraints = false
            self.branch.leadingAnchor.constraint(equalTo: self.view2.leadingAnchor, constant: 20.0).isActive = true
            self.branch.topAnchor.constraint(equalTo: self.admissionNo.bottomAnchor, constant: 35.0).isActive = true
            
            self.view2.addSubview(self.mobile)
            self.mobile.translatesAutoresizingMaskIntoConstraints = false
            self.mobile.leadingAnchor.constraint(equalTo: self.view2.leadingAnchor, constant: 20.0).isActive = true
            self.mobile.topAnchor.constraint(equalTo: self.branch.bottomAnchor, constant: 35.0).isActive = true
            
            self.view2.addSubview(self.mobileText)
            self.mobileText.translatesAutoresizingMaskIntoConstraints = false
            self.mobileText.trailingAnchor.constraint(equalTo: self.view2.trailingAnchor, constant: -20.0).isActive = true
            self.mobileText.centerYAnchor.constraint(equalTo: self.mobile.centerYAnchor, constant: 0.0).isActive = true
            self.mobileText.widthAnchor.constraint(equalToConstant: 160.0).isActive = true
            
            self.view2.addSubview(self.admissionNoText)
            self.admissionNoText.translatesAutoresizingMaskIntoConstraints = false
            self.admissionNoText.trailingAnchor.constraint(equalTo: self.view2.trailingAnchor, constant: -20.0).isActive = true
            self.admissionNoText.centerYAnchor.constraint(equalTo: self.admissionNo.centerYAnchor, constant: 0.0).isActive = true
            self.admissionNoText.widthAnchor.constraint(equalToConstant: 160.0).isActive = true
            
            self.view2.addSubview(self.branchText)
            self.branchText.translatesAutoresizingMaskIntoConstraints = false
            self.branchText.trailingAnchor.constraint(equalTo: self.view2.trailingAnchor, constant: -20.0).isActive = true
            self.branchText.centerYAnchor.constraint(equalTo: self.branch.centerYAnchor, constant: 0.0).isActive = true
            self.branchText.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
            self.branchText.widthAnchor.constraint(equalToConstant: 160.0).isActive = true
            
        }
    
    }

}

//himanshujoshi2088@gmail.com

