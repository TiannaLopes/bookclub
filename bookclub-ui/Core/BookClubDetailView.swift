import SwiftUI
import FirebaseFirestore
import MapKit

struct BookClubDetailView: View {
    @ObservedObject private var bookClubViewModel: BookClubViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var hasJoined: Bool = false

    let bookClub: BookClub

    // Define the colors from your palette
    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let deepPurple = Color(hex: "442F38")
    
    init(bookClub: BookClub, bookClubViewModel: BookClubViewModel) {
        self.bookClub = bookClub
        self.bookClubViewModel = bookClubViewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                joinLeaveButton
                deleteButton
                editButton
                bookClubImage
                bookClubDetails
                locationDetails
            }
            .padding()
            .navigationBarTitle(Text(bookClub.name), displayMode: .inline)
            .background(tan)
            .onAppear {
                checkIfUserHasJoined()
            }
        }
    }

    private var joinLeaveButton: some View {
        Button(action: {
            Task {
                if hasJoined {
                    try await bookClubViewModel.leaveBookClub(bookClubId: bookClub.id)
                    hasJoined = false
                } else {
                    if let userId = authViewModel.currentUser?.id {
                        try await bookClubViewModel.joinBookClub(bookClubId: bookClub.id, userId: userId)
                        hasJoined = true
                    }
                }
            }
        }) {
            Text(hasJoined ? "Leave" : "Join")
                .font(.headline)
                .foregroundColor(darkMaroon)
                .padding(8)
                .background(paleYellow)
                .cornerRadius(15.0)
        }
    }

    private var deleteButton: some View {
        Button(action: {
            Task {
                try await bookClubViewModel.deleteBookClub(bookClubId: bookClub.id)
            }
        }) {
            Text("Delete")
                .font(.headline)
                .foregroundColor(darkMaroon)
                .padding(8)
                .background(paleYellow)
                .cornerRadius(15.0)
        }
    }

    private var editButton: some View {
        NavigationLink(destination: BookClubFormView(bookClubViewModel: bookClubViewModel, bookClub: bookClub)) {
            Text("Edit Book Club Details")
                .font(.headline)
                .foregroundColor(darkMaroon)
                .padding(8)
                .background(paleYellow)
                .cornerRadius(15.0)
        }
    }

    private var bookClubImage: some View {
        Image("bookClubImage") // Assuming you have a placeholder image named "bookClubImage"
            .resizable()
            .aspectRatio(contentMode: .fit)
    }

    private var bookClubDetails: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(bookClub.name)
                .font(.title)
                .foregroundColor(darkMaroon)

            Text(bookClub.description)
                .font(.body)
                .foregroundColor(darkMaroon)
                .padding(.bottom)

            HStack {
                Text("Next Meeting:")
                    .font(.headline)
                    .foregroundColor(darkMaroon)
                
                Text(bookClub.nextMeetingDate, style: .date)
                    .font(.subheadline)
                    .foregroundColor(darkMaroon)
            }
        }
    }

    private var locationDetails: some View {
        VStack(alignment: .leading) {
            if let latitude = bookClub.latitude, let longitude = bookClub.longitude {
                Text(bookClub.locationName ?? "Location")
                    .font(.headline)
                    .padding(.bottom, 5)

                MapView(latitude: latitude, longitude: longitude)
                    .frame(height: 300)
                    .cornerRadius(15)
                    .padding(.bottom, 10)

                Button("Open in Apple Maps") {
                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let placemark = MKPlacemark(coordinate: coordinate)
                    let mapItem = MKMapItem(placemark: placemark)
                    mapItem.name = bookClub.locationName
                    mapItem.openInMaps(launchOptions: nil)
                }
                .foregroundColor(.blue)
            }
        }
    }

    private func checkIfUserHasJoined() {
        hasJoined = bookClub.attendees?.contains(authViewModel.currentUser?.id ?? "") ?? false
    }
}

struct BookClubDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookClubDetailView(bookClub: BookClub.mockData.first!, bookClubViewModel: BookClubViewModel())
            .environmentObject(AuthViewModel())
    }
}

