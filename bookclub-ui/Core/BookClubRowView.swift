import SwiftUI

struct BookClubRowView: View {
    @StateObject private var bookClubViewModel = BookClubViewModel()
    var club: BookClub
    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let offWhite = Color(hex: "FDFDFD")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(club.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                    .padding(0)

                Spacer()

                Button(action: {
                    Task {
                      try await bookClubViewModel.joinBookClub(bookClubId: club.id)
                    }
                }) {
                    Text("Join")
                        .font(.headline)
                        .foregroundColor(darkMaroon)
                        .padding(8) 
                        .background(paleYellow)
                        .cornerRadius(15.0)
                }
            }

            Text(club.description)
                .foregroundColor(.secondary)
                .font(.subheadline)
                .lineLimit(2)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(offWhite)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

