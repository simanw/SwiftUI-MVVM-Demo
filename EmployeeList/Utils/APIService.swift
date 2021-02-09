//
//  APIService.swift
//  EmployeeList
//
//  Created by Wang Siman on 2/1/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation
import Combine

protocol APIServiceType {
    var session: URLSession {get}
    var baseURL: String {get}
    var bgQueue: DispatchQueue {get}
    func call<Request>(from endpoint: Request) -> AnyPublisher<Request.ModelType, Error> where Request: APIRequestType
}

