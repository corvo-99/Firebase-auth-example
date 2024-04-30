//
//  LoginView.swift
//  login singup
//
//  Created by Dylan Corvo on 07/04/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationStack{
            VStack{
                //image
                Image("userlogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                //form
                VStack(spacing: 24){
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                        .textInputAutocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                        .textInputAutocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //forgot password
                HStack {
                    NavigationLink {
                        ResetPasswordView(email: $email)
                            .navigationBarBackButtonHidden()
                    } label: {
                            Text("Forgot your password?")
                                .tint(.orange)
                                .fontWeight(.semibold)
                    }.padding(.horizontal)
                    Spacer()
                }
                
                
                //sign in button
                
                ButtonActionLabel(action:{
                    Task{
                         try await viewModel.signIn(withemail: email, password: password)
                    }
                },
                                  title: "SIGN IN",
                                  imageSFSymbol: "arrow.right")
                .padding(.top, 24)
                .invalidatableContent(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
//                Button {
//                    Task {
//                             await viewModel.signInWithGoogle()
//                        }
//                } label: {
//                    Text("google")
//                }

                

                Spacer()

                //sign up button
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3){
                        Text("Don't have an account?")
                            .tint(.orange)
                        Text("Sign up")
                            .tint(.orange)
                            .fontWeight(.bold)
                    }
                }
            }
        }.onTapGesture {
            // Dismiss keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginView()
}
