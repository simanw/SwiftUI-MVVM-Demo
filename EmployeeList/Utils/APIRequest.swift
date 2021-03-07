//
//  APIService.swift
//  EmployeeList
//
//  Created by Wang Siman on 1/29/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation

protocol APIRequestType {
    associatedtype ModelType: Decodable
    
    var path: String {get}
    var method: String {get}
    var headers: [String: String]? {get}
    var queryItems: [URLQueryItem]? {get}
    func body() throws -> Data?
}

extension APIRequestType {
    func buildRequest(baseURL: String) throws -> URLRequest {
        
        guard let url = URL(string: baseURL + path) else {
            throw APIServiceError.invalidURL
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}

struct EmployeeListRequest: APIRequestType {
    typealias ModelType = EmployeeListResponse
    
    var path: String
    var method: String { return "GET" }
    var headers: [String: String]? { return ["Content-Type": "application/json"] }
    var queryItems: [URLQueryItem]?
    func body() throws -> Data? {
        return Data()
    }
}

struct ImageRequest: APIRequestType {
    typealias ModelType = Data
    
    var path: String
    var method: String { return "GET" }
    var headers: [String : String]?
    var queryItems: [URLQueryItem]?
    func body() throws -> Data? {
        return Data()
    }
}

struct EmployeePostRequest: APIRequestType {
    
    typealias ModelType = Employee
    
    var employee: ModelType
    var path: String
    var method: String { return "POST" }
    var headers: [String : String]?
    var queryItems: [URLQueryItem]?
    func body() throws -> Data? {
        let encoder = JSONEncoder()
        return try encoder.encode(employee)
    }
}
