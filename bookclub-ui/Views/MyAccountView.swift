import SwiftUI

struct MyAccountView: View {
    @State private var currentUser = User.currentUser
    @State private var editingProfile = false

    // Define the colors from your palette
    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let offWhite = Color(hex: "FDFDFD")

    var body: some View {
        ZStack {
            // Background color
            oliveGreen.edgesIgnoringSafeArea(.all)
            
            // Form
            VStack(spacing: 20) {
                Text("My Account")
                    .font(.largeTitle)
                    .foregroundColor(darkMaroon)
                    .padding(.top)

                if editingProfile {
                    Group {
                        TextField("Username", text: $currentUser.username)
                        TextField("Email", text: $currentUser.email)
                        TextField("Favorite Book", text: $currentUser.favoriteBook)
                        TextField("Bio", text: $currentUser.bio)
                    }
                    .padding()
                    .background(offWhite)
                    .cornerRadius(5.0)
                } else {
                    Group {
                        Text(currentUser.username)
                        Text(currentUser.email)
                        Text(currentUser.favoriteBook)
                        Text(currentUser.bio)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(offWhite)
                    .cornerRadius(5.0)
                }

                Button(action: {
                    if editingProfile {
                        // Save the changes to user profile
                        // Call a function to update the profile data
                    }
                    editingProfile.toggle()
                }) {
                    Text(editingProfile ? "Save Changes" : "Edit Profile")
                        .font(.headline)
                        .foregroundColor(paleYellow)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(darkMaroon)
                        .cornerRadius(15.0)
                }
                Spacer()
            }
            .padding()
            .background(tan.opacity(0.8)) // Semi-transparent tan background for the form
            .cornerRadius(10)
        }
        .navigationBarTitle("My Account", displayMode: .inline)
    }
}

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
    }
}

