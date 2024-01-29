import SwiftUI
import FirebaseFirestore
import MapKit

struct BookClubFormView: View {
    @ObservedObject var bookClubViewModel: BookClubViewModel
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var owner: String = ""
    @State private var nextMeetingDate: Date = Date()
    @State private var locationName: String = ""
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    @State private var searchText: String = ""
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
     @State private var trackingMode: MapUserTrackingMode = .follow  // Non-optional
    @Environment(\.dismiss) var dismiss

    private var bookClubId: String?
    private var isEditMode: Bool

    init(bookClubViewModel: BookClubViewModel, bookClub: BookClub? = nil) {
        self.bookClubViewModel = bookClubViewModel
        _name = State(initialValue: bookClub?.name ?? "")
        _description = State(initialValue: bookClub?.description ?? "")
        _nextMeetingDate = State(initialValue: bookClub?.nextMeetingDate ?? Date())
        self.bookClubId = bookClub?.id
        self.isEditMode = (bookClub != nil)
    }

    var body: some View {
        NavigationView {
            Form {
                bookClubDetailsSection
                saveButtonSection
            }
            .navigationBarTitle(isEditMode ? "Edit Book Club" : "New Book Club", displayMode: .inline)
        }
    }

    private var bookClubDetailsSection: some View {
        Section(header: Text("Book Club Details")) {
            TextField("Name", text: $name)
            TextField("Description", text: $description)
            DatePicker("Next Meeting Date", selection: $nextMeetingDate, displayedComponents: .date)
            TextField("Location Name", text: $locationName)
            TextField("Search Location", text: $searchText, onCommit: {
                performSearch(query: searchText)
            })
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: $trackingMode)
                                   .frame(height: 200)
                                   .cornerRadius(8)
                           }
    }

    private var saveButtonSection: some View {
        Section {
            Button(action: saveBookClub) {
                Text(isEditMode ? "Save Changes" : "Create Book Club")
            }
        }
    }

    private func performSearch(query: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = query
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response, let item = response.mapItems.first else {
                print("Search error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                self.locationName = item.name ?? query
                self.latitude = item.placemark.coordinate.latitude
                self.longitude = item.placemark.coordinate.longitude
                self.region = MKCoordinateRegion(center: item.placemark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            }
        }
    }

    private func saveBookClub() {
        Task {
            do {
                let bookClubData: [String: Any] = [
                    "name": name,
                    "ownser":owner,
                    "description": description,
                    "nextMeetingDate": nextMeetingDate,
                    "locationName": locationName,
                    "latitude": latitude,
                    "longitude": longitude
                ]

                if isEditMode, let bookClubId = bookClubId {
                    try await bookClubViewModel.updateBookClub(bookClubId: bookClubId, newDetails: bookClubData)
                } else {
                    try await bookClubViewModel.createBookClub(name: name, description: description, nextMeetingDate: nextMeetingDate, owner: "Unknown", locationName: locationName, latitude: latitude, longitude: longitude)
                }
                dismiss()
            } catch {
                print("Error saving book club: \(error.localizedDescription)")
            }
        }
    }
}

