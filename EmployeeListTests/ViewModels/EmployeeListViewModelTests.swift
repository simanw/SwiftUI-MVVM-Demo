//
//  EmployeeListViewModelTests.swift
//  EmployeeListTests
//
//  Created by Wang Siman on 2/3/21.
//  Copyright © 2021 None. All rights reserved.
//
import Foundation
import XCTest
import Combine
@testable import EmployeeList

class EmployeeListViewModelTests: XCTestCase {
    
    func test_updateEmployeeListWhenOnAppear() {
        
        let mockEmployeesService = MockEmployeesService()
        
        mockEmployeesService.stub(for: EmployeeListRequest.self, response: { _ in
            Result.Publisher(
                EmployeeListResponse(employees: [
                    .init(id: UUID(uuidString: "B6DEA526-C571-4D43-8B41-375CA5CD9FDB")!,
                    fullName: "Elisa Rizzo",
                    phoneNumber: "123456789",
                    emailAddress: "erizzo.demo@squareup.com",
                    biography: Optional("iOS Engineer on the Restaurants team."),
                    photoUrlSmall:  "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
                    photoUrlLarge: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",
                    team: "Operations",
                    employeeType: EmployeeType.FULL_TIME)
                ])
            ).eraseToAnyPublisher()
            
        })
        
        let viewModel = EmployeeListViewModel(employeesService: mockEmployeesService)
        viewModel.update()
        XCTAssertTrue(!viewModel.sortedTeams.isEmpty)
    }
    
    func test_emptyEmployeeListForEmptyJson() {
        let mockEmployeesService = MockEmployeesService()
        mockEmployeesService.stub(for: EmployeeListRequest.self, response: { _ in
            Result.Publisher(
                EmployeeListResponse(employees: [])
            ).eraseToAnyPublisher()
            
        })
        let viewModel = EmployeeListViewModel(employeesService: mockEmployeesService)
        
        viewModel.update()
        XCTAssertTrue(viewModel.sortedTeams.isEmpty)
    }
    
    func test_throwParseErrorForMalformedJson() {
        let mockEmployeesService = MockEmployeesService()
        
        let viewModel = EmployeeListViewModel(employeesService: mockEmployeesService)
        
        mockEmployeesService.stub(for: EmployeeListRequest.self, response: { _ in
            Result.Publisher(
                APIServiceError.parseError
            ).eraseToAnyPublisher()
        })
        
        viewModel.update()
        XCTAssertEqual(viewModel.errorMessage, APIServiceError.parseError.errorDescription)
    }
}
