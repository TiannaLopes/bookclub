import SwiftUI

enum NavigationDestination {
    case bookClubForm
}

struct BookClubFeedView: View {
    @StateObject private var bookClubViewModel = BookClubViewModel()
    @State private var navigationSelection: NavigationDestination?

    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let offWhite = Color(hex: "FDFDFD")

    var body: some View {
        NavigationStack {
            ZStack {
                oliveGreen.edgesIgnoringSafeArea(.all)
                VStack {
                    Button("Create Bookclub") {
                        navigationSelection = .bookClubForm
                    }
                    .font(.headline)
                    .foregroundColor(darkMaroon)
                    .padding()
                    .background(paleYellow)
                    .cornerRadius(15.0)
                    .padding(.top)

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
            .navigationDestination(for: NavigationDestination.self) { destination in
                        switch destination {
                            case .bookClubForm:
                                BookClubFormView(bookClubViewModel: bookClubViewModel)
                        }
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

