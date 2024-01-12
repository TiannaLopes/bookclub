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
        //        self.userSession = Auth.auth().currentUser
        //
        //        Task {
        //            await fetchUser()
        //        }
    }
    
    func createBookClub( name:String, bookName: String, Location: String, Date: Date, owner: String)async throws{
        print("creating book club")
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
    
    func getBookClubDetails(bookclubId: String){
        print("get book club details")
    }
}
