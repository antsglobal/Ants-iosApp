// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

/*


struct employeDetalisListStruct: Codable {
    let headerTitle: String?
    var isExpanded:Bool?
    var data: [Datum]?
    // MARK: - Datum
    struct Datum: Codable {
        let empID: String?
        let empMobile: Int?
        let empDesignation, empName: String?
        let empLocation: String?
        let empEmail: String?
        let empDepartment: String?
        let empReportingmanager: String?
    }

}
*/

struct employeDetalisListStruct: Codable {
    var data: [Datum]?
    let headerTitle: String?
    var isExpanded:Bool?
    
    // MARK: - Datum
    struct Datum: Codable {
        let empID: String?
        let empMobile: Int?
        let empDesignation, empName: String?
        let empLocation: String?
        let empEmail: String?
        let empDepartment: String?
        let empReportingmanager: String?

        enum CodingKeys: String, CodingKey {
            case empID = "empId"
            case empMobile, empDesignation, empName, empLocation, empEmail, empDepartment, empReportingmanager
        }
    }

   
   

}







