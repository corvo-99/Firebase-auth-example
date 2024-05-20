//
//  AuthViewModel.swift
//  login singup
//
//  Created by Dylan Corvo on 08/04/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import GoogleSignIn
import GoogleSignInSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
       
    
    func signOut() async throws {
        do {
            try Auth.auth().signOut() //backend signout
            self.userSession = nil //erases userSession and takes app back to login screen
            self.currentUser = nil //wipes out currentUser data model
        } catch {
            print("DEBUG: failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async {
        //TODO: Add logic to delete acc.
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("DEBUG: No authenticated user")
            return
        }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        print("DEBUG: \(String(describing: self.currentUser))")
    }
}

//MARK: Sign in email

extension AuthViewModel {
    
    func signIn(withemail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: failed to sign in with error: \(error.localizedDescription)")
        }
    }
    
    func createUser(withemail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email, photoUrl: result.user.photoURL?.absoluteString)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("Catch faild to create user with error: \(error.localizedDescription)")
        }
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.notConnectedToInternet)
        }
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.notConnectedToInternet)
        }
        try await user.updateEmail(to: email)
    }
}

//MARK: Sign in Google
//extension AuthViewModel {
//    func signInWithGoogle() async -> Bool {
//        guard let clientID = FirebaseApp.app()?.options.clientID else {
//            fatalError("Client ID not found in Firebase configuration")
//        }
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//        
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let window = windowScene.windows.first,
//              let rootViewController = window.rootViewController else {
//            print("There's no root view controller")
//            return false
//        }
//        
//        do {
//            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
//            let user = userAuthentication.user
//            let idToken = user.idToken
//            let accessToken = user.accessToken
//            let credentials = GoogleAuthProvider.credential(withIDToken: idToken!.tokenString,
//                                                            accessToken: accessToken.tokenString)
//            let result = try await Auth.auth().signIn(with: credentials)
//            let User = result.user
//            userSession = result.user
//            print("User: \(User.uid) sign in with email \(User.email ?? "unknown")")
//            return true
//        } catch {
//            print(error.localizedDescription)
//            return false
//        }
//        
//    }
//}
