//
//  ProjectsViewController.swift
//  ANTSDemo
//
//  Created by Kranthi on 10/31/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit

struct listofProjects {
    var isExpanded:Bool
    var headerTitle:String
    var projectsList:[projectLisData]
    init(isExpanded:Bool,hrList:[projectLisData],headerTitle:String) {
        self.isExpanded = isExpanded
        self.projectsList    = hrList
        self.headerTitle = headerTitle
    }
    struct projectLisData {
        var hrName:String?
        var location:String?
        init(hrName:String?,location:String?) {
            self.hrName = hrName
            self.location = location
        }
    }
}


class ProjectsViewController: UIViewController {
    @IBOutlet weak var navigatioHeight: NSLayoutConstraint!
    // @IBOutlet weak var pageControlCollectionV: UICollectionView!
    
    let sectionData = ["projects1", "projects2 ", "projects1"]
     let employeeNames = [["Projectname":"projects1","Location":"Hyderabad"],["Projectname":"projects1","Location":"Hyderabad"],["Projectname":"projects1","Location":"Hyderabad"],["Projectname":"projects1","Location":"Hyderabad"],["Projectname":"projects1","Location":"Hyderabad"]]

    
    
    @IBOutlet weak var projectsListTable: UITableView!
    var hrListArray = [listOFHumanResource]()
        // @IBOutlet weak var mainTableView: UITableView!
        var isViewAllButtonTapped = false
      
      var menuVc:MenuViewController!
    
   // let pageControlArrayImages = [UIImage(named:"main-banner"),UIImage(named:"main-banner")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //self.collectionView.register(UINib(nibName: "MyCustomView", bundle: nil), forCellWithReuseIdentifier: "myCell")
        
        projectsListTable.tableFooterView = UIView()
        var hList = [listOFHumanResource.hrListData]()
              
              for val in 0...sectionData.count-1{
                  for emp in employeeNames{
                      let hrNmae1 = emp["Projectname"] ?? ""
                      let location11 = emp["Location"] ?? ""
                      let item = listOFHumanResource.hrListData(hrName: hrNmae1, location: location11)
                      hList.append(item)
                         
                  }
                  let headT = sectionData[val]
                  let item = listOFHumanResource(isExpanded: false, hrList: hList, headerTitle: headT)
                  hrListArray.append(item)
              }
                         projectsListTable.delegate = self
                         projectsListTable.dataSource = self
                         projectsListTable.reloadData()
                  
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

extension ProjectsViewController:UITableViewDataSource,UITableViewDelegate,EditAccessExpandableHeaderVDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.hrListArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2//self.hrListArray[section].hrList.count
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        var heightForRowAt = 150
        if (self.hrListArray[indexPath.section].isExpanded) {
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
        if (self.hrListArray[indexPath.section].isExpanded) {
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
        self.projectsListTable.register(UINib(nibName: "EditServiceHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "EditServiceHeaderView")
        let header = self.projectsListTable.dequeueReusableHeaderFooterView(withIdentifier: "EditServiceHeaderView") as! EditServiceHeaderView
        let secHeader = self.hrListArray[section].headerTitle
        header.customInit(title:"\(secHeader)", section: section, delegate: self)
        return header
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.projectsListTable.register(UINib(nibName: "contentTVC", bundle: nil), forCellReuseIdentifier: "contentTVC")
        let editServicesTVC =  self.projectsListTable.dequeueReusableCell(withIdentifier: "contentTVC") as! contentTVC
       
        if indexPath.row == 1{
            editServicesTVC.viewAllButtonHeight.constant = 40
        }else{
         editServicesTVC.viewAllButtonHeight.constant = 0
        }
        editServicesTVC.selectedAccountButton.addTarget(self, action: #selector(self.fundTransferSwitchChanged(_:)), for: .touchUpInside)
        return editServicesTVC
    }
    
    @objc func fundTransferSwitchChanged(_ sender : UISwitch ){
        
              let employeeListVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EmployeeListViewController") as? EmployeeListViewController
               self.navigationController?.pushViewController(employeeListVc!, animated: true)

    }
    
    
    func toggleSection(header: EditServiceHeaderView, section: Int,selectionButton:UIButton) {
        print(section)
        self.hrListArray[section].isExpanded = !self.hrListArray[section].isExpanded
        if section == 0 {
            if self.hrListArray[section].isExpanded == false {
                self.isViewAllButtonTapped = false
            }
        }
        
         self.projectsListTable.reloadData()
    }
    
}
