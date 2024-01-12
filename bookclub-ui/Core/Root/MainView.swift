import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        Group{
            if viewModel.userSession != nil {
                ProfileView()
                NavigationView {
                    TabView {
                        BookClubFeedView()
                            .tabItem {
                                Label("Feed", systemImage: "book.fill")
                            }
                        
                        MyBookClubsView()
                            .tabItem {
                                Label("My BookClubs", systemImage: "person.fill")
                            }
                    }
                    .navigationTitle("Book Club")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }else{
                LoginView()
            }
        }
    }
}

