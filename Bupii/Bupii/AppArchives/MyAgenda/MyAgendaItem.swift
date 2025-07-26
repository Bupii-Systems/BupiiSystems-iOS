//
//  MyAgendaItem.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 25/07/2025.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

// MARK: - ViewModel
final class MyAgendaViewModel: ObservableObject {
    @Published var appointments: [Appointment] = []

    init() {
        fetchAppointments()
    }

    func fetchAppointments() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore()
            .collection("appointments")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { snapshot, error in
                if let documents = snapshot?.documents {
                    DispatchQueue.main.async {
                        self.appointments = documents.compactMap { doc in
                            try? doc.data(as: Appointment.self)
                        }
                    }
                } else {
                    print("Erro ao ouvir agendamentos: \(error?.localizedDescription ?? "Desconhecido")")
                }
            }
    }

    func sortedAppointments() -> [Appointment] {
        appointments.sorted {
            parseDate($0.date) < parseDate($1.date)
        }
    }

    func appointmentClosestToNow() -> Appointment? {
        let now = Date()
        return sortedAppointments().min(by: {
            abs(parseDate($0.date).timeIntervalSince(now)) < abs(parseDate($1.date).timeIntervalSince(now))
        })
    }

    func deleteAppointment(id: String) {
        Firestore.firestore().collection("appointments").document(id).delete { error in
            if let error = error {
                print("Erro ao deletar: \(error.localizedDescription)")
            } else {
                self.appointments.removeAll { $0.id == id }
            }
        }
    }

    private func parseDate(_ string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: string) ?? Date.distantFuture
    }
}

// MARK: - View
struct MyAgendaItem: View {
    @StateObject private var viewModel = MyAgendaViewModel()

    var body: some View {
        VStack {
            Text("Meus agendamentos:")
                .font(.custom("Inter-Bold", size: 16))
                .foregroundStyle(Color(AppColor.text))
                .padding(.top, 141)
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)

            if viewModel.appointments.isEmpty {
                Text("Nenhum agendamento encontrado.")
                    .font(.custom("Inter-Regular", size: 16))
                    .foregroundStyle(.gray)
                    .padding(.top, 24)
            } else {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 16) {
                            ForEach(viewModel.sortedAppointments(), id: \.id) { appointment in
                                AppointmentCard(appointment: appointment) {
                                    if let id = appointment.id {
                                        viewModel.deleteAppointment(id: id)
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
                        if let closest = viewModel.appointmentClosestToNow(),
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
    }
}

#Preview {
    MyAgendaItem()
}
