
import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    // Define the colors from your palette
    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let deepPurple = Color(hex: "442F38")
    let offWhite = Color(hex: "FDFDFD")

  
    var body: some View {
        NavigationStack{
            VStack{
                // image
                Image("bookclub-logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width:100, height: 100)
                    .padding(.vertical, 32)
                
                // form fields
                VStack(spacing: 24){
                    InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                        .autocapitalization(.none)
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // sign in button
                Button{
                    print("Log user in...")
                } label:{
                    HStack{
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                // sign up button
                
                NavigationLink{
                    SignUpView()
                }label:{
                    HStack(spacing: 3){
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }.font(.system(size: 14))
                }
            }
        }
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


//  var body: some View {
//ZStack {
//    // Use oliveGreen as the primary background color
//    oliveGreen.edgesIgnoringSafeArea(.all)
//
//    // Login form
//    VStack(spacing: 20) {
//        Text("Sign in")
//            .font(.largeTitle)
//            .foregroundColor(darkMaroon)
//
//        TextField("Username", text: $username)
//            .padding()
//            .background(offWhite)
//            .cornerRadius(5.0)
//
//        SecureField("Password", text: $password)
//            .padding()
//            .background(offWhite)
//            .cornerRadius(5.0)
//
//        Button(action: {
//            // Handle login action
//        }) {
//            Text("Login")
//                .font(.headline)
//                .foregroundColor(paleYellow)
//                .padding()
//                .frame(width: 220, height: 60)
//                .background(darkMaroon)
//                .cornerRadius(15.0)
//        }
//    }
//    .padding()
//    .background(tan.opacity(0.8)) // Semi-transparent tan background for the form
//    .cornerRadius(10)
//}
//}



