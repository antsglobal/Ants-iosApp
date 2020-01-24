//
//  ProjectDetailViewController.swift
//  ANTSDemo
//
//  Created by Kranthi on 10/31/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit

class ProjectDetailViewController: UIViewController {
    @IBOutlet weak var projectDetailsTableV: UITableView!
    @IBOutlet weak var navigationHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        projectDetailsTableV.tableFooterView = UIView()

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
                               self.navigationHeight.constant = CGFloat(customNavigationBarHeight)
                           }

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


extension ProjectDetailViewController:UITableViewDataSource,UITableViewDelegate{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return 6
    
}
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier:"projectDetailsTVCell") as! projectDetailsTVCell
    
   // cell.viewProfileBtn.tag = indexPath.row
    cell.viewProjectBtn.addTarget(self, action: #selector(viewProfileBtn), for: .touchUpInside)
    cell.viewProjectBtn.tag = indexPath.row


    //cell.viewProfileBtn.addTarget(self, action: Selector(("viewProfileBtn:")), for: UIControl.Event.touchUpInside)

    
    return cell
    
   }

    @objc func viewProfileBtn(sender: UIButton){
        let buttonTag = sender.tag
        
               let projectInfoVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProjectDetailInfoViewController") as? ProjectDetailInfoViewController
               self.navigationController?.pushViewController(projectInfoVc!, animated: true)
                 
    }
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   return 80
 }

   
}
