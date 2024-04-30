//
//  User.swift
//  login singup
//
//  Created by Dylan Corvo on 08/04/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String?
    let email: String?
    let photoUrl: String?
    
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname ?? "") {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        } else { return "" }
    }
}

extension User {
    static let FAKE_USER = User(id: NSUUID().uuidString, fullname: "Dylan Corvo", email: "example@gmail.com", photoUrl: nil)
}
