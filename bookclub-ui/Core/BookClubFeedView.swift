
import SwiftUI

struct BookClubFeedView: View {
    @State private var showingBookClubForm = false

    private let bookClubs =       [
        BookClub(id:" 1", name: "Morning Readers", description: "Join us for a lively morning discussion.", owner: "Snoop dawg", nextMeetingDate: Date().addingTimeInterval(86400 * 7)), // 7 days from now
        BookClub(id: "2", name: "Sci-Fi Enthusiasts", description: "Exploring the universe, one book at a time.",owner: "Test", nextMeetingDate: Date().addingTimeInterval(86400 * 14)), // 14 days from now
    ]
    
    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let offWhite = Color(hex: "FDFDFD")
    
    var body: some View {
        
        ZStack {
            oliveGreen.edgesIgnoringSafeArea(.all)
            VStack {
                               Button("Create Bookclub") {
                                   showingBookClubForm = true
                               }
                               .font(.headline)
                               .foregroundColor(darkMaroon)
                               .padding()
                               .background(paleYellow)
                               .cornerRadius(15.0)
                               .padding(.top)

                               NavigationLink(destination: BookClubFormView(), isActive: $showingBookClubForm) {
                                   EmptyView()
                               }
                List {
                    ForEach(bookClubs) { bookClub in
                        NavigationLink(destination: BookClubDetailView(bookClub: bookClub)) {
                            BookClubRowView(club: bookClub)
                                .padding()
                                .background(offWhite)
                                .cornerRadius(5.0)
                        }
                    }
                }
                .padding()
                .background(tan.opacity(0.8)) // Semi-transparent tan background for the list
                .cornerRadius(10)
            }
        }
    }
}
