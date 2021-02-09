//
//  EmployeeListService.swift
//  EmployeeList
//
//  Created by Wang Siman on 1/29/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation
import Combine

final class EmployeesAPIService: APIServiceType {

    internal let baseURL: String
    internal let session: URLSession = URLSession.shared
    internal let bgQueue: DispatchQueue = DispatchQueue.main
    
    init(baseURL: String =  "https://s3.amazonaws.com/sq-mobile-interview/") {
        self.baseURL = baseURL
    }
 
    func call<Request>(from endpoint: Request) -> AnyPublisher<Request.ModelType, Error> where Request : APIRequestType {
        do {
            let request = try endpoint.buildRequest(baseURL: baseURL)
            return session.dataTaskPublisher(for: request)
                .retry(1)
                .tryMap {
                    guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                        throw APIServiceError.unexpectedResponse
                    }
                    guard HTTPCodes.success.contains(code) else {
                        throw APIServiceError.httpError(code)
                    }
                    return $0.0  // Pass data to downstream publishers
                }
                .decode(type: Request.ModelType.self, decoder: JSONDecoder())
                .mapError {_ in APIServiceError.parseError}
                .receive(on: self.bgQueue)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail<Request.ModelType, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
}
