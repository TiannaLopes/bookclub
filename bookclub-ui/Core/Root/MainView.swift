import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        Group{
            if viewModel.userSession != nil {
                NavigationView {
                    TabView {
                        NavigationView {
                            BookClubFeedView()
                        }
                        .tabItem {
                            Label("Feed", systemImage: "book.fill")
                        }
                        
                        NavigationView {
                            MyBookClubsView()
                        }
                        .tabItem {
                            Label("My BookClubs", systemImage: "person.fill")
                        }
                        
                        NavigationView {
                            ProfileView()
                        }
                        .tabItem {
                            Label("Profile", systemImage: "person.crop.circle")
                        }
                    }
                    .navigationTitle("Book Club")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
                else {
                    LoginView()
                
            }
        }
    }
}

