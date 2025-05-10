//
//  ProfileAndSettingsView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 08/05/2025.
//

import SwiftUI
import FirebaseAuth
import PhotosUI
import FirebaseStorage
import FirebaseFirestore

struct ProfileAndSettingsView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true
    @State private var appointments: [Appointment] = []
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: UIImage? = nil

    var body: some View {
        ZStack {
            Color(AppColor.grayBackground)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                ZStack {
                    BackgroundSecondaryView(title: "Perfil", onBackButtonTap: {
                        print("")
                    })

                    VStack {
                        ZStack(alignment: .topTrailing) {
                            if let profileImage = profileImage {
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(16)
                                    .frame(maxWidth: .infinity)
                            } else {
                                Image("PersonProfilePicture")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(16)
                                    .frame(maxWidth: .infinity)
                            }

                            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                                Image("EditIcon")
                                    .renderingMode(.template)
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(Color(AppColor.text))
                                    .background(Color(.white))
                                    .clipShape(Circle())
                            }
                            .padding(12)
                        }

                        Text("Pedro Santos")
                            .font(.custom("Inter-Bold", size: 20))
                            .foregroundStyle(.brand)
                            .padding(.top, 27)

                        Rectangle()
                            .frame(height: 67)
                            .foregroundColor(Color.white)
                            .cornerRadius(8)
                            .padding(.top, 24)
                            .padding(.horizontal, 16)
                            .overlay(
                                HStack(spacing: 12) {
                                    VStack {
                                        Text("Cliente desde")
                                            .font(.custom("Inter-Regular", size: 16))
                                            .foregroundColor(AppColor.text)

                                        Text("2024")
                                            .font(.custom("Inter-Bold", size: 16))
                                            .foregroundColor(AppColor.brand)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.top, 20)

                                    Rectangle()
                                        .fill(AppColor.text)
                                        .frame(width: 1, height: 55)
                                        .padding(.top, 24)

                                    VStack {
                                        Text("Marcou presença")
                                            .font(.custom("Inter-Regular", size: 16))
                                            .foregroundColor(AppColor.text)

                                        Text("18 vezes")
                                            .font(.custom("Inter-Bold", size: 16))
                                            .foregroundColor(AppColor.brand)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.top, 20)
                                }
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                            )

                        Text("Login")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 18))
                            .padding(.top, 24)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("pedroriibeiro.dev@gmail.com")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-regular", size: 16))
                            .padding(.top, 8)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("Tipo de plano:")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 18))
                            .padding(.top, 24)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("Premium")
                            .foregroundStyle(Color(AppColor.brand))
                            .font(.custom("Inter-regular", size: 16))
                            .padding(.top, 8)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("Tipo de registro:")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 18))
                            .padding(.top, 24)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("Cliente")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-regular", size: 16))
                            .padding(.top, 8)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("Agradecemos por você ser o nosso cliente!")
                            .foregroundStyle(Color(AppColor.brand))
                            .font(.custom("Inter-Bold", size: 16))
                            .padding(.top, 24)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .center)

                        SecondaryButton(buttonText: "Encerrar sessão", action: {
                            try? Auth.auth().signOut()
                            isLoggedIn = false
                        })
                        .padding(.top, 24)

                        Spacer().frame(height: 160)
                    }
                    .ignoresSafeArea()
                    .padding(.top, 98)
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            fetchProfileImage()
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    profileImage = uiImage
                    uploadProfileImage(uiImage) { result in
                        switch result {
                        case .success(let url): print("Upload saved. success: \(url)")
                        case .failure(let error): print("Error to save the image: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }

    func fetchProfileImage() {
        guard let userID = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { snapshot, error in
            if let data = snapshot?.data(),
               let urlString = data["profileImageUrl"] as? String,
               let url = URL(string: urlString) {
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            profileImage = image
                        }
                    }
                }.resume()
            }
        }
    }

    func uploadProfileImage(_ image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid,
              let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }

        let storageRef = Storage.storage().reference().child("profileImages/\(userID).jpg")

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        storageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard metadata != nil else {
                completion(.failure(NSError(domain: "UploadError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Metadata is nil after upload."])))
                return
            }

            fetchDownloadURLWithRetry(from: storageRef, retries: 3, delay: 1, completion: completion)
        }
    }

    private func fetchDownloadURLWithRetry(from ref: StorageReference, retries: Int, delay: TimeInterval, completion: @escaping (Result<URL, Error>) -> Void) {
        ref.downloadURL { url, error in
            if let url = url {
                if let userID = Auth.auth().currentUser?.uid {
                    let db = Firestore.firestore()
                    db.collection("users").document(userID).setData(
                        ["profileImageUrl": url.absoluteString],
                        merge: true
                    )
                }
                completion(.success(url))
            } else if retries > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    fetchDownloadURLWithRetry(from: ref, retries: retries - 1, delay: delay, completion: completion)
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}

#Preview {
    ProfileAndSettingsView()
}
