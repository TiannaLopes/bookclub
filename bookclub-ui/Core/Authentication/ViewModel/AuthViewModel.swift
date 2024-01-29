//
//  AuthViewModel.swift
//  bookclub-ui
//
//  Created by Tianna Alina Lopes on 1/11/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol{
    var formIsValid: Bool{get}
}

@MainActor
class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email:String, password:String )async throws{
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }catch{
            print("Failed to log in with error: \(error.localizedDescription)")
        }
        }
    
    func createUser(withEmail email:String, password:String, firstName: String, lastName: String )async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, firstName: firstName, lastName: lastName, email:email)
             let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        }catch{
            print("Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut() // signs out user on backend
            self.userSession = nil // clears session
            self.currentUser = nil // clears current user data model
        }catch{
            print("Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    func deleteAccount(){
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        do {
            let documentSnapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            let user = try documentSnapshot.data(as: User.self)  // No need for 'guard let' here
            DispatchQueue.main.async {
                self.currentUser = user
            }
            print("Current user is: \(user)")
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
        }
    }

}
