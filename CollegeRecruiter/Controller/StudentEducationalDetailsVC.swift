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
    
    let currentUserUID = Auth.auth().currentUser?.uid
    let collectionRef = Firestore.firestore().collection("student")

    let keyArray = ["10th Board Name", "10th School Name", "10th %/CGPA", "10th Passing Year", "12th Board", "12th School", "12th Passing State", "12th Passing Year", "12th CGPA/%", "Graduation Passing Year", "Education Gap", "Number of Active Back", "Name of subjects with Active Backs", "Number of Total Backs", "Sem 1 SGPA", "Sem 2 SGPA", "Sem 3 SGPA", "Sem 4 SGPA", "Sem 5 SGPA", "Sem 6 SGPA", "Sem 7 SGPA", "Sem 8 SGPA"]

    var valueArray = [String]()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "StudentEducationalDetailsCell", bundle: nil), forCellReuseIdentifier: "studentEducationalDetailsCell")
        tableView.allowsSelection = false
        tableView.rowHeight = 150
        tableView.backgroundColor = .white
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        spinner.startAnimating()
                
        collectionRef.document(currentUserUID!).getDocument { (snapshot, error) in
            let data = snapshot?.data()
            let tenthBoardData = data!["tenthBoard"] as? String
            let tenthSchoolData = data!["tenthSchool"] as? String
            let tenthCGPAData = data!["tenthPercentage"] as? String
            let tenthPassYearData = data!["tenthPassingYear"] as? String
            let twelBoardData = data!["twelBoard"] as? String
            let twelSchoolData = data!["twelSchool"] as? String
            let twelPassStateData = data!["twelPassState"] as? String
            let twelPassYearData = data!["twelPassingYear"] as? String
            let twelCGPAData = data!["twelCGPA"] as? String
            let graduationPassYearData = data!["graduationPassingYear"] as? String
            let educationGapData = data!["educationGap"] as? String
            let activeBackData = data!["activeBack"] as? String
            let backSubjectsData = data!["subjectBack"] as? String
            let totalBackData = data!["totalBack"] as? String
            let semOneData = data!["semOne"] as? String
            let semTwoData = data!["semtwo"] as? String
            let semThreeData = data!["semThree"] as? String
            let semFourData = data!["semFour"] as? String
            let semFiveData = data!["semFive"] as? String
            let semSixData = data!["semSix"] as? String
            let semSevenData = data!["semSeven"] as? String
            let semEightData = data!["semEight"] as? String
            
            self.valueArray.insert(tenthBoardData!, at: 0)
            self.valueArray.insert(tenthSchoolData!, at: 1)
            self.valueArray.insert(tenthCGPAData!, at: 2)
            self.valueArray.insert(tenthPassYearData!, at: 3)
            self.valueArray.insert(twelBoardData!, at: 4)
            self.valueArray.insert(twelSchoolData!, at: 5)
            self.valueArray.insert(twelPassStateData!, at: 6)
            self.valueArray.insert(twelPassYearData!, at: 7)
            self.valueArray.insert(twelCGPAData!, at: 8)
            self.valueArray.insert(graduationPassYearData!, at: 9)
            self.valueArray.insert(educationGapData!, at: 10)
            self.valueArray.insert(activeBackData!, at: 11)
            self.valueArray.insert(backSubjectsData!, at: 12)
            self.valueArray.insert(totalBackData!, at: 13)
            self.valueArray.insert(semOneData!, at: 14)
            self.valueArray.insert(semTwoData!, at: 15)
            self.valueArray.insert(semThreeData!, at: 16)
            self.valueArray.insert(semFourData!, at: 17)
            self.valueArray.insert(semFiveData!, at: 18)
            self.valueArray.insert(semSixData!, at: 19)
            self.valueArray.insert(semSevenData!, at: 20)
            self.valueArray.insert(semEightData!, at: 21)
            
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
        return valueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "studentEducationalDetailsCell", for: indexPath) as? StudentEducationalDetailsCell {
            cell.key.text = keyArray[indexPath.row]
            cell.value.text = valueArray[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }

}
