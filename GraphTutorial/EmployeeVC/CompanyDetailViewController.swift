//
//  CompanyDetailViewController.swift
//  ANTSDemo
//
//  Created by Kranthi on 10/17/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit


struct listOFHumanResource {
    var isExpanded:Bool
    var headerTitle:String
    var hrList:[hrListData]

    init(isExpanded:Bool,hrList:[hrListData],headerTitle:String) {
        self.isExpanded = isExpanded
        self.hrList    = hrList
        self.headerTitle = headerTitle
    }
    struct hrListData {
        var hrName:String?
        var location:String?
        init(hrName:String?,location:String?) {
            self.hrName = hrName
            self.location = location
        }
    }
}

class CompanyDetailViewController: UIViewController {
    
    var hrListArray = [listOFHumanResource]()
      // @IBOutlet weak var mainTableView: UITableView!
      var isViewAllButtonTapped = false

    var empListArray = [employeDetalisListStruct]()
//    var empListArray:employeDetalisListStruct?
    var menuVc:MenuViewController!

    @IBOutlet weak var employeeTableView: UITableView!
    
    @IBOutlet weak var navigatioHeight: NSLayoutConstraint!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        employeeTableView.tableFooterView = UIView()
        
        sendToDataServerEmployeeData()
        
       employeeTableView.delegate = self
       employeeTableView.dataSource = self
       employeeTableView.reloadData()
            
        
        if UIDevice().userInterfaceIdiom == .phone {
            
                        switch UIScreen.main.nativeBounds.height {
                        case 1136:

                            customNavigationBarHeight = 70
                            
                        case 1334:
                            print("iPhone 6/6S/7/8")
                            customNavigationBarHeight = 75
                            
                        case 1920, 2208:
                            print("iPhone 6+/6S+/7+/8+")
                            customNavigationBarHeight = 75
                            
                        case 2436:
                            print("iPhone X")
                            customNavigationBarHeight = 88
                        default:
                            print("unknown")
                            
                          customNavigationBarHeight = 88

                        }
                        self.navigatioHeight.constant = CGFloat(customNavigationBarHeight)
                    }
        
          menuVc = self.storyboard?.instantiateViewController(identifier:"MenuViewController" ) as? MenuViewController
        
    }
    
    
   func sendToDataServerEmployeeData(){
    
    
//    if let path = Bundle.main.path(forResource: "hrList", ofType: "json") {
//        do {
//              let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//              let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//              if let jsonResult = jsonResult as? Dictionary<String, AnyObject>{
//                print(jsonResult)
//
//                let Data1 = try? JSONSerialization.data(withJSONObject: jsonResult["data"] as? [[String:AnyObject]] ?? "", options: .fragmentsAllowed)
//                self.empListArray =  try JSONDecoder().decode([employeDetalisListStruct].self, from: Data1!)
//                for val in 0...self.empListArray.count-1{
//                    self.empListArray[val].isExpanded = false
//                }
//                DispatchQueue.main.async {
//                    self.employeeTableView.reloadData()
//                }
//
//              }
//          } catch {
//               // handle error
//          }
    
    
       ANLoader.showLoading()
    
    let mailidData = UtilitiesClass.sharedInstance.getUserDefaultKeyedUnarchiver(userDefaultKey:"userdata")
               print(mailidData)
        
       // ["school_id":"\(logindata.object(forKey: "school_id") ?? "")"]
        
           let emailparams = ["loginEmailid":mailidData.object(forKey: "email")]


 //   let mailidData = UtilitiesClass.sharedInstance.getUserDefaultKeyedUnarchiver(userDefaultKey:"userdata")
          //  print(mailidData)
       // let employeParams = ["loginEmailid":"\(mailidData.object(forKey: "mail") ?? "")"]
            WebServiceHandler.sharedInstance.EmployeeData(params:emailparams as [String : AnyObject] , requestAPI:employeeDetailsUrl, success: { (employeeResponceDta) in

                print(employeeResponceDta as Any)

                ANLoader.hide()

            do {
                                          
                let Data1 = try! JSONSerialization.data(withJSONObject: employeeResponceDta["data"] as? [[String:AnyObject]] ?? "", options: .fragmentsAllowed)

                self.empListArray =  try JSONDecoder().decode([employeDetalisListStruct].self, from: Data1)
                for val in 0...self.empListArray.count-1{

                    self.empListArray[val].isExpanded = false
                }
                
                DispatchQueue.main.async {
                    
                    self.employeeTableView.reloadData()


                    }
                
                if  self.empListArray.count <= 0 {
                    return
                }
                

            }catch let error {
                                          
             print(error)
              //  self.showAlertToUser(title: "Bread", message: "\(error.localizedDescription)")
                                     
            }

            
        }) { (employeeFailureData) in
            
            print(employeeFailureData as Any)
        }

    }
    
    @IBAction func menuBtnClick(_ sender: Any) {
        
        showMenu()
    }
    
    func showMenu(){

        //        self.menuVc.view.frame = CGRect()
            
            UIView.animate(withDuration: 0.0, animations: {
                
                self.menuVc.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                self.menuVc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                self.addChild(self.menuVc)
                self.view.addSubview(self.menuVc.view)
            })
            }
}


extension CompanyDetailViewController:UITableViewDataSource,UITableViewDelegate,EditAccessExpandableHeaderVDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.empListArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2//self.empListArray[section].data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        var heightForRowAt = 150
        if (self.empListArray[indexPath.section].isExpanded ?? false) {
            if indexPath.section == 0 && indexPath.row == 1  && isViewAllButtonTapped == false {
                
            }else{
              heightForRowAt = 110
            }
            
            return CGFloat(heightForRowAt)
            
        } else {
            heightForRowAt = 0
            
            return CGFloat(heightForRowAt)
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var heightForRowAt = 150
        if (self.empListArray[indexPath.section].isExpanded ?? false) {
            if indexPath.section == 0 && indexPath.row == 1  && isViewAllButtonTapped == false {
                
            }else if indexPath.section == 1 && indexPath.row == 1  && isViewAllButtonTapped == false {
                
            }else if indexPath.section == 2 && indexPath.row == 1  && isViewAllButtonTapped == false {
                
            }
                else if indexPath.section == 3 && indexPath.row == 1  && isViewAllButtonTapped == false {
                    
                }
            else{
               heightForRowAt = 110
            }
            
            return CGFloat(heightForRowAt)
            
        } else {
            heightForRowAt = 0
           
            return CGFloat(heightForRowAt)
            
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.employeeTableView.register(UINib(nibName: "EditServiceHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "EditServiceHeaderView")
        let header = self.employeeTableView.dequeueReusableHeaderFooterView(withIdentifier: "EditServiceHeaderView") as! EditServiceHeaderView
        let secHeader = self.empListArray[section].headerTitle ?? ""
        header.customInit(title:secHeader, section: section, delegate: self)
        
        return header
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.employeeTableView.register(UINib(nibName: "contentTVC", bundle: nil), forCellReuseIdentifier: "contentTVC")
        let editServicesTVC =  self.employeeTableView.dequeueReusableCell(withIdentifier: "contentTVC") as! contentTVC
        editServicesTVC.empNameLabel.text = self.empListArray[indexPath.section].data?[indexPath.row].empName ?? ""
        
        editServicesTVC.designationLbl.text = self.empListArray[indexPath.section].data?[indexPath.row].empDesignation ?? ""
        editServicesTVC.companyLocationLbl.text = self.empListArray[indexPath.section].data?[indexPath.row].empDepartment
        
        if indexPath.row == 1{
            editServicesTVC.viewAllButtonHeight.constant = 40
        }else{
         editServicesTVC.viewAllButtonHeight.constant = 0
        }
        editServicesTVC.selectedAccountButton.addTarget(self, action: #selector(self.fundTransferSwitchChanged(_:)), for: .touchUpInside)
        return editServicesTVC
    }
    
    @objc func fundTransferSwitchChanged(_ sender : UIButton ){
        
     let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.employeeTableView)
        if let indexPath = self.employeeTableView.indexPathForRow(at: buttonPosition) {
            let employeeListVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EmployeeListViewController") as? EmployeeListViewController
            employeeListVc?.eachDepaData = self.empListArray[indexPath.section]
            
            self.navigationController?.pushViewController(employeeListVc!, animated: true)

        }
    }
    
    
    func toggleSection(header: EditServiceHeaderView, section: Int,selectionButton:UIButton) {
        print(section)
        self.empListArray[section].isExpanded = !self.empListArray[section].isExpanded!
        if section == 0 {
            if self.empListArray[section].isExpanded == false {
                self.isViewAllButtonTapped = false
            }
        }
        
         self.employeeTableView.reloadData()
    }
    
}
