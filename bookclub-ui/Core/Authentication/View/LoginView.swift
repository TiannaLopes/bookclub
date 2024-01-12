import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel

    // Define the colors from your palette
    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let deepPurple = Color(hex: "442F38")
    let offWhite = Color(hex: "FDFDFD")

    var body: some View {
        NavigationStack{
            ZStack {
                oliveGreen.edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Text("Sign In")
                        .font(.largeTitle)
                        .foregroundColor(darkMaroon)
                    
                    InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                        .autocapitalization(.none)
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                    
                    Button(action: {
                        Task {
                            try await viewModel.signIn(withEmail: email, password: password)
                        }
                    }) {
                        Text("SIGN IN")
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
                    
                    NavigationLink {
                        SignUpView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack(spacing: 3) {
                            Text("Don't have an account?")
                                .foregroundStyle(deepPurple)
                            Text("Sign up")
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
}

// Mark: - AuthenticationFormProtocol

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
