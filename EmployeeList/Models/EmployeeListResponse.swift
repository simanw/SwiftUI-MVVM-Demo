//
//  EmployeeListResponse.swift
//  EmployeeList
//
//  Created by Wang Siman on 1/29/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation

struct EmployeeListResponse: Decodable {
    var employees: [Employee]
}
