//
//  ImageService.swift
//  EmployeeList
//
//  Created by Wang Siman on 1/29/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation
import Combine
import UIKit

protocol ImageServiceType: APIServiceType{
    func existsInDisk(_ key: String) -> Bool
    func loadFromDisk(forKey key: String) -> AnyPublisher<Data, Error>
    func saveToDisk(_ image: UIImage, forKey key: String) -> AnyPublisher<Bool, Error>
}

final class ImageService: ImageServiceType {
    internal let baseURL: String
    internal let session: URLSession = URLSession.shared
    internal let bgQueue: DispatchQueue = DispatchQueue.main
    
    init(baseURL: String =  "") {
        self.baseURL = baseURL
    }
    
    private var cancellables: [AnyCancellable] = []
    private let onAppearSubject = PassthroughSubject<Void, Error>()
    private let cache = Cache()
    
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
                    print("call image from url ")

                    return $0.0 as! Request.ModelType // Pass data to downstream publishers
                }
                .receive(on: self.bgQueue)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail<Request.ModelType, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func loadFromDisk(forKey key: String) -> AnyPublisher<Data, Error> {
        return self.cache.loadFromDisk(forKey: key)
    }
    
    func existsInDisk(_ key: String) -> Bool {
        return self.cache.exits(forKey: key)
    }
    
    func saveToDisk(_ image: UIImage, forKey key: String) -> AnyPublisher<Bool, Error> {
        return self.cache.saveToDisk(image: image, forKey: key)
    }
}

