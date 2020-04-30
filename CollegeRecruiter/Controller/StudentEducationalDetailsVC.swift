//
//  StudentEducationalDetailsVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 30/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase

class StudentEducationalDetailsVC: UIViewController {
    
    let currentUserUID = Auth.auth().currentUser?.uid
    let collectionRef = Firestore.firestore().collection("student")

    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    let scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    let tenthBoard: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "10th Board Name"
        label.numberOfLines = 3
        return label
    }()
    
    let tenthSchool : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "10th School Name"
        label.numberOfLines = 3
        return label
    }()
    
    let tenthCGPA: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "10th CGPA/%"
        label.numberOfLines = 3
        return label
    }()
    
    let tenthPassingYear: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "10th Passing Year"
        label.numberOfLines = 3
        return label
    }()
    
    let twelBoard: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "12th/Diploma Board Name"
        label.numberOfLines = 3
        return label
    }()
    
    let twelSchool: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "12th/Diploma School Name"
        label.numberOfLines = 3
        return label
    }()

    let twelPassState: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "12th/Diploma Passing State"
        label.numberOfLines = 3
        return label
    }()

    let twelPassingYear: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "12th/Diploma Passing year"
        label.numberOfLines = 3
        return label
    }()

    let twelCGPA: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "12th/Diploma CGPA/%"
        label.numberOfLines = 3
        return label
    }()
    
    let graduationPassingYear: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Graduation Passing Year"
        label.numberOfLines = 3
        return label
    }()

    let educationGap: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Education Gap"
        label.numberOfLines = 3
        return label
    }()

    let activeBack: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "No. of Active Backlogs"
        label.numberOfLines = 3
        return label
    }()
    
    let backSubjects: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Subject of active backlogs"
        label.numberOfLines = 3
        return label
    }()

    let totalBack: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Total backlogs"
        label.numberOfLines = 3
        return label
    }()

    let semOne: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Sem 1 SGPA"
        return label
    }()
    
    let semTwo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Sem 2 SGPA"
        return label
    }()
    
    let semThree: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Sem 3 SGPA"
        return label
    }()
    
    let semFour: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Sem 4 SGPA"
        return label
    }()
    
    let semFive: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Sem 5 SGPA"
        return label
    }()
    
    let semSix: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Sem 6 SGPA"
        return label
    }()
    
    let semSeven: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Sem 7 SGPA"
        return label
    }()

    let semEight: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.text = "Sem 8 SGPA"
        return label
    }()
    
    let tenthBoardText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 3
        return label
    }()
    
    let tenthSchoolText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 4
        return label
    }()
    
    let tenthCGPAText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    let tenthPassingYearText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    let twelBoardText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 3
        return label
    }()
    
    let twelSchoolText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 4
        return label
    }()

    let twelPassStateText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 2
        return label
    }()

    let twelPassingYearText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()

    let twelCGPAText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    let graduationPassingYearText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()

    let educationGapText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()

    let activeBackText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    let backSubjectsText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.numberOfLines = 4
        return label
    }()

    let totalBackText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()

    let semOneText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    let semTwoText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    let semThreeText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    let semFourText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    let semFiveText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    let semSixText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    let semSevenText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()

    let semEightText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    func getEducationalDetails() {
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
            let graduationPassYearData = data!["qualificationDiplomaOrTwelfth"] as? String
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
            
            self.spinner.stopAnimating()
            
            self.tenthBoardText.text = tenthBoardData!
            self.tenthSchoolText.text = tenthSchoolData!
            self.tenthCGPAText.text = tenthCGPAData!
            self.tenthPassingYearText.text = tenthPassYearData!
            self.twelBoardText.text = twelBoardData!
            self.twelPassingYearText.text = twelPassYearData!
            self.twelPassStateText.text = twelPassStateData!
            self.twelSchoolText.text = twelSchoolData!
            self.twelCGPAText.text = twelCGPAData!
            self.graduationPassingYearText.text = graduationPassYearData!
            self.educationGapText.text = educationGapData!
            self.activeBackText.text = activeBackData!
            self.backSubjectsText.text = backSubjectsData!
            self.totalBackText.text = totalBackData!
            self.semOneText.text = semOneData!
            self.semTwoText.text = semTwoData!
            self.semThreeText.text = semThreeData!
            self.semFourText.text = semFourData!
            self.semFiveText.text = semFiveData!
            self.semSixText.text = semSixData!
            self.semSevenText.text = semSevenData!
            self.semEightText.text = semEightData!
            
            self.view.addSubview(self.scrollView)
            self.scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60.0).isActive = true
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
            
            self.scrollView.addSubview(self.tenthBoard)
            self.tenthBoard.translatesAutoresizingMaskIntoConstraints = false
            self.tenthBoard.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0.0).isActive = true
            self.tenthBoard.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.tenthBoard.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.tenthSchool)
            self.tenthSchool.translatesAutoresizingMaskIntoConstraints = false
            self.tenthSchool.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.tenthSchool.topAnchor.constraint(equalTo: self.tenthBoard.bottomAnchor, constant: 30.0).isActive = true
            self.tenthSchool.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.tenthCGPA)
            self.tenthCGPA.translatesAutoresizingMaskIntoConstraints = false
            self.tenthCGPA.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.tenthCGPA.topAnchor.constraint(equalTo: self.tenthSchool.bottomAnchor, constant: 30.0).isActive = true
            self.tenthCGPA.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.tenthPassingYear)
            self.tenthPassingYear.translatesAutoresizingMaskIntoConstraints = false
            self.tenthPassingYear.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.tenthPassingYear.topAnchor.constraint(equalTo: self.tenthCGPA.bottomAnchor, constant: 10.0).isActive = true
            self.tenthPassingYear.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.twelBoard)
            self.twelBoard.translatesAutoresizingMaskIntoConstraints = false
            self.twelBoard.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.twelBoard.topAnchor.constraint(equalTo: self.tenthPassingYear.bottomAnchor, constant: 30.0).isActive = true
            self.twelBoard.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.twelSchool)
            self.twelSchool.translatesAutoresizingMaskIntoConstraints = false
            self.twelSchool.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.twelSchool.topAnchor.constraint(equalTo: self.twelBoard.bottomAnchor, constant: 30.0).isActive = true
            self.twelSchool.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.twelPassState)
            self.twelPassState.translatesAutoresizingMaskIntoConstraints = false
            self.twelPassState.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20.0).isActive = true
            self.twelPassState.topAnchor.constraint(equalTo: self.twelSchool.bottomAnchor, constant: 30.0).isActive = true
            self.twelPassState.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.twelPassingYear)
            self.twelPassingYear.translatesAutoresizingMaskIntoConstraints = false
            self.twelPassingYear.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.twelPassingYear.topAnchor.constraint(equalTo: self.twelPassState.bottomAnchor, constant: 10.0).isActive = true
            self.twelPassingYear.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.twelCGPA)
            self.twelCGPA.translatesAutoresizingMaskIntoConstraints = false
            self.twelCGPA.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.twelCGPA.topAnchor.constraint(equalTo: self.twelPassingYear.bottomAnchor, constant: 10.0).isActive = true
            self.twelCGPA.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.graduationPassingYear)
            self.graduationPassingYear.translatesAutoresizingMaskIntoConstraints = false
            self.graduationPassingYear.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.graduationPassingYear.topAnchor.constraint(equalTo: self.twelCGPA.bottomAnchor, constant: 10.0).isActive = true
            self.graduationPassingYear.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.educationGap)
            self.educationGap.translatesAutoresizingMaskIntoConstraints = false
            self.educationGap.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.educationGap.topAnchor.constraint(equalTo: self.graduationPassingYear.bottomAnchor, constant: 10.0).isActive = true
            self.educationGap.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.activeBack)
            self.activeBack.translatesAutoresizingMaskIntoConstraints = false
            self.activeBack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.activeBack.topAnchor.constraint(equalTo: self.educationGap.bottomAnchor, constant: 10.0).isActive = true
            self.activeBack.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.backSubjects)
            self.backSubjects.translatesAutoresizingMaskIntoConstraints = false
            self.backSubjects.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.backSubjects.topAnchor.constraint(equalTo: self.activeBack.bottomAnchor, constant: 30.0).isActive = true
            self.backSubjects.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.totalBack)
            self.totalBack.translatesAutoresizingMaskIntoConstraints = false
            self.totalBack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.totalBack.topAnchor.constraint(equalTo: self.backSubjects.bottomAnchor, constant: 30.0).isActive = true
            self.totalBack.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.semOne)
            self.semOne.translatesAutoresizingMaskIntoConstraints = false
            self.semOne.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.semOne.topAnchor.constraint(equalTo: self.totalBack.bottomAnchor, constant: 20.0).isActive = true
            self.semOne.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true
            
            self.scrollView.addSubview(self.semTwo)
            self.semTwo.translatesAutoresizingMaskIntoConstraints = false
            self.semTwo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.semTwo.topAnchor.constraint(equalTo: self.semOne.bottomAnchor, constant: 20.0).isActive = true
            self.semTwo.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true
            
            self.scrollView.addSubview(self.semThree)
            self.semThree.translatesAutoresizingMaskIntoConstraints = false
            self.semThree.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.semThree.topAnchor.constraint(equalTo: self.semTwo.bottomAnchor, constant: 20.0).isActive = true
            self.semThree.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true
            
            self.scrollView.addSubview(self.semFour)
            self.semFour.translatesAutoresizingMaskIntoConstraints = false
            self.semFour.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.semFour.topAnchor.constraint(equalTo: self.semThree.bottomAnchor, constant: 20.0).isActive = true
            self.semFour.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true
            
            self.scrollView.addSubview(self.semFive)
            self.semFive.translatesAutoresizingMaskIntoConstraints = false
            self.semFive.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.semFive.topAnchor.constraint(equalTo: self.semFour.bottomAnchor, constant: 20.0).isActive = true
            self.semFive.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true
            
            self.scrollView.addSubview(self.semSix)
            self.semSix.translatesAutoresizingMaskIntoConstraints = false
            self.semSix.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.semSix.topAnchor.constraint(equalTo: self.semFive.bottomAnchor, constant: 20.0).isActive = true
            self.semSix.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true
            
            self.scrollView.addSubview(self.semSeven)
            self.semSeven.translatesAutoresizingMaskIntoConstraints = false
            self.semSeven.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.semSeven.topAnchor.constraint(equalTo: self.semSix.bottomAnchor, constant: 20.0).isActive = true
            self.semSeven.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true

            self.scrollView.addSubview(self.semEight)
            self.semEight.translatesAutoresizingMaskIntoConstraints = false
            self.semEight.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.semEight.topAnchor.constraint(equalTo: self.semSeven.bottomAnchor, constant: 20.0).isActive = true
            self.semEight.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -30.0).isActive = true
            self.semEight.widthAnchor.constraint(equalToConstant: self.view.frame.width/2 - 20).isActive = true
            
            self.scrollView.addSubview(self.tenthBoardText)
            self.tenthBoardText.translatesAutoresizingMaskIntoConstraints = false
            self.tenthBoardText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.tenthBoardText.centerYAnchor.constraint(equalTo: self.tenthBoard.centerYAnchor, constant: 0.0).isActive = true
            self.tenthBoardText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.tenthSchoolText)
            self.tenthSchoolText.translatesAutoresizingMaskIntoConstraints = false
            self.tenthSchoolText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.tenthSchoolText.centerYAnchor.constraint(equalTo: self.tenthSchool.centerYAnchor, constant: 0.0).isActive = true
            self.tenthSchoolText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.tenthCGPAText)
            self.tenthCGPAText.translatesAutoresizingMaskIntoConstraints = false
            self.tenthCGPAText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.tenthCGPAText.centerYAnchor.constraint(equalTo: self.tenthCGPA.centerYAnchor, constant: 0.0).isActive = true
            self.tenthCGPAText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.tenthPassingYearText)
            self.tenthPassingYearText.translatesAutoresizingMaskIntoConstraints = false
            self.tenthPassingYearText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.tenthPassingYearText.centerYAnchor.constraint(equalTo: self.tenthPassingYear.centerYAnchor, constant: 0.0).isActive = true
            self.tenthPassingYearText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.twelBoardText)
            self.twelBoardText.translatesAutoresizingMaskIntoConstraints = false
            self.twelBoardText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.twelBoardText.centerYAnchor.constraint(equalTo: self.twelBoard.centerYAnchor, constant: 0.0).isActive = true
            self.twelBoardText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.twelSchoolText)
            self.twelSchoolText.translatesAutoresizingMaskIntoConstraints = false
            self.twelSchoolText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.twelSchoolText.centerYAnchor.constraint(equalTo: self.twelSchool.centerYAnchor, constant: 0.0).isActive = true
            self.twelSchoolText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.twelPassingYearText)
            self.twelPassingYearText.translatesAutoresizingMaskIntoConstraints = false
            self.twelPassingYearText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.twelPassingYearText.centerYAnchor.constraint(equalTo: self.twelPassingYear.centerYAnchor, constant: 0.0).isActive = true
            self.twelPassingYearText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.twelPassStateText)
            self.twelPassStateText.translatesAutoresizingMaskIntoConstraints = false
            self.twelPassStateText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.twelPassStateText.centerYAnchor.constraint(equalTo: self.twelPassState.centerYAnchor, constant: 0.0).isActive = true
            self.twelPassStateText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.twelCGPAText)
            self.twelCGPAText.translatesAutoresizingMaskIntoConstraints = false
            self.twelCGPAText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.twelCGPAText.centerYAnchor.constraint(equalTo: self.twelCGPA.centerYAnchor, constant: 0.0).isActive = true
            self.twelCGPAText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.graduationPassingYearText)
            self.graduationPassingYearText.translatesAutoresizingMaskIntoConstraints = false
            self.graduationPassingYearText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.graduationPassingYearText.centerYAnchor.constraint(equalTo: self.graduationPassingYear.centerYAnchor, constant: 0.0).isActive = true
            self.graduationPassingYearText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.educationGapText)
            self.educationGapText.translatesAutoresizingMaskIntoConstraints = false
            self.educationGapText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.educationGapText.centerYAnchor.constraint(equalTo: self.educationGap.centerYAnchor, constant: 0.0).isActive = true
            self.educationGapText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.activeBackText)
            self.activeBackText.translatesAutoresizingMaskIntoConstraints = false
            self.activeBackText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.activeBackText.centerYAnchor.constraint(equalTo: self.activeBack.centerYAnchor, constant: 0.0).isActive = true
            self.activeBackText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.backSubjectsText)
            self.backSubjectsText.translatesAutoresizingMaskIntoConstraints = false
            self.backSubjectsText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.backSubjectsText.centerYAnchor.constraint(equalTo: self.backSubjects.centerYAnchor, constant: 0.0).isActive = true
            self.backSubjectsText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.totalBackText)
            self.totalBackText.translatesAutoresizingMaskIntoConstraints = false
            self.totalBackText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.totalBackText.centerYAnchor.constraint(equalTo: self.totalBack.centerYAnchor, constant: 0.0).isActive = true
            self.totalBackText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.semOneText)
            self.semOneText.translatesAutoresizingMaskIntoConstraints = false
            self.semOneText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.semOneText.centerYAnchor.constraint(equalTo: self.semOne.centerYAnchor, constant: 0.0).isActive = true
            self.semOneText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true
            
            self.scrollView.addSubview(self.semTwoText)
            self.semTwoText.translatesAutoresizingMaskIntoConstraints = false
            self.semTwoText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.semTwoText.centerYAnchor.constraint(equalTo: self.semTwo.centerYAnchor, constant: 0.0).isActive = true
            self.semTwoText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true
            
            self.scrollView.addSubview(self.semThreeText)
            self.semThreeText.translatesAutoresizingMaskIntoConstraints = false
            self.semThreeText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.semThreeText.centerYAnchor.constraint(equalTo: self.semThree.centerYAnchor, constant: 0.0).isActive = true
            self.semThreeText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true
            
            self.scrollView.addSubview(self.semFourText)
            self.semFourText.translatesAutoresizingMaskIntoConstraints = false
            self.semFourText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.semFourText.centerYAnchor.constraint(equalTo: self.semFour.centerYAnchor, constant: 0.0).isActive = true
            self.semFourText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true
            
            self.scrollView.addSubview(self.semFiveText)
            self.semFiveText.translatesAutoresizingMaskIntoConstraints = false
            self.semFiveText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.semFiveText.centerYAnchor.constraint(equalTo: self.semFive.centerYAnchor, constant: 0.0).isActive = true
            self.semFiveText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true
            
            self.scrollView.addSubview(self.semSixText)
            self.semSixText.translatesAutoresizingMaskIntoConstraints = false
            self.semSixText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.semSixText.centerYAnchor.constraint(equalTo: self.semSix.centerYAnchor, constant: 0.0).isActive = true
            self.semSixText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true
            
            self.scrollView.addSubview(self.semSevenText)
            self.semSevenText.translatesAutoresizingMaskIntoConstraints = false
            self.semSevenText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.semSevenText.centerYAnchor.constraint(equalTo: self.semSeven.centerYAnchor, constant: 0.0).isActive = true
            self.semSevenText.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20.0).isActive = true

            self.scrollView.addSubview(self.semEightText)
            self.semEightText.translatesAutoresizingMaskIntoConstraints = false
            self.semEightText.leadingAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0.0).isActive = true
            self.semEightText.centerYAnchor.constraint(equalTo: self.semEight.centerYAnchor, constant: 0.0).isActive = true
            self.semEightText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        getEducationalDetails()
        
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
