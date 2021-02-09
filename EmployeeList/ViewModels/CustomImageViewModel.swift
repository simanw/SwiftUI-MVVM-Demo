//
//  CustomImageViewModel.swift
//  EmployeeList
//
//  Created by Wang Siman on 1/31/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation
import UIKit
import Combine

final class CustomImageViewModel: ObservableObject {
    
    @Published var image = UIImage()

    private var cancellables: [String :AnyCancellable] = [:]
    private let onAppearSubject = PassthroughSubject<Void, Error>()
    private let imageURL: String
    
    private let imageService: ImageServiceType
    
    private let imageSubject = PassthroughSubject<Data, Error>()
    private let diskSaveSubject = PassthroughSubject<Void, Error>()
    
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    init(imageService: ImageServiceType = ImageService(), imageURL: String) {
        self.imageService = imageService
        self.imageURL = imageURL
        
        bindInputsToOutputs()
        print(" --- custom image view model init done ---")
    }
    
    // Publish values on-demand by calling the send() method
    func update() {
        onAppearSubject.send(())
    }
    
    private func buildImageKey(_ url: String) -> String {
        if let imageURLComponents = URL(string: url)?.pathComponents {
            if imageURLComponents.count == 1 {
                return url
            }
            let endIndex = imageURLComponents.endIndex
            let id = imageURLComponents[endIndex - 2]
            let size = imageURLComponents[endIndex - 1]
            return id + size
        }
        return url
    }
    
    func bindInputsToOutputs() {
        let imageKey = buildImageKey(self.imageURL)

        if self.imageService.existsInDisk(imageKey) {
            print("Load image from disk")
            loadFromDisk(from: imageKey)
            loadImage()
        } else {
            print("Load image from web")
            loadFromWeb(from: self.imageURL)
            loadImage()
        }

    }
    
    
    // MARK: Bind inputs
    func loadFromDisk(from key: String) {

        let publisher = onAppearSubject.flatMap { _ ->  AnyPublisher<Data, Error> in
            return self.imageService.loadFromDisk(forKey: key)
        }
        let diskStream = publisher.subscribe(imageSubject)
        
        cancellables["disk"] = diskStream
    }
    
    func loadFromWeb(from url: String) {
        
        let endpoint = ImageRequest(path: url)
        let publisher = onAppearSubject.flatMap { _ -> AnyPublisher<Data, Error> in
            return self.imageService.call(from: endpoint)
        }
        let webStream = publisher.subscribe(imageSubject)
        cancellables["web"] = webStream
    }
    
    // MARK: Only save the image to disk the first time the image is downloaded from the web
    func saveToDisk(_ image: UIImage, _ key: String) {

        let publisher = diskSaveSubject.flatMap { _ -> AnyPublisher<Bool, Error> in
            return self.imageService.saveToDisk(self.image, forKey: key)
        }
        
        let diskSaveStream = publisher
            .map { $0 }
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error): do {
                    self.isErrorShown = true
                    self.errorMessage = error.localizedDescription
                    }
                case .finished:
                    break
                }
            }, receiveValue: { data in
                print("Successfully stored image, boolean is \(data)")
            })
        
        diskSaveSubject.send()
        cancellables["diskSave"] = diskSaveStream
    }
    
    // MARK: Bind output
    func loadImage() {
        
        let imageStream = imageSubject
            .map{ $0 }
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error): do {
                    self.isErrorShown = true
                    self.errorMessage = error.localizedDescription
                    }
                case .finished:
                    break
                }
            }, receiveValue: { data in
                self.image = UIImage(data: data) ?? UIImage(named: "iu")!
                let imageKey = self.buildImageKey(self.imageURL)
                if !self.imageService.existsInDisk(imageKey) {
                    self.saveToDisk(self.image, imageKey)
                    self.cancellables["web"]!.cancel()
                }
            })
        cancellables["image"] = imageStream
    }
}
