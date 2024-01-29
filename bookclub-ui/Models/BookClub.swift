import Foundation

struct BookClub: Identifiable, Codable {
    let id: String  
    let name: String
    let description: String
    var owner: String
    let nextMeetingDate: Date
    var attendees: [String]?
    var locationName: String?
     var latitude: Double? 
     var longitude: Double?
    
    static var mockData: [BookClub] {
        [
            BookClub(id: "1", name: "Morning Readers", description: "Join us for a lively morning discussion.", owner: "User123", nextMeetingDate: Date().addingTimeInterval(86400 * 7)), // 7 days from now
            BookClub(id: "2", name: "Sci-Fi Enthusiasts", description: "Exploring the universe, one book at a time.", owner: "User456", nextMeetingDate: Date().addingTimeInterval(86400 * 14)), // 14 days from now
            // Add more mock data as needed...
        ]
    }
}

