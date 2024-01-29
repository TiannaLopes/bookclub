import SwiftUI

struct BookClubFeedView: View {
    @StateObject private var bookClubViewModel = BookClubViewModel()
    @State private var showingBookClubForm = false // Use a simple Boolean flag for navigation

    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let offWhite = Color(hex: "FDFDFD")

    var body: some View {
        NavigationStack { // Using NavigationStack for SwiftUI 3.0 and above. Use NavigationView for earlier versions
            ZStack {
                oliveGreen.edgesIgnoringSafeArea(.all)
                VStack {
                    // Button to trigger navigation to the book club form
                    Button("Create Bookclub") {
                        showingBookClubForm = true // Toggle the flag to show the form
                    }
                    .font(.headline)
                    .foregroundColor(darkMaroon)
                    .padding()
                    .background(paleYellow)
                    .cornerRadius(15.0)
                    .padding(.top)

                    // List of book clubs
                    List {
                        ForEach(bookClubViewModel.bookClubs) { bookClub in
                            NavigationLink(destination: BookClubDetailView(bookClub: bookClub, bookClubViewModel: bookClubViewModel)) {
                                BookClubRowView(club: bookClub)
                                    .padding()
                                    .background(offWhite)
                                    .cornerRadius(5.0)
                            }
                        }
                    }
                    .padding()
                    .background(tan.opacity(0.8))
                    .cornerRadius(10)
                }
            }
            // This NavigationLink becomes active when showingBookClubForm is true
            .navigationDestination(isPresented: $showingBookClubForm) {
                BookClubFormView(bookClubViewModel: bookClubViewModel)
            }
            .onAppear {
                Task {
                    await bookClubViewModel.fetchAllBookClubs()
                }
            }
        }
        .navigationTitle("Book Clubs")
    }
}


extension BookClubFeedView {
    static var previews: some View {
        BookClubFeedView()
    }
}

