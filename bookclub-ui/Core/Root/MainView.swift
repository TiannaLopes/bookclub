import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        Group{
            if viewModel.userSession != nil {
                ProfileView()
            }else{
                LoginView()
            }
        }
    }
}


//        NavigationView {
//            TabView {
//                BookClubFeedView()
//                    .tabItem {
//                        Label("Feed", systemImage: "book.fill")
//                    }
//
//                MyAccountView()
//                    .tabItem {
//                        Label("Account", systemImage: "person.fill")
//                    }
//            }
//            .navigationTitle("Book Club")
//            .navigationBarTitleDisplayMode(.inline)
//        }
