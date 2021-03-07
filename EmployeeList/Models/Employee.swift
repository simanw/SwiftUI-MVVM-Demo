//
//  Employee.swift
//  EmployeeList
//
//  Created by Wang Siman on 1/29/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation
import UIKit

//enum EmployeeType: String, Codable {
//
//    case FULL_TIME
//    case PART_TIME
//    case CONTRACTOR
//
//}

enum EmployeeType: String, Codable, CaseIterable {
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
}

struct Employee: Codable, Identifiable {
    var id: UUID
    var fullName: String
    var phoneNumber: String?
    var emailAddress: String
    var biography: String?
    var photoUrlSmall: String?
    var photoUrlLarge: String?
    var team: String
    var employeeType: EmployeeType
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }

}

let testEmployee = Employee(
    id: UUID(uuidString: "B6DEA526-C571-4D43-8B41-375CA5CD9FDB")!,
    fullName: "Elisa Rizzo",
    phoneNumber: "123456789",
    emailAddress: "erizzo.demo@squareup.com",
    biography: Optional("iOS Engineer on the Restaurants team."),
    photoUrlSmall:  "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
    photoUrlLarge: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",
    team: "Operations",
    employeeType: EmployeeType.fullTime)
