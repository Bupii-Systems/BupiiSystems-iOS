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

struct MyAgendaView: View {
    @State private var appointments: [Appointment] = []

    var body: some View {
        ZStack {
            Color(AppColor.grayBackground).ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                ZStack {
                    BackgroundSecondaryView(title: "Minha agenda", onBackButtonTap: {})

                    VStack {
                        Text("Meus agendamentos:")
                            .font(.custom("Inter-Bold", size: 16))
                            .foregroundStyle(Color(AppColor.text))
                            .padding(.top, 141)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        if appointments.isEmpty {
                            Text("Nenhum agendamento encontrado.")
                                .font(.custom("Inter-Regular", size: 16))
                                .foregroundStyle(.gray)
                                .padding(.top, 24)
                        } else {
                            ScrollViewReader { proxy in
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 16) {
                                        ForEach(sortedAppointments(), id: \.id) { appointment in
                                            AppointmentCard(appointment: appointment) {
                                                if let id = appointment.id {
                                                    deleteAppointment(id: id)
                                                }
                                            }
                                            .frame(width: UIScreen.main.bounds.width - 32)
                                            .id(appointment.id)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                                .padding(.top, 19)
                                .onAppear {
                                    if let closest = appointmentClosestToNow(),
                                       let id = closest.id {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            withAnimation {
                                                proxy.scrollTo(id, anchor: .center)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Text("Produtos vendidos nessa unidade:")
                            .font(.custom("Inter-Bold", size: 16))
                            .foregroundStyle(Color(AppColor.text))
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
        .onAppear { fetchAppointments() }
    }

    func fetchAppointments() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("appointments")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, _ in
                let newAppointments = snapshot?.documents.compactMap { doc -> Appointment? in
                    var appointment = try? doc.data(as: Appointment.self)
                    appointment?.id = doc.documentID
                    return appointment
                } ?? []

                DispatchQueue.main.async {
                    appointments = newAppointments
                }
            }
    }

    func deleteAppointment(id: String) {
        if let index = appointments.firstIndex(where: { $0.id == id }) {
            appointments.remove(at: index)
        }

        Firestore.firestore().collection("appointments").document(id).delete { error in
            if let error = error {
                print("Eror to delete appointment: \(error.localizedDescription)")
                fetchAppointments()
            }
        }
    }

    func sortedAppointments() -> [Appointment] {
        appointments.sorted {
            guard let date1 = combinedDate(from: $0),
                  let date2 = combinedDate(from: $1) else { return false }
            return date1 < date2
        }
    }

    func appointmentClosestToNow() -> Appointment? {
        let now = Date()
        return sortedAppointments().min(by: {
            guard let date1 = combinedDate(from: $0),
                  let date2 = combinedDate(from: $1) else { return false }
            return abs(date1.timeIntervalSince(now)) < abs(date2.timeIntervalSince(now))
        })
    }

    func combinedDate(from appointment: Appointment) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.date(from: "\(appointment.date) \(appointment.time)")
    }
}

struct AppointmentCard: View {
    let appointment: Appointment
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: { print("Editar tapped") }) {
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
                .fill(Color(AppColor.brand))
                .frame(height: 1)
                .frame(width: 52)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 36)

            Group {
                Text(appointment.services.joined(separator: ", "))
                    .font(.custom("Inter-Bold", size: 18))
                    .foregroundStyle(Color(AppColor.text))
                    .padding(.top, 24)
                    .padding(.leading, 16)

                iconRow("LocationColor", appointment.location)
                    .padding(.top, 24)
                    .padding(.horizontal, 16)

                Text(appointment.address)
                    .font(.custom("Inter-Regular", size: 16))
                    .foregroundStyle(Color(AppColor.text))
                    .padding(.leading, 48)
                    .padding(.trailing, 16)

                iconRow("Calendar", "Data: \(appointment.date)")
                    .padding(.top, 24)
                    .padding(.horizontal, 16)

                iconRow("Clock", "Horário: \(appointment.time)")
                    .padding(.top, 24)
                    .padding(.horizontal, 16)

                iconRow("Person", "Profissional: \(appointment.professional)")
                    .padding(.top, 24)
                    .padding(.horizontal, 16)
            }

            SecondaryButtonRed(buttonText: "Cancelar agendamento", action: onDelete)
                .padding(.top, 24)
        }
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 1)
        )
        .padding(.horizontal, 0)
    }

    @ViewBuilder
    private func iconRow(_ iconName: String, _ text: String) -> some View {
        HStack(spacing: 4) {
            Image(iconName)
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundStyle(AppColor.brand)
                .frame(width: 26)

            Text(text)
                .font(.custom("Inter-Regular", size: 16))
                .foregroundStyle(Color(AppColor.text))
        }
    }
}
#Preview {
    MyAgendaView()
}

