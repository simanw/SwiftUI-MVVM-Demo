//
//  ImageServiceError.swift
//  EmployeeList
//
//  Created by Wang Siman on 2/2/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation

enum ImageProcessingError: Error {
    case notFoundInDisk(String)
    case storingFailed
    case invalidFilePath(String)
    case unknown(String)
}

extension ImageProcessingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .notFoundInDisk(path): return "Unable to find item at path: \(path)"
        case .storingFailed: return "Unable to store the image"
        case let .invalidFilePath(path): return "Unable to build valid file path: \(path)"
        case let .unknown(msg): return "Unknown error incurred when \(msg)"
        }
    }
}
