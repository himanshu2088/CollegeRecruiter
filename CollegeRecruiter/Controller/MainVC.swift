//
//  MainVC.swift
//  CollegeRecruiter
//
//  Created by Himanshu Joshi on 27/04/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import Firebase

var studentName: String?
var studentAdmission: String?
var studentMobile: String?
var studentBranch: String?
var studentAadhar: String?
var studentActiveBack: String?
var studentCategory: String?
var studentCity: String?
var studentCurrentAdd: String?
var studentDOB: String?
var studentEducationGap: String?
var studentmail: String?
var studentEnrollNo: String?
var studentFatherName: String?
var studentMotherName: String?
var studentGender: String?
var studentGraduationPassYear: String?
var studentInternship: String?
var studentOverallCGPA: String?
var studentParentMobile: String?
var studentPassport: String?
var studentPrimaryAdd: String?
var studentImage: String?
var studentQualification12OrDiploma: String?
var studentResume: String?
var studentSem1: String?
var studentSem2: String?
var studentSem3: String?
var studentSem4: String?
var studentSem5: String?
var studentSem6: String?
var studentSem7: String?
var studentSem8: String?
var studentSemester: String?
var studentSkills: String?
var studentSubjectBack: String?
var studentTenthBoard: String?
var studentTenthPassYear: String?
var studentTenthSchool: String?
var studentTenthCGPA: String?
var studentTotalBack: String?
var studentTwelBoard: String?
var studentTwelCGPA: String?
var studentTwelPassState: String?
var studentTwelPassYear: String?
var studentTwelSchool: String?


class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        label.font = UIFont(name: "Avenir-Medium", size: 18.0)
        label.textColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return label
    }()
    
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let currentUserUID = Auth.auth().currentUser?.uid
    let collectionRef = Firestore.firestore().collection("student")
    
    var field = "default"
    
    var jobTitleArray = [String]()
    var jobsCompanyArray = [String]()
    var jobsSalaryArray = [String]()
    var jobsDocumentIdArray = [String]()
    var jobTime = [Int]()
    
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
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 55.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
        
    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 30.0)
        label.textColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        return label
    }()
    
    let admissionNo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.textColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        label.text = "Admission No."
        return label
    }()
    
    let branch: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.textColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
        label.text = "Branch"
        return label
    }()
    
    let mobile: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20.0)
        label.textColor = #colorLiteral(red: 0.168627451, green: 0.8509803922, blue: 0.6352941176, alpha: 1)
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
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "StudentJobs", bundle: nil), forCellReuseIdentifier: "studentJobs")
        tableView.rowHeight = 125.0
        tableView.allowsSelection = true
        tableView.backgroundColor = .white
        return tableView
    }()
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        try! Auth.auth().signOut()
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
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
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
        }
        
        tableView.removeFromSuperview()
        
        viewDidLoad()
        
    }
    
    @IBAction func profileBtnPressed(_ sender: UIButton) {
        leading.constant = 0
        trailing.constant = 0
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
        }
    }
    
    @IBAction func jobsBtnPressed(_ sender: UIButton) {
        leading.constant = 0
        trailing.constant = 0
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
        }
        
        name.removeFromSuperview()
        admissionNo.removeFromSuperview()
        branch.removeFromSuperview()
        mobile.removeFromSuperview()
        branchText.removeFromSuperview()
        imageView.removeFromSuperview()
        admissionNoText.removeFromSuperview()
        mobileText.removeFromSuperview()
        
        spinner.startAnimating()
        
        self.view2.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: self.view2.topAnchor, constant: 80.0).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: self.view2.frame.width).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        
        self.profileLabel.text = "ALL JOBS"
        
        self.view2.addSubview(verticalLineView)
        verticalLineView.translatesAutoresizingMaskIntoConstraints = false
        verticalLineView.leadingAnchor.constraint(equalTo: self.view2.leadingAnchor, constant: 0.0).isActive = true
        verticalLineView.widthAnchor.constraint(equalToConstant: 0.7).isActive = true
        verticalLineView.heightAnchor.constraint(equalToConstant: self.view2.frame.height).isActive = true
        
        let currentDate = Date()
        
        Firestore.firestore().collection("job").whereField("branch", isEqualTo: field).getDocuments { (snapshot, error) in
            let documents = snapshot?.documents
            for document in documents! {
                let documentId = document.documentID
                let jobTitle = document.data()["jobTitle"] as? String
                let jobCompany = document.data()["companyName"] as? String
                let jobSalary = document.data()["salary"] as? String
                let jobTime = document.data()["time"] as? Timestamp
                
                let diff = Calendar.current.dateComponents([.day], from: (jobTime?.dateValue())!, to: currentDate)
                
                let daysLeft = (diff.day)!
                
                self.jobTime.append(daysLeft)
                self.jobsDocumentIdArray.append(documentId)
                self.jobTitleArray.append(jobTitle!)
                self.jobsCompanyArray.append(jobCompany!)
                self.jobsSalaryArray.append(jobSalary!)
            }

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
        return jobTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "studentJobs", for: indexPath) as? StudentJobs {
            cell.jobTitle.text = jobTitleArray[indexPath.row]
            cell.companyName.text = jobsCompanyArray[indexPath.row]
            cell.salary.text = "Salary " + jobsSalaryArray[indexPath.row]
            
            if jobTime[indexPath.row] > 0 {
                cell.days.text = "Posted " + "\(jobTime[indexPath.row])" + " day ago"
            } else {
                cell.days.text = "Posted today"
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ParticularJobVC") as? ParticularJobVC
        nextViewController?.documentId = jobsDocumentIdArray[indexPath.row]
        self.present(nextViewController!, animated:true, completion:nil)
    }
    
    @IBAction func myJobsBtnPressed(_ sender: UIButton) {
        leading.constant = 0
        trailing.constant = 0
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyJobsVC") as? MyJobsVC
        self.present(nextViewController!, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
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
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.topAnchor.constraint(equalTo: self.view2.topAnchor, constant: 35.0).isActive = true
        profileLabel.centerXAnchor.constraint(equalTo: self.view2.centerXAnchor, constant: 0.0).isActive = true
        profileLabel.text = "HOME"
        
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
            let photoUrl = data!["profileImageUrl"] as? String
            let aadharNoData = data!["aadharNumber"] as? String
            let categoryData = data!["category"] as? String
            let cityData = data!["city"] as? String
            let currentAddressData = data!["currentAddress"] as? String
            let dobData = data!["dob"] as? String
            let fatherNameData = data!["fatherName"] as? String
            let motherNameData = data!["motherName"] as? String
            let genderData = data!["gender"] as? String
            let parentMobileNoData = data!["parentMobileNo"] as? String
            let passportNoData = data!["passportNumber"] as? String
            let primaryAddressData = data!["primaryAddress"] as? String
            let enrollmentNoData = data!["enrollmentNo"] as? String
            let semester = data!["semester"] as? String
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
            let overall = data!["overallCGPA"] as? String
            let skillsData = data!["skills"] as? String
            let internshipData = data!["internshipDetails"] as? String
            let resume = data!["resumeUrl"] as? String
            
            
            studentName = nameData!
            studentAdmission = admissionNoData!
            studentBranch = branchData!
            studentMobile = mobileNo!
            studentImage = photoUrl!
            studentAadhar = aadharNoData!
            studentCategory = categoryData!
            studentCity = cityData!
            studentCurrentAdd = currentAddressData!
            studentDOB = dobData!
            studentFatherName = fatherNameData!
            studentMotherName = motherNameData!
            studentGender = genderData!
            studentParentMobile = parentMobileNoData!
            studentPassport = passportNoData!
            studentPrimaryAdd = primaryAddressData!
            studentEnrollNo = enrollmentNoData!
            studentSemester = semester!
            studentTenthBoard = tenthBoardData!
            studentTenthSchool = tenthSchoolData!
            studentTenthCGPA = tenthCGPAData!
            studentTenthPassYear = tenthPassYearData!
            studentTwelBoard = twelBoardData!
            studentTwelPassYear = twelPassYearData!
            studentTwelSchool = twelSchoolData!
            studentTwelPassState = twelPassStateData!
            studentTwelCGPA = twelCGPAData!
            studentGraduationPassYear = graduationPassYearData!
            studentEducationGap = educationGapData!
            studentActiveBack = activeBackData!
            studentSubjectBack = backSubjectsData!
            studentTotalBack = totalBackData!
            studentSem1 = semOneData!
            studentSem2 = semTwoData!
            studentSem3 = semThreeData!
            studentSem4 = semFourData!
            studentSem5 = semFiveData!
            studentSem6 = semSixData!
            studentSem7 = semSevenData!
            studentSem8 = semEightData!
            studentOverallCGPA = overall!
            studentSkills = skillsData!
            studentInternship = internshipData!
            studentResume = resume!
            
            
            let url = URL(string: photoUrl!)
            if url != nil {
                let data = try? Data(contentsOf: url!)
                if data != nil {
                    self.imageView.image = UIImage(data: data!)
                }
            }
            
            self.spinner.stopAnimating()
            self.name.text = nameData!
            self.nameLabel.text = nameData!
            self.admissionNoText.text = admissionNoData!
            self.mobileText.text = mobileNo!
            self.branchText.text = "B.Tech " + branchData!
            
            self.field = branchData!
            
            self.view2.addSubview(self.imageView)
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.imageView.centerXAnchor.constraint(equalTo: self.view2.centerXAnchor, constant: 0.0).isActive = true
            self.imageView.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
            self.imageView.heightAnchor.constraint(equalToConstant: 110.0).isActive = true
            self.imageView.topAnchor.constraint(equalTo: self.lineView.bottomAnchor, constant: 20.0).isActive = true
            
            self.view2.addSubview(self.name)
            self.name.translatesAutoresizingMaskIntoConstraints = false
            self.name.centerXAnchor.constraint(equalTo: self.view2.centerXAnchor, constant: 0.0).isActive = true
            self.name.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 40.0).isActive = true
            
            self.view2.addSubview(self.admissionNo)
            self.admissionNo.translatesAutoresizingMaskIntoConstraints = false
            self.admissionNo.leadingAnchor.constraint(equalTo: self.view2.leadingAnchor, constant: 20.0).isActive = true
            self.admissionNo.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 20.0).isActive = true
            
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
    
    @IBAction func updateDataBtnPressed(_ sender: UIButton) {
        leading.constant = 0
        trailing.constant = 0
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "StudentUpdateData") as? StudentUpdateData
        self.present(nextViewController!, animated:true, completion:nil)
    }
    
}

//babita.joshi131076@gmail.com
