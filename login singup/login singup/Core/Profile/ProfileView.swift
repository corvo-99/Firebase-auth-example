//
//  ProfileView.swift
//  login singup
//
//  Created by Dylan Corvo on 08/04/24.
//

import SwiftUI

struct ProfileView: View {
    @Binding var email: String
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section{
                    HStack{
                            Circle()
                                .foregroundStyle(Color.gray)
                                .frame(width: 72, height: 72)
                                .overlay {
                                    Text(user.photoUrl ?? user.initials)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color(.white))
                                }
                        VStack(alignment: .leading, spacing: 4){
                            Text(user.fullname ?? "")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text(user.email!)
                                .foregroundStyle(Color.gray)
                                .font(.footnote)
                        }
                    }
                }
                Section("general"){
                    SettingsRowView(imageName: "gear",
                                    title: "Version",
                                    textRight: "0.1",
                                    textRightColor: Color(.gray),
                                    tintColor: Color(.gray))
                }
                Section("Account"){
                    Button(action: {
                        Task{
                            try await viewModel.signOut()
                        }
                    }) {
                        SettingsRowView(imageName: "arrow.left.circle.fill",
                                        title: "Sign out",
                                        textRight: "",
                                        textRightColor: Color.gray,
                                        tintColor: Color.red)
                        .tint(Color.primary)
                    }
                    Button(action: {
                        Task{
                            ResetEmailView(email: $email)
                        }
                    }) {
                        SettingsRowView(imageName: "arrow.left.circle.fill",
                                        title: "Update email",
                                        textRight: "",
                                        textRightColor: Color.gray,
                                        tintColor: Color.red)
                        .tint(Color.primary)
                    }
                    Button(action: {
                        print("Deleting Acc")
                    }) {
                        SettingsRowView(imageName: "cross.circle.fill",
                                        title: "Delete account",
                                        textRight: "",
                                        textRightColor: Color.gray,
                                        tintColor: Color.red)
                        .tint(Color.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView(email: .constant("")).environmentObject(AuthViewModel())
}

//extension to allow swipeGesture in a navigationStack with the NavigationBar hidden

//extension UINavigationController: UIGestureRecognizerDelegate {
//    override open func viewDidLoad() {
//        super.viewDidLoad()
//        interactivePopGestureRecognizer?.delegate = self
//    }
//
//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return viewControllers.count > 1
//    }
//}
