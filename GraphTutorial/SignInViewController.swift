//
//  SignInViewController.swift
//  GraphTutorial
//
//  Copyright © 2019 Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit
import MSGraphClientModels
import MSAL

struct UserInfoStruct {
    var userName:String
    var emailID:String
    var phoneNumber:String
    var companyLocation:String
    var displayName:String
}

class SignInViewController: UIViewController {

    private let spinner = SpinnerViewController()
    
    var userDetailsOBJ = [String:String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        // See if a user is already signed in
        spinner.start(container: self)

        AuthenticationManager.instance.getTokenSilently {
            (token: String?, error: Error?) in

            DispatchQueue.main.async {
                self.spinner.stop()

                guard let _ = token, error == nil else {
                    // If there is no token or if there's an error,
                    // no user is signed in, so stay here
                    return
                }

                // Since we got a token, a user is signed in
                // Go to welcome page
               // self.performSegue(withIdentifier: "userSignedIn", sender: nil)
            }
        }
    }
    
    
    // MARK: Get account and removing cache

   

    @IBAction func signIn() {
        spinner.start(container: self)

        // Do an interactive sign in
        AuthenticationManager.instance.getTokenInteractively(parentView: self) {
            (token: String?, error: Error?) in

            DispatchQueue.main.async {
                self.spinner.stop()

                guard let _ = token, error == nil else {
                    // Show the error and stay on the sign-in page
                    let alert = UIAlertController(title: "Error signing in",
                                                  message: error.debugDescription,
                                                  preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }

                // Signed in successfully
                // Go to welcome page
                
                self.getme()                
            }
        }
    }
    func checkLoginStatus(){
     
     let mailidData = UtilitiesClass.sharedInstance.getUserDefaultKeyedUnarchiver(userDefaultKey:"userdata")
            print(mailidData)
     
    // ["school_id":"\(logindata.object(forKey: "school_id") ?? "")"]
     
        let emailparams = ["loginEmailid":mailidData.object(forKey: "email")]
        print(emailparams)


     WebServiceHandler.sharedInstance.requestForLoginService(params: emailparams as [String : AnyObject], requestAPI: loginUrl, success: { (loginStatusData) in
         
         print(loginStatusData as Any)
         
         DispatchQueue.main.async {
                        
     let HomeVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
     self.navigationController?.pushViewController(HomeVc!, animated: true)

                    }
       
         
     }) { (loginFailureData) in
         
         print(loginFailureData as Any)
         
        // let errormsg = loginFailureData?.object(forKey:"message") as? String
         
         UtilitiesClass.sharedInstance.showAlertToUser(massege:"UNAUTHORIZED USER", controller: self)
     }
    }
    
    
    
    func getme(){
        
        GraphManager.instance.getMe {
                   (user: MSGraphUser?, error: Error?) in
                   
                   DispatchQueue.main.async {
                       self.spinner.stop()

                       guard let currentUser = user, error == nil else {
                           print("Error getting user: \(String(describing: error))")
                           return
                       }
                    print(currentUser)
                    
                    self.userDetailsOBJ = ["userDisplayName":currentUser.displayName ?? "","email":currentUser.mail ?? "","empLocation":currentUser.officeLocation ?? ""]
                    
                    print(self.userDetailsOBJ)

                    UtilitiesClass.sharedInstance.setUserDefaultKeyedArchiver(userDefaultKey: "userdata", savingData: self.userDetailsOBJ as AnyObject)
                    
                    
                    self.checkLoginStatus()
        
    }
}
}
}

//extension SignInViewController {
//       
//       func currentAccount() -> MSALAccount? {
//           
//           guard let applicationContext = self.applicationContext else { return nil }
//           
//           // We retrieve our current account by getting the first account from cache
//           // In multi-account applications, account should be retrieved by home account identifier or username instead
//           
//           do {
//               
//               let cachedAccounts = try applicationContext.allAccounts()
//               
//               if !cachedAccounts.isEmpty {
//                   return cachedAccounts.first
//               }
//               
//           } catch let error as NSError {
//               
//               self.updateLogging(text: "Didn't find any accounts in cache: \(error)")
//           }
//           
//           return nil
//       }
//       
//       /**
//        This action will invoke the remove account APIs to clear the token cache
//        to sign out a user from this application.
//        */
//       @objc func signOut(_ sender: UIButton) {
//           
//           guard let applicationContext = self.applicationContext else { return }
//           
//           guard let account = self.currentAccount() else { return }
//           
//           do {
//               
//               /**
//                Removes all tokens from the cache for this application for the provided account
//                
//                - account:    The account to remove from the cache
//                */
//               
//               try applicationContext.remove(account)
//               self.updateLogging(text: "")
//               self.updateSignOutButton(enabled: false)
//               self.accessToken = ""
//               
//           } catch let error as NSError {
//               
//               self.updateLogging(text: "Received error signing account out: \(error)")
//           }
//       }
//   }
