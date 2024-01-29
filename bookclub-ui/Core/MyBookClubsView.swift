import SwiftUI

struct MyBookClubsView: View {
    @StateObject private var bookClubViewModel = BookClubViewModel()
    
    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let offWhite = Color(hex: "FDFDFD")
    
    var body: some View {
        ZStack {
            oliveGreen.edgesIgnoringSafeArea(.all)
            VStack {
                Text("My BookClubs")
                    .font(.largeTitle)
                    .foregroundColor(darkMaroon)
                    .padding()
                
                List {
                    ForEach(bookClubViewModel.myBookClubs) { bookClub in
                        NavigationLink(destination: BookClubDetailView(bookClub: bookClub, bookClubViewModel: bookClubViewModel)) {
                            BookClubRowView(club: bookClub)
                                .padding()
                                .background(offWhite)
                                .cornerRadius(5.0)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .onAppear {
                Task {
                    await bookClubViewModel.fetchMyBookClubs()
                }
            }
        }
    }
}

struct MyBookClubsView_Previews: PreviewProvider {
    static var previews: some View {
        MyBookClubsView()
    }
}

