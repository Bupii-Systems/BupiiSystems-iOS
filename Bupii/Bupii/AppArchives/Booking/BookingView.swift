//
//  BookingView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 29/04/2025.
//

import SwiftUI

//MARK: Full view
struct BookingView: View {
    
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

    var body: some View {
        ZStack {
            Color(AppColor.grayBackground)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                ZStack {
                    BackgroundSecondaryView(title: "Marcar agendamento", onBackButtonTap: {
                        print("tapped")
                    })

                    VStack {
                        Text("Selecione o local")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 16))
                            .padding(.top, 141)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        GenericDropDown(leftImageName: "LocationColor", options: ["Address 1", "Address 2"], placeholder: "Address 1")
                            .padding(.top, 24)

                        Text("Escolha o profissional para atendê-lo")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 16))
                            .padding(.top, 24)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        BookingBuild1View(selectedItemIndex: $selectedItemIndex, checkBoxState: $checkBoxState)
                            .padding(.top, 24)

                        HStack {
                            Button(action: {
                                checkBoxState.toggle()
                                if checkBoxState {
                                    selectedItemIndex = nil
                                }
                            }) {
                                Image(checkBoxState ? "CheckBoxFull" : "CheckBoxEmpty")
                                    .renderingMode(.template)
                                    .padding(.leading, 16)
                                    .foregroundStyle(checkBoxState ? Color(AppColor.brand) : Color(AppColor.text))
                            }
                            Text("Não tenho preferência por profissional")
                                .padding(.trailing, 16)
                                .font(.custom("Inter-Regular", size: 14))
                                .foregroundStyle(AppColor.text)

                            Spacer()
                        }

                        Text("Selecione os serviços que deseja")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 16))
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
                                                let allSelected = selectedServices[1...].allSatisfy { $0 }
                                                selectedServices[0] = allSelected
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
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 16))
                            .padding(.top, 24)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        GenericDropDown(leftImageName: "Calendar", options: [], placeholder: "Selecione a data disponível")
                            .padding(.top, 24)
                        
                        Text("Selecione o horário")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 16))
                            .padding(.top, 24)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        GenericDropDown(leftImageName: "Clock", options: [], placeholder: "Selecione o horário disponível")
                            .padding(.top, 24)
                        
                        MainButton(buttonText: "Reservar meu horário", action: {
                            print("tapped")
                        })
                        .padding(.top, 48)
                        Spacer()
                            .frame(height: 60)
                    }
                    .ignoresSafeArea()
                }
            }
            .ignoresSafeArea()
        }
    }
}

//MARK: Code split into components

//use case you need to update details of carousel
struct CarouselBookingView: View {
    @Binding var selectedItemIndex: Int?
    @Binding var checkBoxState: Bool
    let images: [String]
    let names: [String]
    let gridItems = [GridItem(.fixed(138))]

    var body: some View {
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

//This part it's for put the bottom (< TEXT >) and the carousel together
struct BookingBuild1View: View {
    @Binding var selectedItemIndex: Int?
    @Binding var checkBoxState: Bool

    let images = ["Person1", "Person2", "Person3", "Person4"]
    let names = ["Pedro Santos", "João Silva", "Maria Oliveira", "Alberto Costa"]

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    if let index = selectedItemIndex, index > 0 {
                        selectedItemIndex = index - 1
                    } else if selectedItemIndex == nil {
                        selectedItemIndex = 0
                    }
                }) {
                    Image("ArrowLeft")
                        .padding(.leading, 16)
                }
                .disabled(checkBoxState)

                Text(
                    checkBoxState
                    ? "Sem preferência"
                    : (selectedItemIndex != nil ? names[selectedItemIndex!] : "Selecione o profissional")
                )
                .foregroundStyle(Color(AppColor.brand))
                .font(.custom("Inter-Bold", size: 18))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 4)

                Button(action: {
                    if let index = selectedItemIndex, index < images.count - 1 {
                        selectedItemIndex = index + 1
                    } else if selectedItemIndex == nil {
                        selectedItemIndex = 0
                    }
                }) {
                    Image("ArrowRight")
                        .padding(.trailing, 16)
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

//use case you need to update the rectangle with the services
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
