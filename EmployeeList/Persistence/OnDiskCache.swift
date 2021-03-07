//
//  Cache.swift
//  EmployeeList
//
//  Created by Wang Siman on 1/29/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation
import UIKit
import Combine

final class Cache {
    
    private var fileManager: FileManager = FileManager.default
    
    private func buildFilePath(forKey key: String) -> URL? {
        if let fileURL = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            return fileURL.appendingPathComponent(key)
        }
        return nil
    }
    
    func saveToDisk(image: UIImage, forKey key: String) -> AnyPublisher<Bool, Error>{
        
        do {
            guard let jpeg = image.jpegData(compressionQuality: 0.9) else {
                throw ImageProcessingError.unknown("compressing image")
            }
            guard let filePath = buildFilePath(forKey: key) else {
                throw ImageProcessingError.invalidFilePath(key)
            }
            try jpeg.write(to: filePath, options: .atomic)            
            // print("Successfully stored image in disk for key \(key)")
            return CurrentValueSubject<Bool, Error>(true).eraseToAnyPublisher()
        } catch let error {
            return Fail<Bool, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func loadFromDisk(forKey key: String) -> AnyPublisher<Data, Error> {
        do {
            guard let filePath = buildFilePath(forKey: key) else {
                throw ImageProcessingError.invalidFilePath(key)
            }
            guard exists(forKey: key) else {
                throw ImageProcessingError.notFoundInDisk(filePath.path)
            }
            guard let fileData = self.fileManager.contents(atPath: filePath.path) else {
                throw ImageProcessingError.unknown("fetching image from the disk")
            }
            return CurrentValueSubject<Data, Error>(fileData).eraseToAnyPublisher()
        } catch let error {
            return Fail<Data, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func exists(forKey key: String) -> Bool {
        if let filePath = buildFilePath(forKey: key) {
            let res = self.fileManager.fileExists(atPath: filePath.path)
            // print("onDiskCache test if image exists -> \(res) for key \(filePath.path)")
            return res
        } else {
            return false
        }
    }
}

