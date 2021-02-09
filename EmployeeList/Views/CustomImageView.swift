//
//  CustomImageView.swift
//  EmployeeList
//
//  Created by Wang Siman on 1/31/21.
//  Copyright © 2021 None. All rights reserved.
//

import SwiftUI
import Combine

struct CustomImageView: View {

    @ObservedObject private(set) var customImageViewModel: CustomImageViewModel
    
    var body: some View {
        content
            .alert(isPresented: $customImageViewModel.isErrorShown, content: { () -> Alert in
                Alert(title: Text("Error"), message: Text(self.customImageViewModel.errorMessage))
            })
            .onAppear(perform: { self.customImageViewModel.update() })
    }

    private var content: AnyView {
        return AnyView(Image(uiImage: self.customImageViewModel.image)
            .resizable()
            .frame(width: 50, height: 50)
            .cornerRadius(25))
    }
}

struct CustomImageView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageView(customImageViewModel: .init(imageURL: "https://s3.amazonaws.com/sq-mobile-interview/photos/5095a907-abc9-4734-8d1e-0eeb2506bfa8/small.jpg"))
    }
}
