import SwiftUI
import FirebaseFirestoreSwift 

struct BookClubFormView: View {
    @StateObject private var bookClubViewModel = BookClubViewModel()  

    @State private var name: String = ""
    @State private var description: String = ""
    @State private var nextMeetingDate: Date = Date()
    @Environment(\.dismiss) var dismiss
    
    private var bookClubId: String?
    private var isEditMode: Bool
    
      init(bookClub: BookClub? = nil) {
          _name = State(initialValue: bookClub?.name ?? "")
          _description = State(initialValue: bookClub?.description ?? "")
          _nextMeetingDate = State(initialValue: bookClub?.nextMeetingDate ?? Date())
          bookClubId = bookClub?.id
          isEditMode = (bookClub != nil)
      }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Club Details")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    DatePicker("Next Meeting Date", selection: $nextMeetingDate, displayedComponents: .date)
                }

                Section {
                    Button(isEditMode ? "Save Changes" : "Create Book Club") {
                        Task {
                            if isEditMode {
                                do {
                                    // Assuming 'owner' is the current user's ID, replace with appropriate value
                                    let ownerId = bookClubViewModel.currentUser?.id ?? "Unknown"
                                    try await bookClubViewModel.createBookClub(name: name, description: description, nextMeetingDate: nextMeetingDate, owner: ownerId)
                                    dismiss()  // Dismiss the form upon success
                                } catch {
                                    print("Error creating book club: \(error.localizedDescription)")
                                }
                            }else{
                                do {
                                                         if isEditMode {
                                                             let newDetails: [String: Any] = [
                                                                 "name": name,
                                                                 "description": description,
                                                                 "nextMeetingDate": nextMeetingDate
                                                             ]
                                                             if let bookClubId = bookClubId {
                                                                 try await bookClubViewModel.updateBookClub(bookClubId: bookClubId, newDetails: newDetails)
                                                             }
                                                         } else {
                                                             // Code to create a new book club
                                                         }
                                                         dismiss()
                                } catch {
                                    print("Error: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                }
            }
                .navigationBarTitle(isEditMode ? "Edit Book Club" : "New Book Club", displayMode: .inline)
        }
    }
}
