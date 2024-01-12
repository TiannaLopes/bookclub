import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    // Define the colors from your palette
    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let offWhite = Color(hex: "FDFDFD")

    var body: some View {
        ZStack {
            oliveGreen.edgesIgnoringSafeArea(.all)

            if let user = viewModel.currentUser {
                VStack(spacing: 20) {
                    Text("My Account")
                        .font(.largeTitle)
                        .foregroundColor(darkMaroon)
                        .frame(maxWidth: .infinity, maxHeight:200)
                        .background(tan.opacity(0.8))
                        .padding(.top)
                        .padding(.bottom)
                    Text(user.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width:72, height: 72)
                        .background(tan)
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing:4){
                        Text(user.firstName + " " + user.lastName)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text(user.email)
                            .font(.footnote)
                            .foregroundColor(offWhite)
                    }
                Spacer()  // Pushes the content to the left
                 

                        // Additional sections can be added here as needed

                        Button {
                            viewModel.signOut()
                        } label: {
                            Text("Sign Out")
                                .font(.headline)
                                .foregroundColor(paleYellow)
                                .padding()
                                .frame(width: 220, height: 60)
                                .background(darkMaroon)
                                .cornerRadius(15.0)
                        }
                        .padding(.bottom, 10)

                        Button {
                            viewModel.deleteAccount()
                        } label: {
                            Text("Delete Account")
                                .font(.headline)
                                .foregroundColor(paleYellow)
                                .padding()
                                .frame(width: 220, height: 60)
                                .background(darkMaroon)
                                .cornerRadius(15.0)
                        }

                        Spacer()
                  
                }
            } else {
                // Handle case where user is not logged in or user data is unavailable
                Text("User not found")
                    .foregroundColor(darkMaroon)
            }
        }
        .navigationBarTitle("My Account", displayMode: .inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

