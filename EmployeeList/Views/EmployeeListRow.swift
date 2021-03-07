//
//  EmployeeListRow.swift
//  EmployeeList
//
//  Created by Wang Siman on 1/29/21.
//  Copyright © 2021 None. All rights reserved.
//

import SwiftUI
import UIKit

struct EmployeeListRow: View {
    @State var employee: Employee

    var body: some View {
        NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                HStack {
                    CustomImageView(customImageViewModel: .init(imageURL: employee.photoUrlSmall!))
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                    Text(employee.fullName)
                    Spacer()
                    Text(employee.team)
                        .foregroundColor(.gray)
                }
                .padding()
            }
        
    }
}

struct EmployeeListRow_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListRow(employee:
            testEmployee
        )
    }
}
