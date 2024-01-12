
import SwiftUI

struct BookClubDetailView: View {
    let bookClub: BookClub  // Assume BookClub is a model struct with appropriate properties

    // Define the colors from your palette
    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let deepPurple = Color(hex: "442F38")

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Image("bookClubImage")  // Placeholder for the book club image
                    .resizable()
                    .aspectRatio(contentMode: .fit)

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

               

                Spacer()
            }
            .padding()
        }
        .navigationBarTitle(Text(bookClub.name), displayMode: .inline)
        .background(tan)
    }
}
    
struct BookClubDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookClubDetailView(bookClub: BookClub.mockData.first!)
    }
}

