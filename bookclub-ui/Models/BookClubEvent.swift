import SwiftUI

struct BookClubEvent: Identifiable {
    let id: Int
    let bookClub: BookClub
    let eventDate: Date
    let isAttending: Bool
    
    // Mock data
    static var myEvents: [BookClubEvent] {
        [
            BookClubEvent(id: 1, bookClub: BookClub.mockData[0], eventDate: Date(), isAttending: true),
            // Add more events here
        ]
    }
}
