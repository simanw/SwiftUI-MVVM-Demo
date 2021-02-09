//
//  MockResponses.swift
//  EmployeeList
//
//  Created by Wang Siman on 2/3/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation
import Combine
@testable import EmployeeList

enum MockResponse {
    case employeeListResponse
    case emptyListResponse
    case malformedJsonResponse
}

struct MockResponseGenerator {
    
    let normalJson = """
    "employees" : [
        {
      "uuid" : "0d8fcc12-4d0c-425c-8355-390b312b909c",

      "full_name" : "Justine Mason",
      "phone_number" : "5553280123",
      "email_address" : "jmason.demo@squareup.com",
      "biography" : "Engineer on the Point of Sale team.",

      "photo_url_small" : "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
      "photo_url_large" : "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",

      "team" : "Point of Sale",
      "employee_type" : "FULL_TIME"
        }
    ]
    """.data(using: .utf8)!
    
    let emptyJson = """
        {
            "employees" : [
            ]
        }
    """.data(using: .utf8)!
    
    let malformedJson = """
        "employees" : [
            {
          "uuid" : "0d8fcc12-4d0c-425c-8355-390b312b909c",

          "full_name" : "Justine Mason",
          "phone_number" : "5553280123",
          "biography" : "Engineer on the Point of Sale team.",

          "photo_url_small" : "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
          "photo_url_large" : "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",

          "team" : "Point of Sale",
          "employee_type" : "FULL_TIME"
            }
        ]
    """.data(using: .utf8)!
    
    func makeEmployeeList() -> AnyPublisher<Data, Error>{
        let publisher = CurrentValueSubject<Data, Error>(normalJson)
        
        return publisher
            .decode(type: Data.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func makeEmptyList() -> AnyPublisher<Data, Error> {
        let publisher = CurrentValueSubject<Data, Error>(emptyJson)
        
        return publisher
            .decode(type: Data.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func makeMalformed() -> AnyPublisher<Data, Error> {
        let publisher = CurrentValueSubject<Data, Error>(normalJson)
        
        return publisher
            .decode(type: Data.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

