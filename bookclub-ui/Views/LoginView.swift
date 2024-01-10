
import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""

    // Define the colors from your palette
    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let deepPurple = Color(hex: "442F38")
    
    // Off-white color for the text fields
    let offWhite = Color(hex: "FDFDFD")

    var body: some View {
        ZStack {
            // Use oliveGreen as the primary background color
            oliveGreen.edgesIgnoringSafeArea(.all)

            // Login form
            VStack(spacing: 20) {
                Text("Sign in")
                    .font(.largeTitle)
                    .foregroundColor(darkMaroon)

                TextField("Username", text: $username)
                    .padding()
                    .background(offWhite)
                    .cornerRadius(5.0)

                SecureField("Password", text: $password)
                    .padding()
                    .background(offWhite)
                    .cornerRadius(5.0)

                Button(action: {
                    // Handle login action
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(paleYellow)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(darkMaroon)
                        .cornerRadius(15.0)
                }
            }
            .padding()
            .background(tan.opacity(0.8)) // Semi-transparent tan background for the form
            .cornerRadius(10)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}




