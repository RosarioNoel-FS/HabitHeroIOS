//
//  ProfileViewModel.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/14/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

class ProfileViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var profileImage: UIImage?

    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }

    init() {
        loadUserProfile()
    }

    func loadUserProfile() {
        guard let userId = userId else { return }

        db.collection("users").document(userId).getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                let userData = document.data()
                self?.username = userData?["username"] as? String ?? ""
                self?.loadProfileImage()
            } else {
                print("Document does not exist: \(error?.localizedDescription ?? "")")
            }
        }
    }

    func updateUsername(newUsername: String) {
        guard let userId = userId else { return }

        db.collection("users").document(userId).updateData(["username": newUsername]) { [weak self] error in
            if let error = error {
                print("Error updating username: \(error.localizedDescription)")
            } else {
                self?.username = newUsername
            }
        }
    }

    func uploadProfileImage(image: UIImage) {
        guard let userId = userId,
              let imageData = image.jpegData(compressionQuality: 0.5) else { return }

        let storageRef = storage.reference().child("profile_images/\(userId).jpg")
        storageRef.putData(imageData, metadata: nil) { [weak self] (metadata, error) in
            if let error = error {
                print("Error uploading profile image: \(error.localizedDescription)")
                return
            }
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("Download URL not found")
                    return
                }
                self?.updateProfileImageUrl(downloadURL: downloadURL)
            }
        }
    }

    private func updateProfileImageUrl(downloadURL: URL) {
        guard let userId = userId else { return }

        db.collection("users").document(userId).updateData(["profileImageUrl": downloadURL.absoluteString]) { error in
            if let error = error {
                print("Error updating profile image URL: \(error.localizedDescription)")
            } else {
                self.loadProfileImage()
            }
        }
    }

    private func loadProfileImage() {
        guard let userId = userId else { return }

        db.collection("users").document(userId).getDocument { [weak self] (document, error) in
            if let document = document, document.exists,
               let urlString = document.data()?["profileImageUrl"] as? String,
               let url = URL(string: urlString) {
                self?.downloadImage(from: url)
            } else {
                print("Document does not exist: \(error?.localizedDescription ?? "")")
            }
        }
    }

    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileImage = image
                }
            }
        }.resume()
    }
}

 
