
import SwiftUI

struct MyAccountView: View {
    @State private var currentUser = User.currentUser
    @State private var editingProfile = false

    // Define the colors from your palette
    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let deepPurple = Color(hex: "442F38")
    
    // Off-white color for the text fields
    let offWhite = Color(hex: "FDFDFD")


    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                if editingProfile {
                    TextField("Username", text: $currentUser.username)
                    TextField("Email", text: $currentUser.email)
                    TextField("Favorite Book", text: $currentUser.favoriteBook)
                    TextField("Bio", text: $currentUser.bio)
                } else {
                    Text(currentUser.username)
                    Text(currentUser.email)
                    Text(currentUser.favoriteBook)
                    Text(currentUser.bio)
                }
            }

            Section {
                Button(editingProfile ? "Save Changes" : "Edit Profile") {
                    if editingProfile {
                        // Save the changes to user profile
                        // Call a function to update the profile data
                    }
                    editingProfile.toggle()
                }
            }
        }
        .navigationBarTitle("My Account")
        .listStyle(GroupedListStyle())
        oliveGreen.edgesIgnoringSafeArea(.all)
    }
}


struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
    }
}
