//
//  FirebaseHelper.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/17/23.
//

import Foundation

import Firebase
import FirebaseFirestore
import FirebaseStorage

class FirebaseHelper {

    private let db = Firestore.firestore()
    private let storage = Storage.storage()

    // Fetch all habits for a specific user
    func fetchUserHabits(userId: String, completion: @escaping (Result<[Habit], Error>) -> Void) {
            guard !userId.isEmpty else {
                completion(.failure(NSError(domain: "FirebaseHelper", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID is empty"])))
                return
            }

            db.collection("users").document(userId).collection("habits")
                .order(by: "timestamp", descending: true)
                .getDocuments { (querySnapshot, err) in
                    if let err = err {
                        completion(.failure(err))
                    } else {
                        let habits = querySnapshot?.documents.compactMap { document -> Habit? in
                            try? document.data(as: Habit.self)
                        }
                        completion(.success(habits ?? []))
                    }
                }
        }

    // Fetch categories
    func fetchCategories(completion: @escaping (Result<[String: Category], Error>) -> Void) {
        db.collection("Category")
            .getDocuments { (querySnapshot, err) in
                if let err = err {
                    completion(.failure(err))
                } else {
                    var categories = [String: Category]()
                    for document in querySnapshot!.documents {
                        let categoryName = document.data()["name"] as? String ?? ""
                        let habitList = document.data()["habit_list"] as? [String] ?? []
                        let iconPath = document.data()["icon"] as? String ?? ""

                        categories[categoryName] = Category(name: categoryName, habitList: habitList, iconUrl: iconPath)
                    }
                    completion(.success(categories))
                }
            }
    }

    // Fetch icon URL for a category
    func fetchIconUrlForCategory(category: String, completion: @escaping (Result<String, Error>) -> Void) {
        db.collection("Category")
            .whereField("name", isEqualTo: category)
            .limit(to: 1)
            .getDocuments { (querySnapshot, err) in
                if let err = err {
                    completion(.failure(err))
                } else {
                    if let document = querySnapshot?.documents.first,
                       let iconUrl = document.data()["icon"] as? String {
                        completion(.success(iconUrl))
                    } else {
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Category not found"])))
                    }
                }
            }
    }

    // Add a new habit for a user
    func addHabit(userId: String, habit: Habit, completion: @escaping (Result<Habit, Error>) -> Void) {
        do {
            let newHabit = try Firestore.Encoder().encode(habit)
            db.collection("users").document(userId).collection("habits")
                .addDocument(data: newHabit) { err in
                    if let err = err {
                        completion(.failure(err))
                    } else {
                        completion(.success(habit))
                    }
                }
        } catch let error {
            completion(.failure(error))
        }
    }


    // Update an existing habit
    func updateCompletedHabit(userId: String, habit: Habit, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let habitId = habit.id else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Habit ID not found"])))
            return
        }

        let updates: [String: Any] = [
            "completed": habit.completed,
            "streakCount": habit.streakCount,
            "completionCount": habit.completionCount,
            "completionDates": habit.completionDates
        ]

        db.collection("users").document(userId).collection("habits").document(habitId)
            .updateData(updates) { err in
                if let err = err {
                    completion(.failure(err))
                } else {
                    completion(.success(()))
                }
            }
    }

    // Delete a habit
    func deleteHabit(userId: String, habitId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").document(userId).collection("habits").document(habitId)
            .delete() { err in
                if let err = err {
                    completion(.failure(err))
                } else {
                    completion(.success(()))
                }
            }
    }

    // Load profile image
    func loadProfileImage(userId: String, completion: @escaping (Result<URL, Error>) -> Void) {
        db.collection("users").document(userId)
            .getDocument { (documentSnapshot, err) in
                if let err = err {
                    completion(.failure(err))
                } else if let documentSnapshot = documentSnapshot, documentSnapshot.exists,
                          let imageUrlString = documentSnapshot.data()?["profileImageUrl"] as? String,
                          let imageUrl = URL(string: imageUrlString) {
                    completion(.success(imageUrl))
                } else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Profile image not found"])))
                }
            }
    }

    // Update profile image URL
    func updateProfileImageUrl(userId: String, newImageUrl: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        let updates: [String: Any] = ["profileImageUrl": newImageUrl.absoluteString]
        db.collection("users").document(userId)
            .updateData(updates) { err in
                if let err = err {
                    completion(.failure(err))
                } else {
                    completion(.success(()))
                }
            }
    }

    // Update username
    func updateUsername(userId: String, newUsername: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").document(userId)
            .updateData(["username": newUsername]) { err in
                if let err = err {
                    completion(.failure(err))
                } else {
                    completion(.success(()))
                }
            }
    }

    // Load user data
    func loadUserData(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
        db.collection("users").document(userId)
            .getDocument { (documentSnapshot, err) in
                if let err = err {
                    completion(.failure(err))
                } else if let documentSnapshot = documentSnapshot, documentSnapshot.exists,
                          let user = try? documentSnapshot.data(as: User.self) {
                    completion(.success(user))
                } else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                }
            }
    }

    // Fetch completion dates
//    func fetchCompletionDates(userId: String, habitId: String, completion: @escaping (Result<[String], Error>) -> Void) {
//        db.collection("users").document(userId).collection("habits").document(habitId)
//            .getDocument { (documentSnapshot, err) in
//                if let err = err {
//                    completion(.failure(err))
//                } else if let documentSnapshot = documentSnapshot, documentSnapshot.exists,
//                          let habit = try? documentSnapshot.data(as: Habit.self) {
//                    completion(.success(habit.completionDates))
//                } else {
//                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Habit not found"])))
//                }
//            }
//    }

}

