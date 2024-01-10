
import SwiftUI

struct BookClubFeedView: View {
    @State private var bookClubs: [BookClub] = BookClub.mockData
    @State private var isFetchingMore = false
    
    // Define your color palette
    let background = Color(hex: "C9D3BE")
    let textColor = Color(hex: "3D0814")
    let buttonColor = Color(hex: "442F38")
    // Off-white color for the text fields
    let offWhite = Color(hex: "FDFDFD")
    
    var body: some View {
        NavigationView {
            ZStack {
                background.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(bookClubs) { club in
                            BookClubRowView(club: club)
                                .onAppear {
                                    if bookClubs.last?.id == club.id {
                                        loadMoreContent()
                                    }
                                }
                        }
                        if isFetchingMore {
                            ProgressView()
                                .scaleEffect(1.5, anchor: .center)
                                .progressViewStyle(CircularProgressViewStyle(tint: buttonColor))
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Book Club Feed", displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                // Action for navigation bar button
            }) {
                Image(systemName: "plus")
                    .foregroundColor(textColor)
            })
        }
    }
    
    func loadMoreContent() {
        // Your pagination logic would go here
    }
}

// Preview provider
struct BookClubFeedView_Previews: PreviewProvider {
    static var previews: some View {
        BookClubFeedView()
    }
}
