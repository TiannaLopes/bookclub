import SwiftUI

struct MyBookClubsView: View {
    let myEvents: [BookClubEvent] = BookClubEvent.myEvents

    // Define the colors from your palette
    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let offWhite = Color(hex: "FDFDFD")

    var body: some View {
        ZStack {
            // Background color
            oliveGreen.edgesIgnoringSafeArea(.all)

            VStack {
                Text("My BookClubs")
                    .font(.largeTitle)
                    .foregroundColor(darkMaroon)
                    .padding()

                List {
                    ForEach(myEvents.filter { $0.isAttending }) { event in
                        VStack(alignment: .leading) {
                            Text(event.bookClub.name)
                                .font(.headline)
                                .foregroundColor(darkMaroon)
                            Text(event.bookClub.description)
                                .font(.subheadline)
                                .foregroundColor(darkMaroon)
                            Text("Event Date: \(event.eventDate, formatter: itemFormatter)")
                                .font(.caption)
                                .foregroundColor(darkMaroon)                         }
                        .padding()
                        .background(offWhite)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .listStyle(GroupedListStyle())
            }
        }
        .navigationBarTitle("My BookClubs", displayMode: .inline)
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
