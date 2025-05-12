//
//  ProfileAndSettingsView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 08/05/2025.
//

import SwiftUI
import FirebaseAuth
import PhotosUI

struct ProfileAndSettingsView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true
    @AppStorage("storedProfileImage") private var storedProfileImageData: String = ""
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: UIImage? = nil
    @State private var userEmail: String = ""
    @State private var accountCreationYear: String = ""

    let defaultImage = UIImage(named: "PersonProfilePicture")!

    var body: some View {
        ZStack {
            Color(AppColor.grayBackground)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                ZStack {
                    BackgroundSecondaryView(title: "Perfil", onBackButtonTap: {})

                    VStack {
                        ZStack(alignment: .topTrailing) {
                            if let profileImage = profileImage {
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 287)
                                    .cornerRadius(16)
                                    .frame(maxWidth: .infinity)
                            } else {
                                Image("PersonProfilePicture")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 287)
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

                                        Text(accountCreationYear)
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

                        Text("Email")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 18))
                            .padding(.top, 24)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(userEmail)
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
            if let data = Data(base64Encoded: storedProfileImageData),
               let uiImage = UIImage(data: data) {
                profileImage = uiImage
            }

            if let email = Auth.auth().currentUser?.email {
                userEmail = email
            }

            if let user = Auth.auth().currentUser {
                user.reload { _ in
                    if let creationDate = user.metadata.creationDate {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy"
                        accountCreationYear = formatter.string(from: creationDate)
                    }
                }
            }
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    profileImage = uiImage
                    storedProfileImageData = data.base64EncodedString()
                }
            }
        }
    }
}

#Preview {
    ProfileAndSettingsView()
}
