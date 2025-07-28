//
//  BookingView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 29/04/2025.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

//MARK: Full view
struct BookingView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var shouldNavigateToBooking: Bool
    @Binding var selectedTab: Int

    let names = ["Pedro Santos", "João Silva", "Maria Oliveira", "Alberto Costa"]
    let images = ["Person1", "Person2", "Person3", "Person4"]
    
    var editingAppointment: Appointment?

    @State private var services: [Service] = [
        Service(name: "Selecionar tudo", duration: 0, durationUnit: .minutes, price: 0),
        Service(name: "Cabelo", duration: 40, durationUnit: .minutes, price: 50),
        Service(name: "Barba", duration: 30, durationUnit: .minutes, price: 30),
        Service(name: "Sobrancelha", duration: 15, durationUnit: .minutes, price: 15),
        Service(name: "Progressiva", duration: 2, durationUnit: .hours, price: 200)
    ]

    @State private var selectedServices: [Bool] = Array(repeating: false, count: 5)
    @State private var checkBoxState: Bool = false
    @State private var selectedItemIndex: Int? = nil
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var showConfirmationAlert = false
    @State private var selectedLocation: String = "Address 1"

    var isServiceSelected: Bool {
        selectedServices.indices.contains { $0 != 0 && selectedServices[$0] }
    }

    var body: some View {
        ZStack {
            Color(AppColor.grayBackground).ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                ZStack {
                    BackgroundSecondaryView(title: "Marcar agendamento", onBackButtonTap: {
                        selectedTab = 0
                        dismiss()
                    })

                    VStack {
                        Text("Selecione o local")
                            .font(.custom("Inter-Bold", size: 16))
                            .foregroundStyle(Color(AppColor.text))
                            .padding(.top, 141)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        GenericDropDown(
                            selection: $selectedLocation,
                            leftImageName: "LocationColor",
                            options: ["Address 1", "Address 2"],
                            placeholder: "Address 1"
                        )
                        .padding(.top, 24)

                        Text("Escolha o profissional para atendê-lo")
                            .font(.custom("Inter-Bold", size: 16))
                            .foregroundStyle(Color(AppColor.text))
                            .padding(.top, 24)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        BookingBuild1View(
                            selectedItemIndex: $selectedItemIndex,
                            checkBoxState: $checkBoxState,
                            images: images,
                            names: names
                        )
                        .padding(.top, 24)

                        HStack {
                            Button {
                                checkBoxState.toggle()
                                if checkBoxState { selectedItemIndex = nil }
                            } label: {
                                Image(checkBoxState ? "CheckBoxFull" : "CheckBoxEmpty")
                                    .renderingMode(.template)
                                    .foregroundStyle(checkBoxState ? Color(AppColor.brand) : Color(AppColor.text))
                                    .padding(.leading, 16)
                            }

                            Text("Não tenho preferência por profissional")
                                .font(.custom("Inter-Regular", size: 14))
                                .foregroundStyle(AppColor.text)
                                .padding(.trailing, 16)

                            Spacer()
                        }

                        Text("Selecione os serviços que deseja")
                            .font(.custom("Inter-Bold", size: 16))
                            .foregroundStyle(Color(AppColor.text))
                            .padding(.top, 24)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        let totalPrice = services.indices.reduce(0.0) { acc, index in
                            selectedServices[index] ? acc + services[index].price : acc
                        }

                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(services.indices, id: \.self) { index in
                                let service = services[index]
                                let isMain = index == 0

                                ServiceItemView(
                                    isSelected: Binding(
                                        get: { selectedServices[index] },
                                        set: { newValue in
                                            selectedServices[index] = newValue
                                            if index == 0 {
                                                for i in 1..<selectedServices.count {
                                                    selectedServices[i] = newValue
                                                }
                                            } else {
                                                selectedServices[0] = selectedServices[1...].allSatisfy { $0 }
                                            }
                                        }
                                    ),
                                    label: service.name,
                                    font: .custom(isMain ? "Inter-Regular" : "Inter-Bold", size: isMain ? 16 : 18),
                                    foregroundColor: isMain ? Color(AppColor.brand) : Color(AppColor.text),
                                    subtext: (index > 0 && service.price > 0)
                                        ? "\(service.duration)\(service.durationUnit == .minutes ? "min" : "H") - R$\(Int(service.price))"
                                        : nil
                                )
                            }

                            Text("Total: R$ \(totalPrice, specifier: "%.2f")")
                                .font(.custom("Inter-Bold", size: 18))
                                .foregroundStyle(Color(AppColor.brand))
                                .padding(.horizontal, 18)
                        }
                        .padding(.vertical, 24)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 1)
                        )
                        .padding(.horizontal, 16)
                        .padding(.top, 19)

                        Text("Selecione o local")
                            .font(.custom("Inter-Bold", size: 16))
                            .foregroundStyle(Color(AppColor.text))
                            .padding(.top, 24)
                            .padding(.leading, 16)

                        DateDropDown(selectedDate: $selectedDate, allowedWeekdays: [2, 3, 4, 5, 6])
                            .padding(.top, 24)

                        Text("Selecione o horário")
                            .font(.custom("Inter-Bold", size: 16))
                            .foregroundStyle(Color(AppColor.text))
                            .padding(.top, 24)
                            .padding(.leading, 16)

                        TimeDropDown(selectedTime: $selectedTime, openingHour: 9, closingHour: 20)
                            .padding(.top, 24)

                        MainButton(buttonText: "Reservar meu horário") {
                            if let userId = Auth.auth().currentUser?.uid {
                                let selectedServicesNames = services.indices.compactMap { index in
                                    selectedServices[index] && index != 0 ? services[index].name : nil
                                }

                                let locationName = selectedLocation

                                let locationAddress: String = {
                                    switch selectedLocation {
                                    case "Address 1":
                                        return "Av. Ermano Marchetti, 1234 – Lapa, São Paulo – SP"
                                    case "Address 2":
                                        return "Rua Exemplo, 567 – Centro, São Paulo – SP"
                                    default:
                                        return "Endereço não encontrado"
                                    }
                                }()

                                let appointment = Appointment(
                                    userId: userId,
                                    services: selectedServicesNames,
                                    totalPrice: totalPrice,
                                    date: formatDate(selectedDate),
                                    time: formatTime(selectedTime),
                                    professional: selectedItemIndex != nil ? names[selectedItemIndex!] : "Sem preferência",
                                    location: locationName,
                                    address: locationAddress
                                )

                                saveAppointment(appointment: appointment) { result in
                                    switch result {
                                    case .success(): showConfirmationAlert = true
                                    case .failure(let error): print("Error to save: \(error.localizedDescription)")
                                    }
                                }
                            }
                        }
                        .disabled(!isServiceSelected)
                        .opacity(isServiceSelected ? 1 : 0.8)
                        .padding(.top, 48)

                        Spacer().frame(height: 60)
                    }
                }
            }

            if showConfirmationAlert {
                AlertOneButtonView(
                    message: "Seu agendamento foi confirmado com sucesso!\n\nMuito obrigado!\n\nNos vemos em breve.",
                    buttonText: "Concluir",
                    onButtonTap: {
                        showConfirmationAlert = false
                        shouldNavigateToBooking = false
                        selectedTab = 2
                    }
                )
                .transition(.opacity)
                .zIndex(1)
            }
        }
        .ignoresSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }

    func saveAppointment(appointment: Appointment, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        do {
            _ = try db.collection("appointments").addDocument(from: appointment)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }

    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

//MARK: To put the carousel and the arrow's buttons together
struct BookingBuild1View: View {
    @Binding var selectedItemIndex: Int?
    @Binding var checkBoxState: Bool
    let images: [String]
    let names: [String]
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    if let index = selectedItemIndex, index > 0 {
                        selectedItemIndex = index - 1
                    } else if selectedItemIndex == nil {
                        selectedItemIndex = 0
                    }
                } label: {
                    Image("ArrowLeft").padding(.leading, 16)
                }
                .disabled(checkBoxState)
                
                Text(
                    checkBoxState
                    ? "Sem preferência"
                    : (selectedItemIndex != nil ? names[selectedItemIndex!] : "Selecione o profissional")
                )
                .font(.custom("Inter-Bold", size: 18))
                .foregroundStyle(Color(AppColor.brand))
                .frame(maxWidth: .infinity)
                .padding(.bottom, 4)
                
                Button {
                    if let index = selectedItemIndex, index < images.count - 1 {
                        selectedItemIndex = index + 1
                    } else if selectedItemIndex == nil {
                        selectedItemIndex = 0
                    }
                } label: {
                    Image("ArrowRight").padding(.trailing, 16)
                }
                .disabled(checkBoxState)
            }
            
            CarouselBookingView(
                selectedItemIndex: $selectedItemIndex,
                checkBoxState: $checkBoxState,
                images: images,
                names: names
            )
        }
    }
}

//MARK: Carousel
struct CarouselBookingView: View {
    @Binding var selectedItemIndex: Int?
    @Binding var checkBoxState: Bool
    let images: [String]
    let names: [String]
    
    var body: some View {
        let gridItems = [GridItem(.fixed(138))]
        ScrollViewReader { proxy in
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: gridItems, spacing: 16) {
                        ForEach(images.indices, id: \.self) { index in
                            VStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 22)
                                        .fill(selectedItemIndex == index ? AppColor.brand : Color.clear)
                                        .frame(width: 136, height: 164)
                                        .shadow(color: Color.black.opacity(0.6), radius: 4, x: 0, y: 1)
                                        .overlay(
                                            Image(images[index])
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 139, height: 167)
                                                .padding(.top, 9.5)
                                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                        )
                                }
                                .id(index)
                                .onTapGesture {
                                    if !checkBoxState {
                                        selectedItemIndex = index
                                    }
                                }
                            }
                            .frame(width: 138, height: 167)
                        }
                    }
                    .frame(height: 180)
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 8)
            }
            .onChange(of: selectedItemIndex) { index in
                if let index = index {
                    withAnimation {
                        proxy.scrollTo(index, anchor: .center)
                    }
                }
            }
        }
    }
}

//MARK: White rectangle service to book
struct ServiceItemView: View {
    @Binding var isSelected: Bool
    var label: String
    var font: Font
    var foregroundColor: Color
    var subtext: String?
    
    var body: some View {
        HStack(alignment: .top) {
            Button(action: {
                isSelected.toggle()
            }) {
                Image(isSelected ? "CheckBoxFull" : "CheckBoxEmpty")
                    .renderingMode(.template)
                    .foregroundStyle(isSelected ? Color(AppColor.brand) : Color(AppColor.text))
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text(label)
                    .font(font)
                    .foregroundStyle(foregroundColor)
                
                if let subtext = subtext {
                    Text(subtext)
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundStyle(Color(AppColor.text))
                        .padding(.top, 0)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}
