//
//  HomeViewController.swift
//  ANTSDemo
//
//  Created by Kranthi on 10/21/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit
import MSGraphClientModels

class HomeViewController: UIViewController {

    @IBOutlet weak var homeBtnTag: UIButton!
    @IBOutlet weak var UserWelComeLbl: UILabel!
    
    @IBOutlet weak var navigationHeight: NSLayoutConstraint!
   var menuVc:MenuViewController!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20.0,left: 20.0,bottom: 20.0,right: 20.0)

    let cellIdentifier = "HomeCVCell"
    
    var HomeItemImagesArray = ["employee","projects_icon","meeting_icon","location_icon"]
    var HomeItemNamesArray = ["Employee","projects","Meetings","Locations"]

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        
        let mailidData = UtilitiesClass.sharedInstance.getUserDefaultKeyedUnarchiver(userDefaultKey:"userdata")
                             print(mailidData)
    UserWelComeLbl.text = (mailidData.object(forKey: "userDisplayName") ?? "") as? String

        homeCollectionView.register(UINib(nibName: "HomeCVCell", bundle: nil), forCellWithReuseIdentifier: "HomeCVCell")

             menuVc = self.storyboard?.instantiateViewController(identifier:"MenuViewController" ) as? MenuViewController
        
    }
   
    @IBAction func homeBtnClick(_ sender: Any) {
        
            showMenu()
    }

    func showMenu(){
           UIView.animate(withDuration: 0.0, animations: {
                               
                               self.menuVc.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                               self.menuVc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                               self.addChild(self.menuVc)
                               self.view.addSubview(self.menuVc.view)
                           })
                   }
        
            func closeMenu(){
                
        UIView.animate(withDuration: 0.3, animations: { ()->Void in

                                           self.menuVc.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                                           
                                       }) { (Finished) in
                                           
                                           self.menuVc.view.removeFromSuperview()
                                           }
   }
}
extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HomeCVCell
        
        let homeImages = UIImage(named: HomeItemImagesArray[indexPath.row])

        cell.homeItemsImg.image = homeImages

        cell.homeItemsName.text = HomeItemNamesArray[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if indexPath.item == 0 {
            let CDVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CompanyDetailViewController") as? CompanyDetailViewController
                         self.navigationController?.pushViewController(CDVC!, animated: true)
        }
    }
}

// MARK: - Collection View Flow Layout Delegate
extension HomeViewController : UICollectionViewDelegateFlowLayout {
  //1
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    //2
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  //3
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  // 4
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}

