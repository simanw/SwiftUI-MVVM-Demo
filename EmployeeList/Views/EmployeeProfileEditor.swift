//
//  ProfileEditor.swift
//  EmployeeList
//
//  Created by Wang Siman on 3/6/21.
//  Copyright © 2021 None. All rights reserved.
//

import SwiftUI

struct EmployeeProfileEditor: View {
    @Binding var employee: Employee
    
    var body: some View {
        List {
            HStack {
                Text("Fullname").bold()
                Divider()
                TextField("Fullname", text: $employee.fullName)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Employeement type").bold()
                
                Picker("Seasonal Photo", selection: $employee.employeeType) {
                    ForEach(EmployeeType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.top)
        }
    }
}

struct EmployeeProfileEditor_Previews: PreviewProvider {
    @State static var em = testEmployee
    static var previews: some View {
        EmployeeProfileEditor(employee: $em)
    }
}
