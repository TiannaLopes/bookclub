
import SwiftUI

struct BookClubDetailView: View {
    @ObservedObject private var bookClubViewModel: BookClubViewModel
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
                if hasJoined {
                                    Button(action: {
                                        Task {
                                            try await bookClubViewModel.leaveBookClub(bookClubId: bookClub.id)
                                            hasJoined = false
                                        }
                                    }) {
                                        Text("Leave")
                                            .font(.headline)
                                            .foregroundColor(darkMaroon)
                                            .padding(8)
                                            .background(paleYellow)
                                            .cornerRadius(15.0)
                                    }
                                } else {
                                    Button(action: {
                                        Task {
                                            try await bookClubViewModel.joinBookClub(bookClubId: bookClub.id)
                                            hasJoined = true
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
                NavigationLink(destination: BookClubFormView(bookClubViewModel: bookClubViewModel, bookClub: bookClub)) {
                    Text("Edit Book Club Details")
                    .font(.headline)
                    .foregroundColor(darkMaroon)
                    .padding(8)
                    .background(paleYellow)
                    .cornerRadius(15.0)
                }
                Image("bookClubImage")
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
        .onAppear {
                       hasJoined = bookClub.attendees?.contains(bookClubViewModel.currentUser?.id ?? "") ?? false
                   }
    }
}
    
struct BookClubDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookClubDetailView(bookClub: BookClub.mockData.first!, bookClubViewModel: BookClubViewModel())
    }
}

