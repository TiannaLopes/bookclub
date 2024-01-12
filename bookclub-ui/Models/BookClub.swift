
import Foundation

struct BookClub: Identifiable {
    let id: Int
    let name: String
    let description: String
    let nextMeetingDate: Date

    static var mockData: [BookClub] {
        [
            BookClub(id: 1, name: "Morning Readers", description: "Join us for a lively morning discussion.", nextMeetingDate: Date().addingTimeInterval(86400 * 7)), // 7 days from now
            BookClub(id: 2, name: "Sci-Fi Enthusiasts", description: "Exploring the universe, one book at a time.", nextMeetingDate: Date().addingTimeInterval(86400 * 14)), // 14 days from now
            // More mock data...
        ]
    }
}
