//
//  CreateProfileView.swift
//  bookclub-ui
//
//  Created by Tianna Alina Lopes on 1/10/24.
//
import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @Environment(\.dismiss) var dismiss

    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let deepPurple = Color(hex: "442F38")
    let offWhite = Color(hex: "FDFDFD")

    var body: some View {
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
                
                InputView(text: $firstName, title: "First Name", placeholder: "Enter your first name")
                
                InputView(text: $lastName, title: "Last Name", placeholder: "Enter your last name")
                
                InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                
                InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // sign up button
            Button{
                print("Sign user up...")
            } label:{
                HStack{
                    Text("SIGN UP")
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
            Button{
                dismiss()
            }  label:{
                HStack(spacing: 3){
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
                 
        }
        
    }
        
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

//var body: some View {
//    ZStack {
//        // Background color
//        oliveGreen.edgesIgnoringSafeArea(.all)
//
//        // Profile creation form
//        VStack(spacing: 20) {
//            Text("Create Your Profile")
//                .font(.largeTitle)
//                .foregroundColor(darkMaroon)
//
//            TextField("Username", text: $username)
//                .padding()
//                .background(offWhite)
//                .cornerRadius(5.0)
//
//            TextField("Email", text: $email)
//                .padding()
//                .background(offWhite)
//                .cornerRadius(5.0)
//
//            TextField("Favorite Book", text: $favoriteBook)
//                .padding()
//                .background(offWhite)
//                .cornerRadius(5.0)
//
//            TextField("Short Bio", text: $bio)
//                .padding()
//                .background(offWhite)
//                .cornerRadius(5.0)
//                .frame(height: 100) // Larger text field for bio
//
//            Button(action: {
//                // Handle create profile action
//            }) {
//                Text("Create Profile")
//                    .font(.headline)
//                    .foregroundColor(paleYellow)
//                    .padding()
//                    .frame(width: 220, height: 60)
//                    .background(darkMaroon)
//                    .cornerRadius(15.0)
//            }
//        }
//        .padding()
//        .background(tan.opacity(0.8)) // Semi-transparent tan background for the form
//        .cornerRadius(10)
//    }
//}
//}
