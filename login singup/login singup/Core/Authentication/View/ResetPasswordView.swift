//
//  ResetPasswordView.swift
//  login singup
//
//  Created by Dylan Corvo on 11/04/24.
//

import SwiftUI

struct ResetPasswordView: View {
    @Binding var email: String
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dissmiss
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
                              title: "Write your email",
                              placeholder: "name@example.com")
                        .textInputAutocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //resetPass button
                ButtonActionLabel(action:{
                    Task{
                        try await viewModel.resetPassword(email: email)
                        dissmiss()
                        print("password reset")
                    }
                },
                                  title: "Reset Password",
                                  imageSFSymbol: "arrow.right")
                .padding(.top, 24)
            }
            Spacer()
        }
    }
}

#Preview {
    ResetPasswordView(email: .constant(""))
}
