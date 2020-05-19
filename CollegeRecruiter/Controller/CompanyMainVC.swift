//
//  CompanyMainVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 01/05/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase

class CompanyMainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let verticalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "HOME"
        label.font = UIFont(name: "Avenir", size: 16.0)
        label.textColor = #colorLiteral(red: 1, green: 0.1019607843, blue: 0.1490196078, alpha: 1)
        return label
    }()
    
    let currentUserUID = Auth.auth().currentUser?.uid
    let collectionRef = Firestore.firestore().collection("company")
    var job = "1"
    
    let keyArray = ["Company Name", "Address", "City", "Contact", "Number of Jobs Posted"]
    
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

    var menuOut = false
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var companyName: UILabel!
    
    let menuBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Menu", for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Press '+' button to create a new job."
        label.font = UIFont(name: "Avenir-Medium", size: 20.0)
        label.textColor = #colorLiteral(red: 1, green: 0.1019607843, blue: 0.1490196078, alpha: 1)
        label.numberOfLines = 2
        return label
    }()
    
    @IBAction func addButton(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddJobVC") as? AddJobVC
        self.present(nextViewController!, animated:true, completion:nil)
    }
    
    @IBAction func menuBtnPressed(_ sender: UIButton) {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view2.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: self.view2.topAnchor, constant: 80.0).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        
        self.view2.addSubview(verticalLineView)
        verticalLineView.translatesAutoresizingMaskIntoConstraints = false
        verticalLineView.leadingAnchor.constraint(equalTo: self.view2.leadingAnchor, constant: 0.0).isActive = true
        verticalLineView.widthAnchor.constraint(equalToConstant: 0.7).isActive = true
        verticalLineView.heightAnchor.constraint(equalToConstant: self.view2.frame.height).isActive = true
        
        self.view2.addSubview(profileLabel)
        profileLabel.text = "HOME"
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.topAnchor.constraint(equalTo: self.view2.topAnchor, constant: 35.0).isActive = true
        profileLabel.centerXAnchor.constraint(equalTo: self.view2.centerXAnchor, constant: 0.0).isActive = true
        
        addButton.isHidden = false
                
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                
        self.view2.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.leadingAnchor.constraint(equalTo: self.view2.leadingAnchor, constant: 40.0).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view2.trailingAnchor, constant: -40.0).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view2.centerYAnchor, constant: 0.0).isActive = true
        
        Firestore.firestore().collection("job").whereField("companyEmail", isEqualTo: (Auth.auth().currentUser?.email)!).getDocuments { (snapshot, error) in
            let jobNo = snapshot?.count
            self.job = "\(jobNo!)"
        }
        
        let currentDate = Date()
        
        Firestore.firestore().collection("job").whereField("companyEmail", isEqualTo: (Auth.auth().currentUser?.email)!).getDocuments { (snapshot, error) in
            let documents = snapshot?.documents
            for document in documents! {
                let documentId = document.documentID
                let jobTime = document.data()["time"] as? Timestamp
                let name = document.data()["companyName"] as? String
                
                self.companyName.text = name!
                
                let diff = Calendar.current.dateComponents([.day], from: (jobTime?.dateValue())!, to: currentDate)
                
                let daysLeft = (diff.day)!
                
                if daysLeft > 45 {
                    Firestore.firestore().collection("job").document(documentId).delete()
                }
            }
        }
        
    }
    
    @IBAction func homeBtnPressed(_ sender: UIButton) {
        leading.constant = 0
        trailing.constant = 0
        
        addButton.isHidden = false
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
        }
        
        tableView.removeFromSuperview()
        
        viewDidLoad()
    }
    
    @IBAction func profileBtnPressed(_ sender: UIButton) {
        setupProfileView()
    }
    
    func setupProfileView() {
        leading.constant = 0
        trailing.constant = 0
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        label.removeFromSuperview()
        addButton.isHidden = true
        spinner.startAnimating()
        
        self.view2.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: self.view2.topAnchor, constant: 80.0).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: self.view2.frame.width).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        
        self.profileLabel.text = "PROFILE"
        
        self.view2.addSubview(verticalLineView)
        verticalLineView.translatesAutoresizingMaskIntoConstraints = false
        verticalLineView.leadingAnchor.constraint(equalTo: self.view2.leadingAnchor, constant: 0.0).isActive = true
        verticalLineView.widthAnchor.constraint(equalToConstant: 0.7).isActive = true
        verticalLineView.heightAnchor.constraint(equalToConstant: self.view2.frame.height).isActive = true

        collectionRef.document(currentUserUID!).getDocument { (snapshot, error) in
            let data = snapshot?.data()
            let nameData = data!["companyName"] as? String
            let addressData = data!["address"] as? String
            let cityData = data!["city"] as? String
            let contactData = data!["contact"] as? String
            
            self.valueArray.insert(nameData!, at: 0)
            self.valueArray.insert(addressData!, at: 1)
            self.valueArray.insert(cityData!, at: 2)
            self.valueArray.insert(contactData!, at: 3)
            self.valueArray.insert(self.job, at: 4)
            
            self.spinner.stopAnimating()
            self.view2.addSubview(self.tableView)
            self.tableView.translatesAutoresizingMaskIntoConstraints = false
            self.tableView.isUserInteractionEnabled = true
            self.tableView.topAnchor.constraint(equalTo: self.view2.topAnchor, constant: 81.0).isActive = true
            self.tableView.leadingAnchor.constraint(equalTo: self.view2.leadingAnchor, constant: 1.0).isActive = true
            self.tableView.bottomAnchor.constraint(equalTo: self.view2.bottomAnchor, constant: 0.0).isActive = true
            self.tableView.trailingAnchor.constraint(equalTo: self.view2.trailingAnchor, constant: 0.0).isActive = true
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keyArray.count
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
    
    @IBAction func jobsBtnPressed(_ sender: UIButton) {
        showJobs()
    }
    
    func showJobs() {
        leading.constant = 0
        trailing.constant = 0
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyPostedJobsVC") as? CompanyPostedJobsVC
        self.present(nextViewController!, animated:true, completion:nil)
        
    }
    
    @IBAction func feedbackBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func logoutBtnPressed(_ sender: UIButton) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
}

//girish.joshi21972@gmail.com
