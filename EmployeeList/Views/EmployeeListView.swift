//
//  EmployeeListView.swift
//  EmployeeList
//
//  Created by Wang Siman on 1/29/21.
//  Copyright © 2021 None. All rights reserved.
//

import SwiftUI

struct EmployeeListView: View {
    @ObservedObject private(set) var employeeListViewModel: EmployeeListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(employeeListViewModel.sortedTeams, id: \.name) { team in
                    Section(header: Text(team.name)) {
                        ForEach(team.employees, id: \.id) { employee in
                            EmployeeListRow(employee: employee)
                        }
                    }
                }
            }
            .alert(isPresented: $employeeListViewModel.isErrorShown, content: { () -> Alert in
                Alert(title: Text("Error"), message: Text(employeeListViewModel.errorMessage))
            })
            .navigationBarTitle(Text("Employees"))                
        }
        .onAppear(perform: {self.employeeListViewModel.update()})
    }
}

struct EmployeeListView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListView(employeeListViewModel: .init())
    }
}
