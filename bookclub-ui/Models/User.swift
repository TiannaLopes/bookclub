//
//  User.swift
//  bookclub-ui
//
//  Created by Tianna Alina Lopes on 1/10/24.
//

struct User: Identifiable {
    let id: Int
    var username: String
    var email: String
    var favoriteBook: String
    var bio: String
    
    // Mock data for the current user
    static var currentUser: User {
        User(id: 1, username: "JaneDoe", email: "jane.doe@example.com", favoriteBook: "Pride and Prejudice", bio: "Avid reader and coffee enthusiast")
    }
}
