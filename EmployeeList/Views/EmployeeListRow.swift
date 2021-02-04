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
        HStack {
            CustomImageView(customImageViewModel: .init(imageURL: employee.photoUrlSmall!))
            Text(employee.fullName)
            Spacer()
            Text(employee.team)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

struct EmployeeListRow_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListRow(employee:
            Employee(
                id: UUID(uuidString: "B6DEA526-C571-4D43-8B41-375CA5CD9FDB")!,
                fullName: "Elisa Rizzo",
                phoneNumber: "123456789",
                emailAddress: "erizzo.demo@squareup.com",
                biography: Optional("iOS Engineer on the Restaurants team."),
                photoUrlSmall:  "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
                photoUrlLarge: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",
                team: "Operations",
                employeeType: EmployeeType.FULL_TIME)
        )
    }
}
