//
//  CreateProfileView.swift
//  bookclub-ui
//
//  Created by Tianna Alina Lopes on 1/10/24.
//
import SwiftUI

struct CreateProfileView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var favoriteBook: String = ""
    @State private var bio: String = ""

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
            // Background color
            oliveGreen.edgesIgnoringSafeArea(.all)

            // Profile creation form
            VStack(spacing: 20) {
                Text("Create Your Profile")
                    .font(.largeTitle)
                    .foregroundColor(darkMaroon)

                TextField("Username", text: $username)
                    .padding()
                    .background(offWhite)
                    .cornerRadius(5.0)

                TextField("Email", text: $email)
                    .padding()
                    .background(offWhite)
                    .cornerRadius(5.0)
                
                TextField("Favorite Book", text: $favoriteBook)
                    .padding()
                    .background(offWhite)
                    .cornerRadius(5.0)
                
                TextField("Short Bio", text: $bio)
                    .padding()
                    .background(offWhite)
                    .cornerRadius(5.0)
                    .frame(height: 100) // Larger text field for bio

                Button(action: {
                    // Handle create profile action
                }) {
                    Text("Create Profile")
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


struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView()
    }
}

