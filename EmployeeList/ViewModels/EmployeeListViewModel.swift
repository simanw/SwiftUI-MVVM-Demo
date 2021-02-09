//
//  EmployeeListViewModel.swift
//  EmployeeList
//
//  Created by Wang Siman on 1/29/21.
//  Copyright © 2021 None. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class EmployeeListViewModel: ObservableObject {
    private var cancellables: [AnyCancellable] = []
    
    private let onAppearSubject = PassthroughSubject<Void, Error>()
    
    private let employeesService: APIServiceType
    
    // Publish values on-demand by calling the send() method
    func update() {
        onAppearSubject.send(())
    }
    
    private var employees: [Employee] = []
    
    @Published var sortedTeams: [Team] = []
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    init(employeesService: APIServiceType = EmployeesAPIService()) {
        self.employeesService = employeesService
        
        fetchEmployeeList()
        print("------- employee list view model init done ---------")
    }
    
    private func fetchEmployeeList() {
        
        let endpoint = EmployeeListRequest(path: "employees.json")
        let publisher = onAppearSubject.flatMap { _ -> AnyPublisher<EmployeeListResponse, Error> in
            return self.employeesService.call(from: endpoint)
        }
        
        let employeesStream = publisher
            .map { $0.employees }
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error): do {
                    self.errorMessage = error.localizedDescription
                    self.isErrorShown = true;
                    }
                case .finished:
                    break
                }
                
            }, receiveValue: { (employees) in
                self.employees = employees
                self.groupEmployeesByTeam()
            })
        
        cancellables += [
            employeesStream
        ]
    }
}

extension EmployeeListViewModel {
        
    private func groupEmployeesByTeam() {
        var buckets: [String: Team] = [:]
        var teams: [Team] = []
        for employee in self.employees {
            if var team = buckets[employee.team] {
                team.employees.append(employee)
            } else {
                var team = Team(name: employee.team)
                team.employees.append(employee)
                buckets[employee.team] = team
                teams.append(team)
            }
        }
        self.sortedTeams = teams.sorted { (lhs, rhs) -> Bool in
            return lhs.name < rhs.name
        }
    }
}
