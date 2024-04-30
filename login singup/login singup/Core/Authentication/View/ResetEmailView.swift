//
//  ResetEmailView.swift
//  login singup
//
//  Created by Dylan Corvo on 11/04/24.
//

import SwiftUI

struct ResetEmailView: View {
    @Binding var email: String
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dissmiss
    @State var newEmail = ""
    var body: some View {
        NavigationStack {
            VStack {
                //image
                Image("userlogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                //form
                VStack {
                    InputView(text: $email,
                              title: "Current email",
                              placeholder: "name@example.com")
                        .textInputAutocapitalization(.none)
                    InputView(text: $newEmail,
                              title: "New email account",
                              placeholder: "name@example.com")
                        .textInputAutocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //resetPass button
                ButtonActionLabel(action:{
                    Task{
//                        try await viewModel.updateEmail(email: newEmail)
                        dissmiss()
                        print("Email reset")
                    }
                },
                                  title: "Update Email",
                                  imageSFSymbol: "arrow.right")
                .padding(.top, 24)
            }
            Spacer()
        }
    }
}

#Preview {
    ResetEmailView(email: .constant(""))
}
