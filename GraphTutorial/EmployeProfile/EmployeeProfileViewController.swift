//
//  EmployeeProfileViewController.swift
//  ANTSDemo
//
//  Created by Kranthi on 10/30/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit

class EmployeeProfileViewController: UIViewController {
    
    fileprivate let application = UIApplication.shared
    
    @IBOutlet weak var employeeNameLbl: UILabel!
    var phonenubStr = String()
    
    
    var empDict:employeDetalisListStruct.Datum?
    
    @IBOutlet weak var profileViewHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var employeeProfileListTableV: UITableView!
    @IBOutlet weak var profilePicImg: UIImageView!
    
    @IBOutlet weak var designationLbl: UILabel!
    @IBOutlet weak var sendMailToBtn: UIButton!
    let employeeData = ["Employee ID","Name","Email Id","Mobile","Reporting Manager","Location"]
          // let employeeResultData = ["ANTSHYD127","angelena","angelena.a@alpha-numero.com","+91-9177797780","shyam","Hyd,india"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        employeeNameLbl.text = empDict?.empName ?? ""
        designationLbl.text = empDict?.empDesignation ?? ""
        
        // Do any additional setup after loading the view.
        
        if UIDevice().userInterfaceIdiom == .phone {
                               
            switch UIScreen.main.nativeBounds.height {
            case 1136:

                profileViewHeightLayout.constant = 230
            
           case 1334:
               print("iPhone 6/6S/7/8")
               profileViewHeightLayout.constant = 250

           case 1920, 2208:
               print("iPhone 6+/6S+/7+/8+")
               profileViewHeightLayout.constant = 250

           case 2436:
               print("iPhone X")
               profileViewHeightLayout.constant = 300
           default:
               print("unknown")
               
             profileViewHeightLayout.constant = 300

           }
        }
        profilePicImg.layer.borderWidth = 1
        profilePicImg.layer.masksToBounds = false
        profilePicImg.layer.borderColor = UIColor.black.cgColor
        profilePicImg.layer.cornerRadius = profilePicImg.frame.height/2
        profilePicImg.clipsToBounds = true
       
         employeeProfileListTableV.layer.borderWidth = 1
        
         employeeProfileListTableV.layer.borderColor = UIColor.lightGray.cgColor
        
        UtilitiesClass.sharedInstance.buttonRoundRect(selectedButton: sendMailToBtn)

    }
    
    @IBAction func backBtnClick(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

}

extension EmployeeProfileViewController:UITableViewDataSource,UITableViewDelegate{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
    
}
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier:"EmployeeProfileTVCell") as! EmployeeProfileTVCell
    
    //cell.employeeTypeRLbl.text = employeeData[indexPath.row]

    if indexPath.row == 0 {
        cell.employeeTypeRLbl.text = "\(empDict?.empID ?? "")"
        cell.employeeTypeLbl.text = "Employee ID"

    }else if indexPath.row == 1{
        cell.employeeTypeRLbl.text = empDict?.empName ?? ""
        cell.employeeTypeLbl.text = "Name"

    }else if indexPath.row == 2{
        
        cell.employeeTypeRLbl.text = empDict?.empEmail ?? ""
        cell.employeeTypeLbl.text = "Email Id"

    }else if indexPath.row == 3{
      
        cell.employeeTypeRLbl.text = "\(empDict?.empMobile ?? 0)"
        
        cell.employeeTypeLbl.text = "Mobile"
        
        cell.employeeTypeRLbl.textColor = UIColor.gray

    }else if indexPath.row == 4{
        cell.employeeTypeRLbl.text = empDict?.empReportingmanager ?? ""
        cell.employeeTypeLbl.text = "Reporting Manager"

    }else if indexPath.row == 5{
        cell.employeeTypeRLbl.text = empDict?.empLocation ?? ""
        cell.employeeTypeLbl.text = "Location"

    }
    return cell
    
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        phonenubStr = "\(empDict?.empMobile ?? 0)"
        if indexPath.row == 3 {
            
            
            if let phoneUrl = URL(string: "tel://\(phonenubStr)") {
                
                print(phoneUrl)
                
                if application.canOpenURL(phoneUrl) {
                    application.open(phoneUrl, options: [:], completionHandler: nil)
                }
            }else{
                
                
            }
        }
    }

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   return 50
 }

   
}
