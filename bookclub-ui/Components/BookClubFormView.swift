import SwiftUI
import FirebaseFirestoreSwift 

struct BookClubFormView: View {
    @StateObject private var bookClubViewModel = BookClubViewModel()  

    @State private var name: String = ""
    @State private var description: String = ""
    @State private var nextMeetingDate: Date = Date()  // Default to current date
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Club Details")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    DatePicker("Next Meeting Date", selection: $nextMeetingDate, displayedComponents: .date)
                }

                Section {
                    Button("Create Book Club") {
                        Task {
                            do {
                                // Assuming 'owner' is the current user's ID, replace with appropriate value
                                let ownerId = bookClubViewModel.currentUser?.id ?? "Unknown"
                                try await bookClubViewModel.createBookClub(name: name, description: description, nextMeetingDate: nextMeetingDate, owner: ownerId)
                                dismiss()  // Dismiss the form upon success
                            } catch {
                                print("Error creating book club: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("New Book Club", displayMode: .inline)
        }
    }
}
