//
//  ContentView.swift
//  login singup
//
//  Created by Dylan Corvo on 07/04/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group{
            if viewModel.userSession != nil {
                WeatherMainView()
                //                ProfileView(email: .constant(""))
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
