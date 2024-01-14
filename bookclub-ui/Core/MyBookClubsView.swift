import SwiftUI

struct MyBookClubsView: View {
    // Define the colors from your palette
    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let offWhite = Color(hex: "FDFDFD")
    
    private let myEvents =       [
        BookClub(id:" 1", name: "Morning Readers", description: "Join us for a lively morning discussion.", owner: "Snoop dawg", nextMeetingDate: Date().addingTimeInterval(86400 * 7)), // 7 days from now
        BookClub(id: "2", name: "Sci-Fi Enthusiasts", description: "Exploring the universe, one book at a time.",owner: "Test", nextMeetingDate: Date().addingTimeInterval(86400 * 14)), // 14 days from now
        // More mock data...
    ]
    
    var body: some View {
        ZStack {
            oliveGreen.edgesIgnoringSafeArea(.all)
            VStack {
                Text("My BookClubs")
                    .font(.largeTitle)
                    .foregroundColor(darkMaroon)
                    .padding()
                
                oliveGreen.edgesIgnoringSafeArea(.all)
                      List {
                          ForEach(myEvents) { bookClub in
                              NavigationLink(destination: BookClubDetailView(bookClub: bookClub)) {
                                  BookClubRowView(club: bookClub)
                                      .padding()
                                      .background(offWhite)
                                      .cornerRadius(5.0)
                              }
                          }
                      }
                .listStyle(GroupedListStyle())
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}()

struct MyBookClubsView_Previews: PreviewProvider {
    static var previews: some View {
        MyBookClubsView()
    }
}

