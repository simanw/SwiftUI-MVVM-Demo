//
//  MockImageService.swift
//  EmployeeListTests
//
//  Created by Wang Siman on 2/3/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation
import Combine
import UIKit
@testable import EmployeeList

final class MockImageService: ImageServiceType {

    var stubs: [Any] = []
    internal let baseURL: String = ""
    internal let session: URLSession = URLSession.shared
    internal let bgQueue: DispatchQueue = DispatchQueue(label: "test")
    
    private var isExisting = false
    var isExistingState: Bool {
        get {
            return isExisting
        }
        set(newSate) {
            isExisting = newSate
        }
    }
    var isLoadFromDiskCalled = false
    var isSaveToDiskCalled = false
    
    func stub<Request>(for type: Request.Type, response: @escaping ((Request) -> AnyPublisher<Request.ModelType, Error>)) where Request: APIRequestType {
        stubs.append(response)
    }
    
    func call<Request>(from request: Request) -> AnyPublisher<Request.ModelType, Error> where Request: APIRequestType {
        
        let response = stubs.compactMap { stub -> AnyPublisher<Request.ModelType, Error>? in
            let stub = stub as? ((Request) -> AnyPublisher<Request.ModelType, Error>)
            return stub?(request)
        }.last
        
        return response ?? Empty<Request.ModelType, Error>()
            .eraseToAnyPublisher()
    }
    
    func loadFromDisk(forKey key: String) -> AnyPublisher<Data, Error> {
        isLoadFromDiskCalled = true
        return Empty<Data, Error>().eraseToAnyPublisher()
    }
    
    func existsInDisk(_ key: String) -> Bool {
        return isExisting
    }
    
    func saveToDisk(_ image: UIImage, forKey key: String) -> AnyPublisher<Bool, Error> {
        isSaveToDiskCalled = true
        return Empty<Bool, Error>().eraseToAnyPublisher()
    }
}

