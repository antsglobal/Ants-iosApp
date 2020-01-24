//
//  MenuViewController.swift
//  ANTSDemo
//
//  Created by Kranthi on 10/16/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userLocationLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    
    let menuTitleArray = ["Home","Employee","Projects","Meetings","Locations","Notifications","Settings"]
    let menuTitleimagesArray = ["home","employee1","projects","meetings","location","notification_icon","settings"]
        
    @IBOutlet weak var menuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
        
        let mailidData = UtilitiesClass.sharedInstance.getUserDefaultKeyedUnarchiver(userDefaultKey:"userdata")
                      print(mailidData)
               
              // ["school_id":"\(logindata.object(forKey: "school_id") ?? "")"]
               
              // let emailparams = ["loginEmailid":"\(mailidData.object(forKey: "mail") ?? "")"]
        
        userNameLbl.text = (mailidData.object(forKey: "userDisplayName") ?? "") as? String
        userLocationLbl.text = (mailidData.object(forKey: "empLocation") ?? "") as? String

        
    }
    
    @IBAction func LogOutBtnClick(_ sender: Any) {
        
        AuthenticationManager.instance.signOut()
        
        let LoginVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
                 self.navigationController?.pushViewController(LoginVc!, animated: true)
        
    }
    @IBAction func menuHideBtnClick(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: { ()->Void in

                      self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                      
                  }) { (Finished) in
                      
                      self.view.removeFromSuperview()
                      }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuTitleArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"MenuTVCell") as! MenuTVCell
        
        cell.menuNameLbl.text = menuTitleArray[indexPath.row]
        
        let homeImages = UIImage(named: menuTitleimagesArray[indexPath.row])

        cell.menuItemsImages.image = homeImages
        
        return cell
        
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
     if indexPath.row == 0 {
            
          let HomeVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
          self.navigationController?.pushViewController(HomeVc!, animated: true)
        }
        else if indexPath.row == 1{
            let CDVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CompanyDetailViewController") as? CompanyDetailViewController
               self.navigationController?.pushViewController(CDVC!, animated: true)
            
        } else if indexPath.row == 2{
            
            let projectVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProjectsViewController") as? ProjectsViewController
                          self.navigationController?.pushViewController(projectVc!, animated: true)
                                          
        }
        else if indexPath.row == 3{
            
            let meetingVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MeetingsViewController") as? MeetingsViewController
                                    self.navigationController?.pushViewController(meetingVc!, animated: true)
                   
               }
        else if indexPath.row == 4{
                  
                  let locationVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
                                          self.navigationController?.pushViewController(locationVc!, animated: true)

        }
    }
    


}
