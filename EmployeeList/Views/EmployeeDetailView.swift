//
//  EmployeeDetailView.swift
//  EmployeeList
//
//  Created by Wang Siman on 3/6/21.
//  Copyright © 2021 None. All rights reserved.
//

import SwiftUI

struct EmployeeDetailView: View {
    @Environment(\.editMode) var mode
    @State var employee: Employee
    @State var draftProfile  = testEmployee
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if self.mode?.wrappedValue == .active {
                    Button("Cancel") {
                        self.draftProfile = self.employee
                        self.mode?.animation().wrappedValue = .inactive
                    }
                }
                
                Spacer()
                
                EditButton()
            }                        
            if self.mode?.wrappedValue == .inactive {
                EmployeeProfile(employee: $employee)
            } else {
                EmployeeProfileEditor(employee: $draftProfile)
                    .onAppear {
                        self.draftProfile = self.employee
                    }
                    .onDisappear {
                        self.employee = self.draftProfile
                    }
            }
        }
        .padding()
    }
}

struct EmployeeDetailView_Previews: PreviewProvider {
    //@State static var employee = testEmployee
    static var previews: some View {
        EmployeeDetailView(employee: testEmployee)
    }
}
