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
        // We need to return a row wrapped up in a navigation button to allow user to tap on it
        // Then trigger a destination for that button
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
            .navigationBarTitle(Text("Employees"), displayMode: .inline)
        }
        .onAppear(perform: {self.employeeListViewModel.update()})
        //.onAppear(perform: {self.employeeListViewModel.objectWillChange.send()})
    }
}

struct EmployeeListView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListView(employeeListViewModel: .init())
    }
}
