//
//  BookClubsViewModel.swift
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
class BookClubsViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
    }
    
    func getListOfBookClubsUserHasJoined(){
        print("get joined book club list")
    }
    func getListOfAllBookClubs(){
        print("get list of all bookclubs")
    }
}
