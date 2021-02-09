//
//  APIServiceError.swift
//  EmployeeList
//
//  Created by Wang Siman on 1/29/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation

enum APIServiceError: Error {
    case invalidURL
    case httpError(HTTPCode)
    case parseError
    case unexpectedResponse
}

extension APIServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpError(statusCode): return "Unexpected HTTP status code: \(statusCode)"
        case .parseError: return "Unexpected JSON parse error"
        case .unexpectedResponse: return "Unexpected response from the server"
        }
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}

