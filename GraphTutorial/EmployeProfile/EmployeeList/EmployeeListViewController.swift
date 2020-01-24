//
//  EmployeeListViewController.swift
//  ANTSDemo
//
//  Created by Kranthi on 10/30/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit

class EmployeeListViewController: UIViewController {
    
    @IBOutlet weak var employeeListTblView: UITableView!
    @IBOutlet weak var navigationHeight: NSLayoutConstraint!
    var eachDepaData:employeDetalisListStruct?
    var filtereachDepaData:employeDetalisListStruct?
    
    var tempArray = Array<Any>()
    var tempDict = [String:String]()

    @IBOutlet weak var searchTxfField: UITextField!
    
    var imageAttachmentsPath:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filtereachDepaData = eachDepaData
        // Do any additional setup after loading the view.
        
        print(eachDepaData?.data as Any)
        
        employeeListTblView.tableFooterView = UIView()

        if UIDevice().userInterfaceIdiom == .phone {
                        switch UIScreen.main.nativeBounds.height {
                        case 1136:
                            
                            customNavigationBarHeight = 70
                            
                        case 1334:
                            print("iPhone 6/6S/7/8")
                            customNavigationBarHeight = 70
                            
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
                        self.navigationHeight.constant = CGFloat(customNavigationBarHeight)
                    }
   
    }

    @IBAction func downloadBtnClick(_ sender: Any) {
                
        
         var empArray = [[String:Any]]()

        for  emp in filtereachDepaData!.data! {

            let empDict = ["empId": emp.empID ?? "",
            "empMobile": emp.empMobile ?? 0,
            "empDesignation": emp.empDesignation ?? "",
            "empName": emp.empName ?? "",
            "empLocation": emp.empLocation ?? "",
            "empEmail": emp.empEmail ?? "",
            "empDepartment": emp.empDepartment ?? "",
            "empReportingmanager": emp.empReportingmanager ?? ""] as [String : Any]
            empArray.append(empDict)

        }
        //let downloadEmpParams = ["emp":empArray ]
        
        let downloadEmpParams = empArray

        WebServiceHandler.sharedInstance.downloadDataService(params: downloadEmpParams as Array<AnyObject>, requestAPI: downloadDataUrl, success: { (downloadResponceDta) in
            print(downloadResponceDta as Any)
        }) { (downloadResponceError) in
            
            print(downloadResponceError as Any)
            
        }
    }
    @IBAction func backBtnClick(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:-DOWNLOADFiles


func getDirectoryPath() -> NSURL {
    let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("EmployeeDataFiles")
    let url = NSURL(string: path)
    return url!
}

func saveImageDocumentDirectory(documentName:String, fileName: String) {
//       let fileManager = FileManager.default
//       imageAttachmentsPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("AttachedImages")
//       if !fileManager.fileExists(atPath: imageAttachmentsPath) {
//           try! fileManager.createDirectory(atPath: imageAttachmentsPath, withIntermediateDirectories: true, attributes: nil)
//       }
//       let url = NSURL(string: imageAttachmentsPath)
//       let imagePath = url!.appendingPathComponent(imageName)
//       let urlString: String = imagePath!.absoluteString
//       // let imageData = UIImageJPEGRepresentation(image, 0.5)
//      // let imageData = image.jpegData(compressionQuality: 0.75)
//       //let imageData = UIImagePNGRepresentation(image)
//      // fileManager.createFile(atPath: urlString as String, contents: imageData, attributes: nil)
//       //print(imageAttachmentsPath)
   }



//MARK:-EmployeeTableviewDataSource&Delegates

extension EmployeeListViewController:UITableViewDataSource,UITableViewDelegate{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.eachDepaData?.data?.count ?? 0
}
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier:"EmployeeListCell") as! EmployeeListCell
   // cell.viewProfileBtn.tag = indexPath.row
    cell.viewProfileBtn.addTarget(self, action: #selector(viewProfileBtn), for: .touchUpInside)
    //cell.viewProfileBtn.tag = indexPath.row

    cell.empName.text = self.eachDepaData?.data?[indexPath.row].empName ?? ""
    cell.designation.text = self.eachDepaData?.data?[indexPath.row].empDepartment ?? ""
    cell.locationName.text = self.eachDepaData?.data?[indexPath.row].empLocation ?? ""
    //cell.viewProfileBtn.addTarget(self, action: Selector(("viewProfileBtn:")), for: UIControl.Event.touchUpInside)
    return cell
    
   }

    @objc func viewProfileBtn(sender: UIButton){
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.employeeListTblView)
               if let indexPath = self.employeeListTblView.indexPathForRow(at: buttonPosition) {
                   let profilePicVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EmployeeProfileViewController") as? EmployeeProfileViewController
                   
                profilePicVc?.empDict = self.eachDepaData?.data?[indexPath.row]
                   
                    self.navigationController?.pushViewController(profilePicVc!, animated: true)
               }
        
    }
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   return 80
 }

}

//MARK:-
extension EmployeeListViewController:UITextFieldDelegate{
    func callForSearchMethod(searchSTR:String?){
           if let searchText = searchSTR ,!((searchSTR?.isEmpty)!) {
               
            let filterData = filtereachDepaData?.data?.filter{//caseInsensitive
                return $0.empName?.range(of: searchText, options: .caseInsensitive) != nil || $0.empDepartment?.range(of: searchText, options: .caseInsensitive) != nil || $0.empLocation?.range(of: searchText, options: .caseInsensitive) != nil
                      
               }
            self.eachDepaData?.data = filterData
            print(filterData as Any)
             self.employeeListTblView.reloadData()
           }else {
                self.eachDepaData = self.filtereachDepaData
           }
           self.employeeListTblView.reloadData()
       }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText =  self.searchTxfField.text
        let searchSTR = (oldText as NSString?)?.replacingCharacters(in: range, with: string)
        self.callForSearchMethod(searchSTR: searchSTR)
        return true
    }
    
}
