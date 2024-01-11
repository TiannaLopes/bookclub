import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            TabView {
                BookClubFeedView()
                    .tabItem {
                        Label("Feed", systemImage: "book.fill")
                    }

                MyAccountView()
                    .tabItem {
                        Label("Account", systemImage: "person.fill")
                    }
                // Add other tabs here
            }
            .navigationTitle("Book Club")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
