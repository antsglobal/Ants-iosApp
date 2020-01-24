//
//  WebServiceHandler.swift
//  ANTSDemo
//
//  Created by Kranthi on 11/14/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit

class WebServiceHandler: NSObject {
    
    class var sharedInstance :  WebServiceHandler
    {
        struct Static
        {
            static let instance : WebServiceHandler =  WebServiceHandler()
        }
        return Static.instance
    }
    
  //MARK:-LoginMethod
    
       func requestForLoginService(params:[String:AnyObject],requestAPI:String,success:@escaping(_ responseObj:AnyObject?) -> Void,failure:@escaping(_ error:AnyObject?) -> Void){
       
           print(params)
        let mail = params["loginEmailid"] as? String

        let Url = String(format: "\(requestAPI)"+"\(mail ?? "")")
        print("GET ---->  \(Url)")

           let configuration = URLSessionConfiguration.default
           configuration.timeoutIntervalForRequest = TimeInterval(30)
           configuration.timeoutIntervalForResource = TimeInterval(30)
           let session = URLSession(configuration: configuration)
           guard let serviceUrl = URL(string: Url) else { return }
           var request = URLRequest(url: serviceUrl)
           request.httpMethod = "GET"
//           do {
//               request.httpBody = try JSONSerialization.data(withJSONObject: params , options: .prettyPrinted)
//           } catch let error {
//               print(error.localizedDescription)
//           }
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.addValue("application/json", forHTTPHeaderField: "Accept")
           let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
               guard error == nil else {
                   return
               }
               guard let data = data else {
                   return
               }
               do {
                   //create json object from data
                   if let jsonDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                       print(jsonDict)
                       if let message = jsonDict["message"] as? String {
                           if message == "successfully loged in"{
                               success(jsonDict as AnyObject)
                           }else{
                               failure(message as AnyObject)
                           }
                       }
                       
                   }
               } catch let error {
                   print(error.localizedDescription)
                   failure(error.localizedDescription as AnyObject)
               }
           })
           task.resume()
           
       }
    
    //MARK:-EmployeeData
    
    
    func EmployeeData(params:[String:AnyObject],requestAPI:String,success:@escaping(_ responseObj:[String:AnyObject]) -> Void,failure:@escaping(_ error:AnyObject?) -> Void){
           
               print(params)
            let mail = params["loginEmailid"] as? String

            let Url = String(format: "\(requestAPI)"+"\(mail ?? "")")
            print("GET ---->  \(Url)")

               let configuration = URLSessionConfiguration.default
               configuration.timeoutIntervalForRequest = TimeInterval(30)
               configuration.timeoutIntervalForResource = TimeInterval(30)
               let session = URLSession(configuration: configuration)
               guard let serviceUrl = URL(string: Url) else { return }
               var request = URLRequest(url: serviceUrl)
               request.httpMethod = "GET"
    //           do {
    //               request.httpBody = try JSONSerialization.data(withJSONObject: params , options: .prettyPrinted)
    //           } catch let error {
    //               print(error.localizedDescription)
    //           }
               request.addValue("application/json", forHTTPHeaderField: "Content-Type")
               request.addValue("application/json", forHTTPHeaderField: "Accept")
               let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                   guard error == nil else {
                       return
                   }
                   guard let data = data else {
                       return
                   }
                   do {
                       //create json object from data
                       if let jsonDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                           print(jsonDict)

                        if let message = jsonDict["Status"] as? String {
                               if message == "Success"{
                                success(jsonDict as [String:AnyObject])
                               }else{
                                   failure(message as AnyObject)
                               }
                           }
                           
                       }
                   } catch let error {
                       print(error.localizedDescription)
                       failure(error.localizedDescription as AnyObject)
                   }
               })
               task.resume()
               
      }
    
//MARK:-downloadDataService
    
    func downloadDataService(params:Array<AnyObject>,requestAPI:String,success:@escaping(_ responseObj:AnyObject?) -> Void,failure:@escaping(_ error:AnyObject?) -> Void){
        
        print(params)
        print("POST ---->  \(requestAPI)")
        let Url = String(format: requestAPI)
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(30)
        configuration.timeoutIntervalForResource = TimeInterval(30)
        let session = URLSession(configuration: configuration)
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params , options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                //create json object from data
                if let jsonDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    print(jsonDict)

                   // success(jsonDict as AnyObject)

                    
//                    if let message = jsonDict["message"] as? String {
//                        if message == "Otp Successfully Verified"{
//                            success(jsonDict as AnyObject)
//                        }else{
//                            failure(message as AnyObject)
//                        }
//                    }
                    
                }
            } catch let error {
                print(error.localizedDescription)
                failure(error.localizedDescription as AnyObject)
            }
        })
        task.resume()
        
    }


}


