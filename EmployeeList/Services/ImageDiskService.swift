//
//  ImageDiskService.swift
//  EmployeeList
//
//  Created by Wang Siman on 2/3/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation
import Combine
import UIKit

class ImageDiskService {
    
    private let cache = Cache()
    
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
