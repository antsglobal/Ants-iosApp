//
//  UtilitiesClass.swift
//  ANTSDemo
//
//  Created by Kranthi on 10/18/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit

class UtilitiesClass: NSObject {
    
    static let sharedInstance :UtilitiesClass = {
          
          let instance = UtilitiesClass()

          
          return instance
      }()
    
    func showAlertToUser(massege:String,controller:UIViewController){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "ANTS App", message: massege, preferredStyle: .alert)
            controller.present(alertController, animated: true, completion: nil)
            let OKAction = UIAlertAction(title:"OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
        }
    }
    
    func textFieldRoundRect(textField:UITextField){
        
        textField.layer.cornerRadius = 15.0
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.white.cgColor
        
    }
    
    func buttonRoundRect(selectedButton:UIButton){
        
        selectedButton.layer.cornerRadius = 15
        selectedButton.clipsToBounds = true
        
    }
    
    
     //MARK:- UserDefault
     func setUserDefaultKeyedArchiver(userDefaultKey:String,savingData:AnyObject){
         let data = NSKeyedArchiver.archivedData(withRootObject: savingData)
         UserDefaults.standard.set(data, forKey: userDefaultKey)
     }
     func getUserDefaultKeyedUnarchiver(userDefaultKey:String)-> AnyObject{
         
         if let data = UserDefaults.standard.object(forKey: userDefaultKey) as? NSData {
             let getData = NSKeyedUnarchiver.unarchiveObject(with: data as Data)
             return getData as AnyObject
         }else{
             return "No Data" as AnyObject
         }
         
     }
}
