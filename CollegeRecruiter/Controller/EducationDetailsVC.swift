//
//  EducationDetailsVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 26/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase

class EducationDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    let data = ["12th", "Diploma"]
    
    let scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Educational Details"
        label.font = UIFont(name: "Avenir-Medium", size: 30.0)
        return label
    }()
    
    let tenthLabel: UILabel = {
        let label = UILabel()
        label.text = "10th Details"
        label.font = UIFont(name: "Avenir", size: 25.0)
        return label
    }()
    
    let tenthCGPATextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "CGPA/%"
        return textField
    }()
    
    let tenthBoardTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Name of Board"
        return textField
    }()
    
    let tenthSchoolTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Name of Institution"
        return textField
    }()
    
    let tenthPassYearTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Passing Year"
        return textField
    }()
    
    let twelfthLabel: UILabel = {
        let label = UILabel()
        label.text = "12th/Diploma Details"
        label.font = UIFont(name: "Avenir", size: 25.0)
        return label
    }()
    
    let qualificationLblTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "12th or Diploma"
        return textField
    }()
    
    let educationGapTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Education gap after 10th (in years)"
        return textField
    }()
    
    let twelfthCGPATextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "CGPA/%"
        return textField
    }()
    
    let twelfthBoardTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Name of Board"
        return textField
    }()
    
    let twelfthSchoolTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Name of Institution"
        return textField
    }()
    
    let twelfthPassYearTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Passing Year"
        return textField
    }()
    
    let twelfthPassStateTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Passing State"
        return textField
    }()
    
    let graduationLabel: UILabel = {
        let label = UILabel()
        label.text = "Graduation Details"
        label.font = UIFont(name: "Avenir", size: 25.0)
        return label
    }()
    
    let semOneTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Sem 1 SGPA"
        return textField
    }()
    
    let semTwoTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Sem 2 SGPA"
        return textField
    }()
    
    let semThreeTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Sem 3 SGPA"
        return textField
    }()
    
    let semFourTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Sem 4 SGPA"
        return textField
    }()
    
    let semFiveTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Sem 5 SGPA"
        return textField
    }()
    
    let semSixTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Sem 6 SGPA"
        return textField
    }()
    
    let semSevenTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Sem 7 SGPA"
        return textField
    }()
    
    let semEightTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Sem 8 SGPA"
        return textField
    }()
    
    let numberBackTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Number of Total Backlogs"
        return textField
    }()
    
    let activeBackTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Number of Active Backlogs"
        return textField
    }()
    
    let subjectBackTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Name of Subjects with Current Backlogs"
        return textField
    }()
    
    let passingYearGraduationTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Passing Year"
        return textField
    }()
    
    let nextBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 20.0)
        button.tintColor = .black
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(saveEducationDetails), for: .touchUpInside)
        return button
    }()
    
    @objc func saveEducationDetails() {
        
        guard let tenthPercentage = tenthCGPATextField.text, let tenthBoard = tenthBoardTextField.text, let tenthSchool = tenthSchoolTextField.text, let tenthPassingYear = tenthPassYearTextField.text, let qualificationDiplomaOrTwelfth = qualificationLblTextField.text, let educationGap = educationGapTextField.text, let twelCGPA = twelfthCGPATextField.text, let twelSchool = twelfthSchoolTextField.text, let twelBoard = twelfthBoardTextField.text, let twelPassingYear = twelfthPassYearTextField.text, let twelPassState = twelfthPassStateTextField.text, let semOne = semOneTextField.text, let semtwo = semTwoTextField.text, let semThree = semThreeTextField.text, let semFour = semFourTextField.text, let semFive = semFiveTextField.text, let semSix = semSixTextField.text, let semSeven = semSevenTextField.text, let semEight = semEightTextField.text, let totalBack = numberBackTextField.text, let activeBack = activeBackTextField.text, let subjectBack = subjectBackTextField.text, let graduationPassingYear = passingYearGraduationTextField.text else { return }
        
        if tenthPercentage == "" || tenthPassingYear == "" || tenthSchool == "" || tenthBoard == "" || qualificationDiplomaOrTwelfth == "" || educationGap == "" || twelPassState == "" || twelPassingYear == "" || twelBoard == "" || twelSchool == "" || twelCGPA == "" || semOne == "" || semtwo == "" || semThree == "" || semFour == "" || semFive == "" || semSix == "" || semSeven == "" || subjectBack == "" || activeBack == "" || totalBack == "" || graduationPassingYear == "" || semEight == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter all the fields to continue.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        else {
            spinner.startAnimating()
            guard let userId = Auth.auth().currentUser?.uid else { return }
            Firestore.firestore().collection("student").document(userId).updateData([
                "tenthPercentage" : tenthPercentage,
                "tenthBoard" : tenthBoard,
                "tenthSchool" : tenthSchool,
                "tenthPassingYear" : tenthPassingYear,
                "qualificationDiplomaOrTwelfth" : qualificationDiplomaOrTwelfth,
                "educationGap" : educationGap,
                "twelCGPA" : twelCGPA,
                "twelSchool" : twelSchool,
                "twelBoard" : twelBoard,
                "twelPassingYear" : twelPassingYear,
                "twelPassState" : twelPassState,
                "semOne" : semOne,
                "semtwo" : semtwo,
                "semThree" : semThree,
                "semFour" : semFour,
                "semFive" : semFive,
                "semSix" : semSix,
                "semSeven" : semSeven,
                "semEight" : semEight,
                "totalBack" : totalBack,
                "activeBack" : activeBack,
                "subjectBack" : subjectBack,
                "graduationPassingYear" : graduationPassingYear
                ], completion: { (error) in
                    if let error = error {
                        self.spinner.stopAnimating()
                        debugPrint(error.localizedDescription)
                        print("Error while creating user")
                    } else {
                        self.spinner.stopAnimating()
                        print("Updated Data")
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SkillDetailsVC") as? SkillDetailsVC
                        self.present(nextViewController!, animated:true, completion:nil)
                    }
            })
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataPicker = UIPickerView()
        qualificationLblTextField.inputView = dataPicker
        dataPicker.delegate = self

        self.view.addSubview(scrollView)

        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        

        scrollView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30.0).isActive = true
        label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0.0).isActive = true

        scrollView.addSubview(tenthLabel)
        tenthLabel.translatesAutoresizingMaskIntoConstraints = false
        tenthLabel.isUserInteractionEnabled = true
        tenthLabel.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 15.0).isActive = true
        tenthLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        
        scrollView.addSubview(tenthBoardTextField)
        tenthBoardTextField.translatesAutoresizingMaskIntoConstraints = false
        tenthBoardTextField.isUserInteractionEnabled = true
        tenthBoardTextField.topAnchor.constraint(equalTo: self.tenthLabel.bottomAnchor, constant: 10.0).isActive = true
        tenthBoardTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        tenthBoardTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(tenthSchoolTextField)
        tenthSchoolTextField.translatesAutoresizingMaskIntoConstraints = false
        tenthSchoolTextField.isUserInteractionEnabled = true
        tenthSchoolTextField.topAnchor.constraint(equalTo: self.tenthBoardTextField.bottomAnchor, constant: 10.0).isActive = true
        tenthSchoolTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        tenthSchoolTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(tenthCGPATextField)
        tenthCGPATextField.translatesAutoresizingMaskIntoConstraints = false
        tenthCGPATextField.isUserInteractionEnabled = true
        tenthCGPATextField.topAnchor.constraint(equalTo: self.tenthSchoolTextField.bottomAnchor, constant: 10.0).isActive = true
        tenthCGPATextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        tenthCGPATextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(tenthPassYearTextField)
        tenthPassYearTextField.translatesAutoresizingMaskIntoConstraints = false
        tenthPassYearTextField.isUserInteractionEnabled = true
        tenthPassYearTextField.topAnchor.constraint(equalTo: self.tenthCGPATextField.bottomAnchor, constant: 10.0).isActive = true
        tenthPassYearTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        tenthPassYearTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(twelfthLabel)
        twelfthLabel.translatesAutoresizingMaskIntoConstraints = false
        twelfthLabel.isUserInteractionEnabled = true
        twelfthLabel.topAnchor.constraint(equalTo: self.tenthPassYearTextField.bottomAnchor, constant: 10.0).isActive = true
        twelfthLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        
        scrollView.addSubview(qualificationLblTextField)
        qualificationLblTextField.translatesAutoresizingMaskIntoConstraints = false
        qualificationLblTextField.isUserInteractionEnabled = true
        qualificationLblTextField.topAnchor.constraint(equalTo: self.twelfthLabel.bottomAnchor, constant: 10.0).isActive = true
        qualificationLblTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        qualificationLblTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(educationGapTextField)
        educationGapTextField.translatesAutoresizingMaskIntoConstraints = false
        educationGapTextField.isUserInteractionEnabled = true
        educationGapTextField.topAnchor.constraint(equalTo: self.qualificationLblTextField.bottomAnchor, constant: 10.0).isActive = true
        educationGapTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        educationGapTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(twelfthCGPATextField)
        twelfthCGPATextField.translatesAutoresizingMaskIntoConstraints = false
        twelfthCGPATextField.isUserInteractionEnabled = true
        twelfthCGPATextField.topAnchor.constraint(equalTo: self.educationGapTextField.bottomAnchor, constant: 10.0).isActive = true
        twelfthCGPATextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        twelfthCGPATextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(twelfthBoardTextField)
        twelfthBoardTextField.translatesAutoresizingMaskIntoConstraints = false
        twelfthBoardTextField.isUserInteractionEnabled = true
        twelfthBoardTextField.topAnchor.constraint(equalTo: self.twelfthCGPATextField.bottomAnchor, constant: 10.0).isActive = true
        twelfthBoardTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        twelfthBoardTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(twelfthSchoolTextField)
        twelfthSchoolTextField.translatesAutoresizingMaskIntoConstraints = false
        twelfthSchoolTextField.isUserInteractionEnabled = true
        twelfthSchoolTextField.topAnchor.constraint(equalTo: self.twelfthBoardTextField.bottomAnchor, constant: 10.0).isActive = true
        twelfthSchoolTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        twelfthSchoolTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(twelfthPassYearTextField)
        twelfthPassYearTextField.translatesAutoresizingMaskIntoConstraints = false
        twelfthPassYearTextField.isUserInteractionEnabled = true
        twelfthPassYearTextField.topAnchor.constraint(equalTo: self.twelfthSchoolTextField.bottomAnchor, constant: 10.0).isActive = true
        twelfthPassYearTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        twelfthPassYearTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(twelfthPassStateTextField)
        twelfthPassStateTextField.translatesAutoresizingMaskIntoConstraints = false
        twelfthPassStateTextField.isUserInteractionEnabled = true
        twelfthPassStateTextField.topAnchor.constraint(equalTo: self.twelfthPassYearTextField.bottomAnchor, constant: 10.0).isActive = true
        twelfthPassStateTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        twelfthPassStateTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(graduationLabel)
        graduationLabel.translatesAutoresizingMaskIntoConstraints = false
        graduationLabel.isUserInteractionEnabled = true
        graduationLabel.topAnchor.constraint(equalTo: self.twelfthPassStateTextField.bottomAnchor, constant: 10.0).isActive = true
        graduationLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        graduationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(semOneTextField)
        semOneTextField.translatesAutoresizingMaskIntoConstraints = false
        semOneTextField.isUserInteractionEnabled = true
        semOneTextField.topAnchor.constraint(equalTo: self.graduationLabel.bottomAnchor, constant: 10.0).isActive = true
        semOneTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        semOneTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(semTwoTextField)
        semTwoTextField.translatesAutoresizingMaskIntoConstraints = false
        semTwoTextField.isUserInteractionEnabled = true
        semTwoTextField.topAnchor.constraint(equalTo: self.semOneTextField.bottomAnchor, constant: 10.0).isActive = true
        semTwoTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        semTwoTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(semThreeTextField)
        semThreeTextField.translatesAutoresizingMaskIntoConstraints = false
        semThreeTextField.isUserInteractionEnabled = true
        semThreeTextField.topAnchor.constraint(equalTo: self.semTwoTextField.bottomAnchor, constant: 10.0).isActive = true
        semThreeTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        semThreeTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(semFourTextField)
        semFourTextField.translatesAutoresizingMaskIntoConstraints = false
        semFourTextField.isUserInteractionEnabled = true
        semFourTextField.topAnchor.constraint(equalTo: self.semThreeTextField.bottomAnchor, constant: 10.0).isActive = true
        semFourTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        semFourTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(semFiveTextField)
        semFiveTextField.translatesAutoresizingMaskIntoConstraints = false
        semFiveTextField.isUserInteractionEnabled = true
        semFiveTextField.topAnchor.constraint(equalTo: self.semFourTextField.bottomAnchor, constant: 10.0).isActive = true
        semFiveTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        semFiveTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(semSixTextField)
        semSixTextField.translatesAutoresizingMaskIntoConstraints = false
        semSixTextField.isUserInteractionEnabled = true
        semSixTextField.topAnchor.constraint(equalTo: self.semFiveTextField.bottomAnchor, constant: 10.0).isActive = true
        semSixTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        semSixTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(semSevenTextField)
        semSevenTextField.translatesAutoresizingMaskIntoConstraints = false
        semSevenTextField.isUserInteractionEnabled = true
        semSevenTextField.topAnchor.constraint(equalTo: self.semSixTextField.bottomAnchor, constant: 10.0).isActive = true
        semSevenTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        semSevenTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(semEightTextField)
        semEightTextField.translatesAutoresizingMaskIntoConstraints = false
        semEightTextField.isUserInteractionEnabled = true
        semEightTextField.topAnchor.constraint(equalTo: self.semSevenTextField.bottomAnchor, constant: 10.0).isActive = true
        semEightTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        semEightTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(numberBackTextField)
        numberBackTextField.translatesAutoresizingMaskIntoConstraints = false
        numberBackTextField.isUserInteractionEnabled = true
        numberBackTextField.topAnchor.constraint(equalTo: self.semEightTextField.bottomAnchor, constant: 10.0).isActive = true
        numberBackTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        numberBackTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(activeBackTextField)
        activeBackTextField.translatesAutoresizingMaskIntoConstraints = false
        activeBackTextField.isUserInteractionEnabled = true
        activeBackTextField.topAnchor.constraint(equalTo: self.numberBackTextField.bottomAnchor, constant: 10.0).isActive = true
        activeBackTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        activeBackTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(subjectBackTextField)
        subjectBackTextField.translatesAutoresizingMaskIntoConstraints = false
        subjectBackTextField.isUserInteractionEnabled = true
        subjectBackTextField.topAnchor.constraint(equalTo: self.activeBackTextField.bottomAnchor, constant: 10.0).isActive = true
        subjectBackTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        subjectBackTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(passingYearGraduationTextField)
        passingYearGraduationTextField.translatesAutoresizingMaskIntoConstraints = false
        passingYearGraduationTextField.isUserInteractionEnabled = true
        passingYearGraduationTextField.topAnchor.constraint(equalTo: self.subjectBackTextField.bottomAnchor, constant: 10.0).isActive = true
        passingYearGraduationTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        passingYearGraduationTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
        
        scrollView.addSubview(nextBtn)
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.isUserInteractionEnabled = true
        nextBtn.topAnchor.constraint(equalTo: self.passingYearGraduationTextField.bottomAnchor, constant: 15.0).isActive = true
        nextBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0.0).isActive = true
        nextBtn.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30.0).isActive = true
    }
    
    //UIPickerView Functions For Gender Text Field
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        qualificationLblTextField.text = data[row]
    }

}
