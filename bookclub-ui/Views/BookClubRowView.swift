import SwiftUI

struct BookClubRowView: View {
    var club: BookClub
    // Define your color palette
    let background = Color(hex: "C9D3BE")
    let textColor = Color(hex: "3D0814")
    let buttonColor = Color(hex: "442F38")
    // Off-white color for the text fields
    let offWhite = Color(hex: "FDFDFD")
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(club.name)
                .foregroundColor(.primary)
                .font(.headline)
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
