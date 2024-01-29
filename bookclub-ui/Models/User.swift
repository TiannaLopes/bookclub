//
//  User.swift
//  bookclub-ui
//
//  Created by Tianna Alina Lopes on 1/10/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var firstName: String
    var lastName: String
    var email: String
    var joinedBookclubs: [String]?  // Make this optional

    var initials: String {
        let firstInitial = firstName.first.map { String($0) } ?? ""
        let lastInitial = lastName.first.map { String($0) } ?? ""
        return firstInitial + lastInitial
    }
}


extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, firstName:"Patrick", lastName:"Kane", email: "name@gmail.com")
}
