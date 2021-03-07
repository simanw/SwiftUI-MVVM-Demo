//
//  ProfileSummary.swift
//  EmployeeList
//
//  Created by Wang Siman on 3/6/21.
//  Copyright © 2021 None. All rights reserved.
//

import SwiftUI

struct EmployeeProfile: View {
    @Binding var employee: Employee
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text(employee.fullName)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                CustomImageView(customImageViewModel: .init(imageURL: employee.photoUrlSmall!))
                    .frame(width: 200, height: 200)
                    .cornerRadius(100)
                
            }
            
            VStack {
                Divider()
                VStack(alignment: .leading, spacing: 10) {
                    Text("Contact")
                        .frame(width: 80, height: 1, alignment: .leading)
                    HStack {
                        Text(employee.phoneNumber!)
                        Spacer()
                        Text(employee.emailAddress)
                    }
                    .foregroundColor(.gray)
                    
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Team")
                        .frame(width: 80, height: 1, alignment: .leading)
                    HStack {
                        Text(employee.team)
                        Spacer()
                        Text(employee.employeeType.rawValue)
                    }
                    .foregroundColor(.gray)
                }
                .padding()
                
                Divider()
                
                Text(employee.biography!)
                    .frame( alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .offset(x: 0, y: 20)
            }
            .offset(x: 0, y: 80)
        }
        .padding(.bottom)

    }
}

struct EmployeeProfile_Previews: PreviewProvider {
    @State static var employee = testEmployee
    static var previews: some View {
        EmployeeProfile(employee: $employee)
    }
}
