import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showErrorAlert = false
    @State private var showSuccessAlert = false
    @State private var navigateToUsernameScreen = false
    @ObservedObject var userAuth: UserAuth

    @State private var showSignInView = false
    @ObservedObject private var viewModel = AuthenticationViewModel()


    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("login_img")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.horizontal)

                VStack {
                    Spacer()

                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    Button("Sign Up") {
                                    if viewModel.isValidEmail(email) && viewModel.isValidPassword(password) && viewModel.passwordsMatch(password, confirmPassword) {
                                        viewModel.signUpWithEmail(email: email, password: password, confirmPassword: confirmPassword) { success in
                                            if success {
                                                showSuccessAlert = true
                                            } else {
                                                showErrorAlert = true
                                            }
                                        }
                                    } else {
                                        showErrorAlert = true
                                    }
                                }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.995, green: 0.744, blue: 0.013))
                    .cornerRadius(30)

                    Button("Already have an account?") {
                        self.showSignInView = true
                    }
                    .foregroundColor(.white)
                    .padding(.top)

                    Spacer()
                }
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
                .padding()

                NavigationLink("", isActive: $showSignInView) {     SignInView(userAuth: userAuth)
 }
                
                NavigationLink("", isActive: $navigateToUsernameScreen) {
                    UsernameView(userAuth: userAuth)
                }

            }
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
            .alert("Sign Up Successful", isPresented: $showSuccessAlert) {
                Button("OK") {
                    navigateToUsernameScreen = true
                    
                }
            } message: {
                Text("Your account has been created successfully.")
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        let userAuth = UserAuth()
        SignUpView(userAuth: userAuth)
    }
}

