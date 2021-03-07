//
//  Team.swift
//  EmployeeList
//
//  Created by Wang Siman on 2/4/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation

struct Team: Codable {
    var name: String
    var employees: [Employee] = []
}
