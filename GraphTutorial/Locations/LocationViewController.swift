//
//  LocationViewController.swift
//  ANTSDemo
//
//  Created by Kranthi on 11/1/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    var menuVc:MenuViewController!

    @IBOutlet weak var menuBtnTag: UIButton!
    
     let locationsListArray = ["Banglore","Ahamedabad","pune","Hyderabad"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
extension LocationViewController:UITableViewDelegate,UITableViewDataSource{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return locationsListArray.count
    
}
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier:"LocationTVCell") as! LocationTVCell

 
    cell.locationsLblName.text = locationsListArray[indexPath.row]
    
    return cell
    
   }

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   return 80
 }

}



