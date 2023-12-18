import SwiftUI

struct SignInView: View {
    @ObservedObject var userAuth: UserAuth

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToMainActivityView = false
    @State private var showSignUpView = false
    @State private var showErrorAlert = false

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

                   

                    Button("Sign In") {
                        viewModel.signInWithEmail(email: email, password: password) { success in
                            if success {
                                userAuth.isUserAuthenticated = true

                            } else {
                                self.showErrorAlert = true
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.995, green: 0.744, blue: 0.013))
                    .cornerRadius(30)
                    .padding(.bottom)

                    Button("Create an Account") {
                        self.showSignUpView = true
                    }
                    .foregroundColor(.white)

                    Spacer()
                }
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
                .padding()

                NavigationLink("", isActive: $navigateToMainActivityView) { MainActivityView(userAuth: userAuth)
                        .navigationBarBackButtonHidden(true)

                }
                                    .navigationBarBackButtonHidden(true)
                NavigationLink("", isActive: $showSignUpView) { SignUpView(userAuth: userAuth) }
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of UserAuth for the preview
        let userAuth = UserAuth()

        // Pass the instance to SignInView
        SignInView(userAuth: userAuth)
    }
}

