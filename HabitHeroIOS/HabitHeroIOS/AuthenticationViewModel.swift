//
//  AuthenticationViewModel.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/13/23.
//

import Foundation
import FirebaseAuth

class AuthenticationViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    
    //                      -- VALIDATION METHODS --

    public func isValidEmail(_ email: String) -> Bool {
            // Implement more detailed email validation
            guard !email.isEmpty else {
                errorMessage = "Email cannot be empty."
                return false
            }
            guard email.contains("@") && email.contains(".") else {
                errorMessage = "Invalid email format."
                return false
            }
            return true
        }


    public func isValidPassword(_ password: String) -> Bool {
            // Implement more detailed password validation
            guard !password.isEmpty else {
                errorMessage = "Password cannot be empty."
                return false
            }
            guard password.count >= 6 else {
                errorMessage = "Password must be at least 6 characters long."
                return false
            }
            return true
        }
    
    public func passwordsMatch(_ password: String, _ confirmPassword: String) -> Bool {
            // Check if passwords match
            guard password == confirmPassword else {
                errorMessage = "Passwords do not match."
                return false
            }
            return true
        }

    
    //                           -- FIREBASE METHODS --
    func signInWithEmail(email: String, password: String, completion: @escaping (Bool) -> Void) {
        guard isValidEmail(email), isValidPassword(password) else {
            self.errorMessage = "Invalid email or password"
            return completion(false)
        }

        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(false)
            } else {
                completion(true)
            }
        }
    }

    func signUpWithEmail(email: String, password: String, confirmPassword: String, completion: @escaping (Bool) -> Void) {
        guard isValidEmail(email), isValidPassword(password), password == confirmPassword else {
            self.errorMessage = "Invalid input or passwords do not match"
            return completion(false)
        }

        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func signOut(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            print("Sign out successful")
            completion(true)
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
            completion(false)
        }
    }


}


