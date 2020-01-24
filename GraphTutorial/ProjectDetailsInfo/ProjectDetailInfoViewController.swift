//
//  ProjectDetailInfoViewController.swift
//  ANTSDemo
//
//  Created by Kranthi on 10/31/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit

class ProjectDetailInfoViewController: UIViewController {
    @IBOutlet weak var projectInfoImg: UIImageView!
    
    @IBOutlet weak var projectInfoBgView: UIView!
    @IBOutlet weak var projectBgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var projectLocationLbl: UILabel!
    @IBOutlet weak var projectNameLbl: UILabel!
    @IBOutlet weak var projectInfoTableview: UITableView!
    
    
    let projectData = ["Project Type","Project Team Size","Duration","Project Manager","Clint Reporting Manager","Development Location"]
              let projectResultData = ["Hardware Sensors","12 members"," 2 months","kranthi","shyam","Hyd,india"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if UIDevice().userInterfaceIdiom == .phone {
                                      switch UIScreen.main.nativeBounds.height {
                                      case 1136:
                                       
                                          projectBgViewHeight.constant = 230
                                       
                                      case 1334:
                                          print("iPhone 6/6S/7/8")
                                          projectBgViewHeight.constant = 250

                                      case 1920, 2208:
                                          print("iPhone 6+/6S+/7+/8+")
                                          projectBgViewHeight.constant = 250

                                      case 2436:
                                          print("iPhone X")
                                          projectBgViewHeight.constant = 300
                                      default:
                                          print("unknown")
                                          
                                        projectBgViewHeight.constant = 300

                                      }
                                     
                                  }
               projectInfoImg.layer.borderWidth = 1
               projectInfoImg.layer.masksToBounds = false
               projectInfoImg.layer.borderColor = UIColor.black.cgColor
               projectInfoImg.layer.cornerRadius = projectInfoImg.frame.height/2
               projectInfoImg.clipsToBounds = true
              
//                projectInfoBgView.layer.borderWidth = 1
//
//                projectInfoBgView.layer.borderColor = UIColor.lightGray.cgColor
        
        projectInfoTableview.layer.borderWidth = 0.5
                      
                projectInfoTableview.layer.borderColor = UIColor.lightGray.cgColor
                      
               
              // UtilitiesClass.sharedInstance.buttonRoundRect(selectedButton: sendMailToBtn)

    }
    
    @IBAction func backBtnClick(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ProjectDetailInfoViewController:UITableViewDataSource,UITableViewDelegate{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return projectData.count

    }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier:"ProjectInfoTVCell") as! ProjectInfoTVCell

    cell.projectTypeQLbl.text = projectData[indexPath.row]
    cell.projectTypeAlbl.text = projectResultData[indexPath.row]

    return cell
    
   }

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   return 50
 }

   
}

