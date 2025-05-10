//
//  MyAgendaView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 04/05/2025.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

//MARK: Full view
struct MyAgendaView: View {
    @State private var appointments: [Appointment] = []
    
    var body: some View {
        ZStack {
            Color(AppColor.grayBackground)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                ZStack {
                    BackgroundSecondaryView(title: "Minha agenda", onBackButtonTap: {
                        print("")
                    })
                    
                    VStack {
                        Text("Meus agendamentos:")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 16))
                            .padding(.top, 141)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if appointments.isEmpty {
                            Text("Nenhum agendamento encontrado.")
                                .foregroundStyle(.gray)
                                .font(.custom("Inter-Regular", size: 16))
                                .padding(.top, 24)
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            ForEach(appointments, id: \.id) { appointment in
                                VStack(alignment: .leading, spacing: 0) {
                                    Button(action: {
                                        print("Editar tapped")
                                    }) {
                                        HStack(spacing: 4) {
                                            Spacer()
                                            Text("Editar")
                                                .font(.custom("Inter-Regular", size: 16))
                                                .foregroundStyle(AppColor.brand)
                                            Image("EditIcon")
                                                .renderingMode(.template)
                                                .frame(width: 16, height: 16)
                                                .foregroundStyle(AppColor.brand)
                                                .frame(width: 26)
                                        }
                                        .padding(.horizontal, 16)
                                    }
                                    .buttonStyle(.plain)
                                    
                                    Rectangle()
                                        .foregroundColor(Color(AppColor.brand))
                                        .frame(height: 1)
                                        .frame(width: 52)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.trailing, 36)
                                    
                                    Text(appointment.services.joined(separator: ", "))
                                        .foregroundStyle(Color(AppColor.text))
                                        .font(.custom("Inter-Bold", size: 18))
                                        .padding(.top, 24)
                                        .padding(.leading, 16)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack(spacing: 4) {
                                        Image("LocationColor")
                                            .renderingMode(.template)
                                            .frame(width: 24, height: 24)
                                            .foregroundStyle(AppColor.brand)
                                            .frame(width: 26)
                                        
                                        Text(appointment.location)
                                            .font(.custom("Inter-Bold", size: 16))
                                            .foregroundStyle(AppColor.text)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.top, 24)
                                    
                                    Text(appointment.address)
                                        .foregroundStyle(Color(AppColor.text))
                                        .font(.custom("Inter-Regular", size: 16))
                                        .padding(.leading, 48)
                                        .padding(.trailing, 16)
                                        .padding(.top, 0)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack(spacing: 4) {
                                        Image("Calendar")
                                            .renderingMode(.template)
                                            .frame(width: 24, height: 24)
                                            .foregroundStyle(AppColor.brand)
                                            .frame(width: 26)
                                        
                                        Text("Data:")
                                            .font(.custom("Inter-Bold", size: 16))
                                            .foregroundStyle(AppColor.text)
                                        
                                        Text(appointment.date)
                                            .font(.custom("Inter-Regular", size: 16))
                                            .foregroundStyle(AppColor.text)
                                    }
                                    .padding(.top, 24)
                                    .padding(.horizontal, 16)
                                    
                                    HStack(spacing: 4) {
                                        Image("Clock")
                                            .renderingMode(.template)
                                            .frame(width: 24, height: 24)
                                            .foregroundStyle(AppColor.brand)
                                            .frame(width: 26)
                                        
                                        Text("Horário:")
                                            .font(.custom("Inter-Bold", size: 16))
                                            .foregroundStyle(AppColor.text)
                                        
                                        Text(appointment.time)
                                            .font(.custom("Inter-Regular", size: 16))
                                            .foregroundStyle(AppColor.text)
                                    }
                                    .padding(.top, 24)
                                    .padding(.horizontal, 16)
                                    
                                    HStack(spacing: 4) {
                                        Image("Person")
                                            .renderingMode(.template)
                                            .frame(width: 24, height: 24)
                                            .foregroundStyle(AppColor.brand)
                                            .frame(width: 26)
                                        
                                        Text("Profissional:")
                                            .font(.custom("Inter-Bold", size: 16))
                                            .foregroundStyle(AppColor.text)
                                        
                                        Text(appointment.professional)
                                            .font(.custom("Inter-Regular", size: 16))
                                            .foregroundStyle(AppColor.text)
                                    }
                                    .padding(.top, 24)
                                    .padding(.horizontal, 16)
                                    
                                    SecondaryButtonRed(buttonText: "Cancelar agendamento", action: {
                                        if let id = appointment.id {
                                            deleteAppointment(id: id)
                                        }
                                    })
                                    .padding(.top, 24)
                                    .foregroundStyle(.red)
                                }
                                .padding(.vertical, 24)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white)
                                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 1)
                                )
                                .padding(.horizontal, 16)
                                .padding(.top, 19)
                            }
                        }
                        
                        Text("Produtos vendidos nessa unidade:")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 16))
                            .padding(.top, 24)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ProductGridView()
                        
                        Spacer().frame(height: 160)
                    }
                    .ignoresSafeArea()
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            fetchAppointments()
        }
    }
    
    //MARK: Functions appointments
    func fetchAppointments() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("appointments")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let documents = snapshot?.documents {
                    appointments = documents.compactMap { doc in
                        try? doc.data(as: Appointment.self)
                    }
                }
            }
    }
    func deleteAppointment(id: String) {
        Firestore.firestore().collection("appointments").document(id).delete { error in
            if let error = error {
                print("Erro ao deletar agendamento: \(error.localizedDescription)")
            } else {
                fetchAppointments()
            }
        }
    }
}

#Preview {
    MyAgendaView()
}
