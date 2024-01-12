import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel

    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let deepPurple = Color(hex: "442F38")
    let offWhite = Color(hex: "FDFDFD")

    var body: some View {
        ZStack {
            oliveGreen.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Create Your Profile")
                    .font(.largeTitle)
                    .foregroundColor(darkMaroon)

                InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                    .autocapitalization(.none)

                InputView(text: $firstName, title: "First Name", placeholder: "Enter your first name")
                
                InputView(text: $lastName, title: "Last Name", placeholder: "Enter your last name")

                InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)

                InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)

                Button(action: {
                    Task {
                        try await viewModel.createUser(withEmail: email, password: password, firstName: firstName, lastName: lastName)
                    }
                }) {
                    Text("SIGN UP")
                        .font(.headline)
                        .foregroundColor(paleYellow)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(darkMaroon)
                        .cornerRadius(15.0)
                }
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .padding(.top, 24)

                Spacer()

                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                          .foregroundStyle(deepPurple)
                        Text("Sign in")
                            .fontWeight(.bold)
                            .foregroundStyle(deepPurple)
                    }
                    .font(.system(size: 14))
                }
            }
            .padding()
            .background(tan.opacity(0.8))
            .cornerRadius(10)
        }
    }
}

// Mark: - AuthenticationFormProtocol

extension SignUpView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5 && confirmPassword == password && !firstName.isEmpty && !lastName.isEmpty
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

