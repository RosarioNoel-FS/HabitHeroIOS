import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            // Background image
            Image("login_img")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.horizontal)

            // Form content
            VStack {
                Spacer() // Pushes the content down

                

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Sign In") {
                    // Implement sign-up logic
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.bottom)

                Button("Create an Account") {
                    // Implement account creation logic
                }
                .foregroundColor(.white)

                Spacer() // Optional, adjusts spacing at the bottom
            }
            .padding()
            .background(Color.black.opacity(0.5))
            .cornerRadius(10)
            .padding()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
