    import SwiftUI

    struct ProfileView: View {
        @StateObject private var viewModel = ProfileViewModel()
        @State private var newUsername: String = ""
        @State private var isImagePickerPresented = false
        @State private var showSourceSelection = false
        @State private var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
        @Environment(\.presentationMode) var presentationMode
        @State private var showSignOutConfirmation = false
        @ObservedObject var userAuth: UserAuth
        



        
        @StateObject private var authViewModel = AuthenticationViewModel() // This holds the authentication logic




        var body: some View {
            VStack {
                // Username display
                Text(viewModel.username.isEmpty ? "Username" : viewModel.username)
                    .font(.title)
                    .padding(.top, 20)
                
                // Profile image
                Image(uiImage: viewModel.profileImage ?? UIImage(named: "profile_image")!) // Replace "defaultProfile" with your default image name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
                    .onTapGesture {
                        isImagePickerPresented = true
                    }
                
                // Edit button
                Button("Edit") {
                    showSourceSelection = true
                }
                .buttonStyle(RoundedButtonStyle())
                .padding(.bottom, 20)
                
                // Update username section
                Text("Update username")
                    .font(.headline)
                
                TextField("Enter new username", text: $newUsername)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Confirm") {
                    viewModel.updateUsername(newUsername: newUsername)
                }
                .buttonStyle(RoundedButtonStyle())
                .padding(.bottom, 20)
                
                Spacer()
                
                // Sign out button at the bottom
                Button("Sign Out") {
                    self.showSignOutConfirmation = true
                }
                .alert(isPresented: $showSignOutConfirmation) {
                    Alert(
                        title: Text("Sign Out"),
                        message: Text("Are you sure you want to sign out?"),
                        primaryButton: .destructive(Text("Sign Out")) {
                            authViewModel.signOut { success in
                                if success {
                                    DispatchQueue.main.async {
                                        userAuth.isUserAuthenticated = false

                                        print("isUserLoggedIn set to false on main thread")

                                    }
                                } else {
                                    // Handle error if needed
                                    print("Sign out failed")

                                }
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }

            .actionSheet(isPresented: $showSourceSelection) {
                ActionSheet(title: Text("Select Image"), buttons: [
                    .default(Text("Camera")) {
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            imagePickerSourceType = .camera
                            isImagePickerPresented = true
                        } else {
                            // Handle the case where the camera is not available
                            print("Camera not available")
                        }
                    },
                    .default(Text("Photo Library")) {
                        imagePickerSourceType = .photoLibrary
                        isImagePickerPresented = true
                    },
                    .cancel()
                ])
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(sourceType: imagePickerSourceType) { image in
                    viewModel.profileImage = image
                    viewModel.uploadProfileImage(image: image)
                }
            }
        }
    }

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let userAuth = UserAuth() // Create a dummy UserAuth
        ProfileView(userAuth: userAuth) // Pass it to ProfileView
    }
}


