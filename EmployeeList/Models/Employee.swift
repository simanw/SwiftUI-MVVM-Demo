//
//  Employee.swift
//  EmployeeList
//
//  Created by Wang Siman on 1/29/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation
import UIKit

enum EmployeeType: String, Decodable {
    case FULL_TIME
    case PART_TIME
    case CONTRACTOR
}

struct Employee: Decodable, Identifiable {
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

