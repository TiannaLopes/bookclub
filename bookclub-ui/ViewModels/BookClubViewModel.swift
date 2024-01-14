//
//  BookClubViewModel.swift
//  bookclub-ui
//
//  Created by Tianna Alina Lopes on 1/12/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class BookClubViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?

    // Create a book club
    func createBookClub(name: String, description: String, nextMeetingDate: Date, owner: String) async throws {
        let newBookClub = BookClub(id: UUID().uuidString, name: name, description: description, owner: owner, nextMeetingDate: nextMeetingDate)

        do {
            let encodedBookClub = try Firestore.Encoder().encode(newBookClub)
            try await Firestore.firestore().collection("bookclubs").document(newBookClub.id).setData(encodedBookClub)
            print("Book club created successfully")
        } catch {
            print("Failed to create book club with error: \(error.localizedDescription)")
            throw error
        }
    }
    
    // Delete a book club
    func deleteBookClub(bookClubId: String) async throws {
        do {
            try await Firestore.firestore().collection("bookclubs").document(bookClubId).delete()
            print("Book club deleted successfully")
        } catch {
            print("Failed to delete book club with error: \(error.localizedDescription)")
            throw error
        }
    }
    
    // Update book club details
    func updateBookClub(bookClubId: String, newDetails: [String: Any]) async throws {
        do {
            try await Firestore.firestore().collection("bookclubs").document(bookClubId).updateData(newDetails)
            print("Book club updated successfully")
        } catch {
            print("Failed to update book club with error: \(error.localizedDescription)")
            throw error
        }
    }
    
    // Join a book club
    func joinBookClub(bookClubId: String) async throws {
        guard let userId = currentUser?.id else { return }

        // Add user to the attendees list of the book club
        let attendeesUpdate = FieldValue.arrayUnion([userId])
        do {
            try await Firestore.firestore().collection("bookclubs").document(bookClubId).updateData(["attendees": attendeesUpdate])
            print("Joined book club successfully")
        } catch {
            print("Failed to join book club with error: \(error.localizedDescription)")
            throw error
        }
    }
    
    // Leave a book club
    func
leaveBookClub(bookClubId: String) async throws {
guard let userId = currentUser?.id else { return }
    // Remove user from the attendees list of the book club
    let attendeesUpdate = FieldValue.arrayRemove([userId])
    do {
        try await Firestore.firestore().collection("bookclubs").document(bookClubId).updateData(["attendees": attendeesUpdate])
        print("Left book club successfully")
    } catch {
        print("Failed to leave book club with error: \(error.localizedDescription)")
        throw error
    }
}

    
    // Fetch details of a specific book club
    func fetchBookClub(bookClubId: String) async throws -> BookClub? {
        let document = try await Firestore.firestore().collection("bookclubs").document(bookClubId).getDocument()
        let bookClub = try document.data(as: BookClub.self)
        return bookClub
    }
    // Get list of book clubs the user has joined
    func getListOfBookClubsUserHasJoined() async throws -> [BookClub] {
        guard let userId = currentUser?.id else { return [] }

        let querySnapshot = try await Firestore.firestore().collection("bookclubs")
            .whereField("attendees", arrayContains: userId)
            .getDocuments()
        let bookClubs = querySnapshot.documents.compactMap { document -> BookClub? in
            try? document.data(as: BookClub.self)
        }
        return bookClubs
    }

    // Get list of all book clubs
    func getListOfAllBookClubs() async throws -> [BookClub] {
        let querySnapshot = try await Firestore.firestore().collection("bookclubs").getDocuments()
        let bookClubs = querySnapshot.documents.compactMap { document -> BookClub? in
            try? document.data(as: BookClub.self)
        }
        return bookClubs
    }
}
