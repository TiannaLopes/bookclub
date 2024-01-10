import SwiftUI

struct MyBookClubsView: View {
    let myEvents: [BookClubEvent] = BookClubEvent.myEvents
    
    var body: some View {
        List {
            ForEach(myEvents.filter { $0.isAttending }) { event in
                VStack(alignment: .leading) {
                    Text(event.bookClub.name)
                        .font(.headline)
                    Text(event.bookClub.description)
                        .font(.subheadline)
                    Text("Event Date: \(event.eventDate, formatter: itemFormatter)")
                        .font(.caption)
                }
            }
        }
        .navigationTitle("My BookClubs")
        .listStyle(GroupedListStyle())
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
