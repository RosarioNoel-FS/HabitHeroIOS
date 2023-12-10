//
//  SignInView.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/9/23.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
        @State private var password: String = ""
        @State private var confirmPassword: String = ""

        var body: some View {
            ZStack {
                // Background image
                Image("login_img") // Ensure this is the correct image name
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

                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Sign Up") {
                        // Implement sign-up logic
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)

                    Button("Already have an account?") {
                        // Implement navigation to sign-in screen
                    }
                    .foregroundColor(.white)
                    .padding(.top)

                    Spacer() // Optional, adjusts spacing at the bottom
                }
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
                .padding()
            }
        }
    }


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
