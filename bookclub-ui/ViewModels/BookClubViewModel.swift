//
//  BookClubViewModel.swift
//  bookclub-ui
//
//  Created by Tianna Alina Lopes on 1/12/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

//protocol AuthenticationFormProtocol{
//    var formIsValid: Bool{get}
//}

@MainActor
class BookClubViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
//                Task {
//                    await fetchBookClub()
//                }
    }
    
        func createBookClub(name: String, description: String, nextMeetingDate: Date, owner: String) async throws {
            let newBookClub = BookClub(id: UUID().uuidString,
                                       name: name,
                                       description: description,
                                       owner: owner,
                                       nextMeetingDate: nextMeetingDate)

  do {
            let encodedBookClub = try Firestore.Encoder().encode(newBookClub)
            try await Firestore.firestore().collection("bookclubs").document(newBookClub.id).setData(encodedBookClub)
            print("Book club created successfully")
        } catch {
            print("Failed to create book club with error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func deleteBookClub(){
        print("delete book club")
    }
    
    func updateBookClub(){
        print("delete book club")
    }
    
    func joinBookClub(){
        print("join book club")
        
    }
    func leaveBookClub(){
        print("leave book club")
    }
    
    func fetchBookClub(){
        print("get book club details")
    }
}
