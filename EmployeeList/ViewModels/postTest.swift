//
//  postTest.swift
//  EmployeeList
//
//  Created by Wang Siman on 3/6/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation

class PostTest {
    static let employee = Employee(id: UUID(uuidString: "B6DEA526-C571-4D43-8B41-375CA5CD9FDB")!,
                            fullName: "Post Test", phoneNumber: "98765431", emailAddress: "post@mail.com", team: "Sales", employeeType: EmployeeType(rawValue: "FULL_TIME")!)
    let endpoint = EmployeePostRequest(employee: employee, path: <#T##String#>, headers: <#T##[String : String]?#>, queryItems: nil)
    
    let request = endpoint.buildRequest(baseURL: "")
}
