//
//  UsernameView.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/9/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct UsernameView: View {
    @State private var username: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var navigateToMainActivityView = false
    @ObservedObject var userAuth: UserAuth
    
    

    var body: some View {
        ZStack {
            // Background image
            Image("username_image")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.horizontal)
            
            VStack(spacing: 33) {
                Spacer()
                
                // Username TextField
                TextField("username", text: $username)
                    .frame(width: 300, height: 40)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
                
                // Confirm Button
                Button(action: {
                    let validationMessage = isValidUsername(username)
                    if validationMessage != "OK" {
                        self.alertMessage = validationMessage
                        self.showingAlert = true
                    } else {
                        checkUsernameUnique(username)
                    }
                }) {
                    Text("Confirm")
                        .frame(width: 220, height: 40)
                        .background(Color(red: 0.995, green: 0.744, blue: 0.013))
                        .cornerRadius(30)
                        .foregroundColor(Color.white)
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 100)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Message"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            NavigationLink("", isActive: $navigateToMainActivityView) {
                MainActivityView(userAuth: userAuth)        .navigationBarBackButtonHidden(true)

            }
        }
    }
    private func isValidUsername(_ username: String) -> String {
        let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmedUsername.isEmpty {
            return "Username cannot be empty."
        }

        if trimmedUsername.count < 3 {
            return "Username is too short. Minimum length is 3 characters."
        }

        if trimmedUsername.count > 15 {
            return "Username is too long. Maximum length is 15 characters."
        }

        if !trimmedUsername.matches("^[a-zA-Z0-9_]+$") {
            return "Username can only contain letters, numbers, and underscores."
        }

        if trimmedUsername.contains("__") || trimmedUsername.hasPrefix("_") {
            return "Username cannot contain consecutive underscores or start with an underscore."
        }

        if let firstCharacter = trimmedUsername.first, firstCharacter.isNumber {
            return "Username cannot start with a number."
        }

        return "OK"
    }

   


    private func checkUsernameUnique(_ username: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .whereField("username", isEqualTo: username)
            .limit(to: 1)  // Updated method call
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    self.alertMessage = "Error: \(error.localizedDescription)"
                    self.showingAlert = true
                } else if let querySnapshot = querySnapshot, querySnapshot.documents.isEmpty {
                    saveUsernameToFirestore(username)
                } else {
                    self.alertMessage = "Username already exists. Please choose another."
                    self.showingAlert = true
                }
            }
    }


        private func saveUsernameToFirestore(_ username: String) {
            guard let userId = Auth.auth().currentUser?.uid else {
                self.alertMessage = "User not found."
                self.showingAlert = true
                return
            }

            let db = Firestore.firestore()
            db.collection("users").document(userId).setData(["username": username]) { error in
                if let error = error {
                    self.alertMessage = "Error saving username: \(error.localizedDescription)"
                    self.showingAlert = true
                } else {
                    self.userAuth.isUserAuthenticated = true
                }
            }
        }
    }

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        let userAuth = UserAuth() // Create a dummy UserAuth
        UsernameView(userAuth: userAuth) // Pass it to UsernameView
    }
}

