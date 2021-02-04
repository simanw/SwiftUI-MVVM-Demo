//
//  CustomImageViewModelTests.swift
//  EmployeeListTests
//
//  Created by Wang Siman on 2/3/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation
import XCTest
import Combine
@testable import EmployeeList

class CustomImageViewModelTests: XCTestCase {
    
    func test_loadImageFromWebWhenImageNotExisting_validImage() {
        let mockImageService = MockImageService()
        
        mockImageService.stub(for: ImageRequest.self, response: { _ in
            Result.Publisher(
                (UIImage(named: "iu")?.jpegData(compressionQuality: 0.6))!
            ).eraseToAnyPublisher()
            
        })
        let viewModel = CustomImageViewModel(imageService: mockImageService,
        imageURL: "")
        
        viewModel.update()
        XCTAssertTrue(mockImageService.isSaveToDiskCalled)
        XCTAssertNotEqual(viewModel.image, UIImage(named: "iu"))
    }
    
    func test_loadImageFromWebWhenImageNotExisting_invalidImage() {
        let mockImageService = MockImageService()
        
        mockImageService.stub(for: ImageRequest.self, response: { _ in
            Result.Publisher(
                Data()
            ).eraseToAnyPublisher()
            
        })
        
        let viewModel = CustomImageViewModel(imageService: mockImageService,
                                             imageURL: "")
        viewModel.update()
        XCTAssertTrue(mockImageService.isSaveToDiskCalled)
        XCTAssertEqual(viewModel.image, UIImage(named: "iu"))
        
    }
    
    func test_loadImageFromDiskWhenImageExisting() {
        let mockImageService = MockImageService()
        mockImageService.isExistingState = true
        
        let viewModel = CustomImageViewModel(imageService: mockImageService,
                                             imageURL: "")
        viewModel.update()
        XCTAssertTrue(mockImageService.isLoadFromDiskCalled)
    }
    
    func test_throwError() {
        let mockImageService = MockImageService()
        mockImageService.stub(for: ImageRequest.self, response: { _ in
            Result.Publisher(
                ImageProcessingError.notFoundInDisk("dd")
            ).eraseToAnyPublisher()
        })
        let viewModel = CustomImageViewModel(imageService: mockImageService,
                                             imageURL: "")
        viewModel.update()
        XCTAssertEqual(viewModel.errorMessage, ImageProcessingError.notFoundInDisk("dd").errorDescription)
        
    }
}
