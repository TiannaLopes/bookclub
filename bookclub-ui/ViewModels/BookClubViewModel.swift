import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class BookClubViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var bookClubs: [BookClub] = []
    @Published var myBookClubs: [BookClub] = []

    init() {
        self.userSession = Auth.auth().currentUser
        fetchUser()
    }

    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let ref = Firestore.firestore().collection("users").document(userId)
        ref.getDocument { (document, error) in
            if let document = document, document.exists {
                self.currentUser = try? document.data(as: User.self)
            }
        }
    }

    func createBookClub(name: String, description: String, nextMeetingDate: Date, owner: String, locationName: String, latitude: Double, longitude: Double) async throws {
        let newBookClub = BookClub(
            id: UUID().uuidString,
            name: name,
            description: description,
            owner: owner,
            nextMeetingDate: nextMeetingDate,
            locationName: locationName,
            latitude: latitude,
            longitude: longitude
        )

        do {
            let encodedBookClub = try Firestore.Encoder().encode(newBookClub)
            try await Firestore.firestore().collection("bookclubs").document(newBookClub.id).setData(encodedBookClub)
        } catch {
            throw error
        }
    }

    func deleteBookClub(bookClubId: String) async throws {
        do {
            try await Firestore.firestore().collection("bookclubs").document(bookClubId).delete()
        } catch {
            throw error
        }
    }

    func updateBookClub(bookClubId: String, newDetails: [String: Any]) async throws {
        do {
            try await Firestore.firestore().collection("bookclubs").document(bookClubId).updateData(newDetails)
        } catch {
            throw error
        }
    }

    func joinBookClub(bookClubId: String, userId: String) async throws {
        guard let userId = self.currentUser?.id else { return }
        let userRef = Firestore.firestore().collection("users").document(userId)
        do {
            _ = try await Firestore.firestore().runTransaction { transaction, errorPointer -> Any? in
                let userDocument: DocumentSnapshot
                do {
                    userDocument = try transaction.getDocument(userRef)
                } catch let fetchError as NSError {
                    errorPointer?.pointee = fetchError
                    return nil
                }

                var joinedBookclubs = userDocument.data()?["joinedBookclubs"] as? [String] ?? []
                if !joinedBookclubs.contains(bookClubId) {
                    joinedBookclubs.append(bookClubId)
                    transaction.updateData(["joinedBookclubs": joinedBookclubs], forDocument: userRef)
                }

                return nil
            }
        } catch {
            print("Error joining book club: \(error.localizedDescription)")
            throw error
        }
    }



    func leaveBookClub(bookClubId: String) async throws {
        guard let userId = currentUser?.id else { return }
        let attendeesUpdate = FieldValue.arrayRemove([userId])
        do {
            try await Firestore.firestore().collection("bookclubs").document(bookClubId).updateData(["attendees": attendeesUpdate])
        } catch {
            throw error
        }
    }

    func fetchBookClub(bookClubId: String, completion: @escaping (BookClub?) -> Void) {
        let ref = Firestore.firestore().collection("bookclubs").document(bookClubId)
        ref.getDocument { (document, error) in
            if let document = document, document.exists {
                let bookClub = try? document.data(as: BookClub.self)
                completion(bookClub)
            } else {
                completion(nil)
            }
        }
    }

    func fetchAllBookClubs() async {
        let querySnapshot = try? await Firestore.firestore().collection("bookclubs").getDocuments()
        self.bookClubs = querySnapshot?.documents.compactMap { try? $0.data(as: BookClub.self) } ?? []
    }

    func fetchMyBookClubs() async {
        guard let userId = currentUser?.id else { return }

        do {
            let userDocument = try await Firestore.firestore().collection("users").document(userId).getDocument()
            if let user = try? userDocument.data(as: User.self) {
                // Safely unwrap `joinedBookclubs` or provide an empty array as a fallback
                let bookClubIds = user.joinedBookclubs ?? []

                var bookClubs: [BookClub] = []
                for id in bookClubIds {
                    let bookClubDocument = try await Firestore.firestore().collection("bookclubs").document(id).getDocument()
                    if let bookClub = try? bookClubDocument.data(as: BookClub.self) {
                        bookClubs.append(bookClub)
                    }
                }

                DispatchQueue.main.async {
                    self.myBookClubs = bookClubs
                }
            }
        } catch {
            print("Error fetching my book clubs: \(error.localizedDescription)")
        }
    }



}
